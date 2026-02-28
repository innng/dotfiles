return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true, -- Show hidden/dotfiles
            ignored = false, -- Respect .gitignore
          },
          grep = {
            hidden = true, -- Also search in hidden files
            ignored = false,
          },
        },
      },
    },
  },
}
