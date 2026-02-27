#!/bin/bash
#
# Arch Linux Hyprland Dotfiles Installer
# Automates the setup of the dotfiles for Hyprland + Catppuccin Mocha
#
# Usage: bash INSTALL.sh
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory (where this script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"
PACKAGES_FILE="$DOTFILES_DIR/extra/PACKAGES.lst"

# ============================================================
# Helper Functions
# ============================================================

print_banner() {
    clear
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════════════╗"
    echo "║   Arch Linux Hyprland Dotfiles Installer          ║"
    echo "║   Catppuccin Mocha Edition                        ║"
    echo "╚════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_section() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# ============================================================
# Pre-flight Checks
# ============================================================

check_prerequisites() {
    print_section "Checking Prerequisites"

    # Check if running on Arch Linux
    if ! command -v pacman &> /dev/null; then
        print_error "This installer is for Arch Linux only"
        print_error "Pacman package manager not found"
        exit 1
    fi
    print_success "Arch Linux detected"

    # Check if running as non-root (we'll use sudo for package installation)
    if [ "$EUID" -eq 0 ]; then
        print_error "Please do not run this script as root"
        print_error "Use: bash INSTALL.sh (sudo will be requested when needed)"
        exit 1
    fi
    print_success "Running as regular user"

    # Check sudo access
    if ! sudo -n true 2>/dev/null; then
        print_warning "Sudo requires password. You may be prompted during installation."
    else
        print_success "Sudo access confirmed"
    fi

    # Check if yay is installed (for AUR packages)
    if ! command -v yay &> /dev/null; then
        print_warning "yay (AUR helper) not found"
        print_info "Some packages will fail to install without yay"
        print_info "Install yay first: https://github.com/Jguer/yay"
        print_info ""
        read -p "Continue anyway? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    else
        print_success "yay AUR helper found"
    fi

    # Check git
    if ! command -v git &> /dev/null; then
        print_error "Git is required but not installed"
        exit 1
    fi
    print_success "Git is installed"

    # Check zsh
    if ! command -v zsh &> /dev/null; then
        print_warning "Zsh not found. It will be installed."
    else
        print_success "Zsh is installed"
    fi
}

# ============================================================
# Backup Existing Configs
# ============================================================

backup_existing_configs() {
    print_section "Backing Up Existing Configurations"

    local backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

    if [ -d "$HOME/.config" ]; then
        print_warning "Existing ~/.config directory detected"
        read -p "Create backup at $backup_dir? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "$backup_dir"
            cp -r "$HOME/.config" "$backup_dir/config"
            print_success "Backup created at $backup_dir"
        else
            print_warning "Skipping backup. Existing files may be overwritten."
        fi
    else
        print_info "No existing ~/.config directory found"
    fi

    if [ -f "$HOME/.zshenv" ]; then
        print_warning "Existing ~/.zshenv found"
        cp "$HOME/.zshenv" "$HOME/.zshenv.backup"
        print_info "Backed up to ~/.zshenv.backup"
    fi

    if [ -f "$HOME/.zprofile" ]; then
        print_warning "Existing ~/.zprofile found"
        cp "$HOME/.zprofile" "$HOME/.zprofile.backup"
        print_info "Backed up to ~/.zprofile.backup"
    fi
}

# ============================================================
# Install Packages
# ============================================================

install_packages() {
    print_section "Installing Packages"

    # Check if package list exists
    if [ ! -f "$PACKAGES_FILE" ]; then
        print_error "Package list not found: $PACKAGES_FILE"
        exit 1
    fi

    # Extract package names (skip comments and empty lines)
    local packages=$(grep -v '^#' "$PACKAGES_FILE" | grep -v '^$' | tr '\n' ' ')

    if [ -z "$packages" ]; then
        print_error "No packages found in $PACKAGES_FILE"
        exit 1
    fi

    print_info "Total packages to install: $(echo "$packages" | wc -w)"
    print_info "This may take 15-30 minutes depending on system and AUR builds"
    echo ""

    read -p "Continue with installation? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Installation skipped"
        return 1
    fi

    # Install with pacman/yay
    print_info "Installing packages..."
    if command -v yay &> /dev/null; then
        sudo yay -S --noconfirm $packages
    else
        # Fallback to pacman (will fail on AUR packages, but that's okay)
        sudo pacman -S --noconfirm $packages 2>/dev/null || \
            print_warning "Some packages failed to install (likely AUR packages)"
    fi

    print_success "Package installation complete"
    return 0
}

# ============================================================
# Generate Theme Files
# ============================================================

generate_theme() {
    print_section "Generating Theme Configuration Files"
    
    local theme_script="$DOTFILES_DIR/extra/theme/generate-theme.sh"
    
    # Check if theme script exists
    if [ ! -f "$theme_script" ]; then
        print_error "Theme generator not found: $theme_script"
        return 1
    fi
    
    # Run theme generator
    print_info "Generating application-specific color configurations..."
    bash "$theme_script"
    
    if [ $? -eq 0 ]; then
        print_success "Theme files generated successfully"
        return 0
    else
        print_error "Theme generation failed"
        return 1
    fi
}

# ============================================================
# Setup Shell Configuration
# ============================================================

setup_shell_config() {
    print_section "Configuring Shell Environment"

    # Create or update ~/.zshenv
    if [ ! -f "$HOME/.zshenv" ]; then
        print_info "Creating ~/.zshenv"
        cat > "$HOME/.zshenv" << 'EOF'
# Zsh environment configuration
# Point Zsh to dotfiles directory
export ZDOTDIR="$HOME/.dots/.config/zsh"
EOF
        print_success "Created ~/.zshenv with ZDOTDIR configuration"
    else
        # Check if ZDOTDIR is already set
        if grep -q "ZDOTDIR" "$HOME/.zshenv"; then
            print_info "ZDOTDIR already configured in ~/.zshenv"
        else
            print_warning "Adding ZDOTDIR to existing ~/.zshenv"
            echo "" >> "$HOME/.zshenv"
            echo "# Added by dotfiles installer" >> "$HOME/.zshenv"
            echo 'export ZDOTDIR="$HOME/.dots/.config/zsh"' >> "$HOME/.zshenv"
            print_success "Updated ~/.zshenv"
        fi
    fi

    # Check current shell
    local current_shell=$(echo $SHELL)
    if [ "$current_shell" = "/bin/zsh" ] || [ "$current_shell" = "/usr/bin/zsh" ]; then
        print_success "Current shell is already Zsh"
    else
        print_warning "Current shell is $current_shell (not Zsh)"
        read -p "Change default shell to Zsh? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            chsh -s /usr/bin/zsh
            print_success "Default shell changed to Zsh"
            print_warning "Please log out and back in for the change to take effect"
        else
            print_warning "Zsh will not be your default shell"
            print_info "You can still use it by running: zsh"
        fi
    fi
}

# ============================================================
# Link Configuration
# ============================================================

link_configs() {
    print_section "Linking Configurations"

    # Create symlink for .config if needed
    if [ ! -L "$HOME/.config" ]; then
        if [ -d "$HOME/.config" ]; then
            print_warning "~/.config is a directory, not a symlink"
            read -p "Replace with symlink to ~/.dots/.config? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                # Backup first
                mv "$HOME/.config" "$HOME/.config.bak"
                ln -s "$DOTFILES_DIR/.config" "$HOME/.config"
                print_success "Created symlink: ~/.config → ~/.dots/.config"
            fi
        else
            ln -s "$DOTFILES_DIR/.config" "$HOME/.config"
            print_success "Created symlink: ~/.config → ~/.dots/.config"
        fi
    else
        # Check if it points to the right place
        local target=$(readlink "$HOME/.config")
        if [ "$target" = "$DOTFILES_DIR/.config" ]; then
            print_success "~/.config already points to ~/.dots/.config"
        else
            print_warning "~/.config points to: $target"
        fi
    fi
}

# ============================================================
# Verify Installation
# ============================================================

verify_installation() {
    print_section "Verifying Installation"

    local errors=0

    # Check ZDOTDIR
    if grep -q "ZDOTDIR" "$HOME/.zshenv" 2>/dev/null; then
        print_success "ZDOTDIR configured"
    else
        print_error "ZDOTDIR not found in ~/.zshenv"
        ((errors++))
    fi

    # Check if Hyprland is installed
    if command -v Hyprland &> /dev/null; then
        print_success "Hyprland is installed"
    else
        print_warning "Hyprland not found (may still be installing)"
    fi

    # Check if Kitty is installed
    if command -v kitty &> /dev/null; then
        print_success "Kitty is installed"
    else
        print_warning "Kitty not found (may still be installing)"
    fi

    # Check if Zsh is installed
    if command -v zsh &> /dev/null; then
        print_success "Zsh is installed"
    else
        print_error "Zsh not found"
        ((errors++))
    fi

    # Check fonts
    if fc-list | grep -q -i "mononoki"; then
        print_success "Mononoki font is installed"
    else
        print_warning "Mononoki font not found"
    fi

    # Check dotfiles directory
    if [ -d "$DOTFILES_DIR/.config" ]; then
        local config_count=$(find "$DOTFILES_DIR/.config" -type f | wc -l)
        print_success "Found $config_count configuration files"
    else
        print_error "Dotfiles .config directory not found"
        ((errors++))
    fi

    return $errors
}

# ============================================================
# Summary and Next Steps
# ============================================================

print_summary() {
    print_section "Installation Summary"

    cat << EOF

✓ Installation complete!

Next steps:
  1. Log out completely and log back in
  2. Select Hyprland at the login screen
  3. Hyprland will start with Catppuccin Mocha theme

To test immediately (if already in a desktop environment):
  - Start a new Zsh shell: zsh
  - Launch Hyprland: exec Hyprland

Configuration locations:
  - Hyprland: ~/.dots/.config/hypr/
  - Terminal: ~/.dots/.config/kitty/
  - Shell: ~/.dots/.config/zsh/
  - Theme colors: ~/.dots/extra/colors/catppuccin-mocha.toml

For detailed setup instructions, see: ~/.dots/SETUP.md

Keybindings:
  - Super + Return: Terminal
  - Super + D: Launcher
  - Super + M: Exit Hyprland
  - Super + Q: Close window

To customize configurations, edit files in ~/.dots/.config/

EOF
    
    print_success "Happy coding! 🚀"
}

# ============================================================
# Main Installation Flow
# ============================================================

main() {
    print_banner

    # Step 1: Check prerequisites
    check_prerequisites

    # Step 2: Backup existing configs
    backup_existing_configs

    # Step 3: Install packages
    if ! install_packages; then
        print_warning "Packages were not installed. Continuing with setup..."
    fi

    # Step 4: Generate theme files
    if ! generate_theme; then
        print_warning "Theme generation failed. Continuing with setup..."
    fi

    # Step 5: Setup shell
    setup_shell_config

    # Step 6: Link configs
    link_configs

    # Step 7: Verify installation
    if verify_installation; then
        print_error "Some verification checks failed"
        print_info "Review the errors above"
    fi

    # Step 8: Print summary
    print_summary
}

# Run main function
main "$@"
