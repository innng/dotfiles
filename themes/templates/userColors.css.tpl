:root {
	--dark_color1: {{ color0 }};
	--dark_color2: {{ background }};
	--dark_color3: {{ color8 }};
	--dark_color4: {{ color0 }};

	--word_color1: {{ color13 }};
	--word_color2: {{ color15 }};
	--word_color3: {{ foreground }};

	--light_color1: {{ color7 }};
	--light_color2: {{ color14 }};
	--light_color3: {{ color6 }};
	--light_color4: {{ color15 }};

	--other_color1: {{ accent }};
	--other_color2: {{ color5 }};
	--other_color3: {{ foreground }};
}

/*================ LIGHT THEME ================*/
:root:not([style]),
:root[style*="--lwt-accent-color:rgb(227, 228, 230);"] {
	--base_color1: var(--light_color1);
	--base_color2: var(--light_color2);
	--base_color3: var(--light_color3);
	--base_color4: var(--light_color4);

	--outer_color1: var(--other_color1);
	--outer_color2: var(--other_color2);
	--outer_color3: var(--other_color3);

	--orbit_color: var(--dark_color3);
}

/*================ DARK THEME ================*/
:root[style*="--lwt-accent-color:rgb(12, 12, 13);"] {
	--base_color1: var(--dark_color1);
	--base_color2: var(--dark_color2);
	--base_color3: var(--dark_color3);
	--base_color4: var(--dark_color4);

	--outer_color1: var(--word_color1);
	--outer_color2: var(--word_color2);
	--outer_color3: var(--word_color3);

	--orbit_color: var(--light_color3);
}

/*============== PRIVATE THEME ==============*/
:root[privatebrowsingmode=temporary] {
	--base_color1: {{ color8 }};
	--base_color2: {{ color4 }};
	--base_color3: {{ color5 }};
	--base_color4: {{ color12 }};

	--outer_color1: {{ color1 }};
	--outer_color2: {{ color13 }};
	--outer_color3: {{ foreground }};

	--orbit_color: {{ color8 }};
}