static const char norm_fg[] = "#dde0e7";
static const char norm_bg[] = "#1C2023";
static const char norm_border[] = "#9a9ca1";

static const char sel_fg[] = "#dde0e7";
static const char sel_bg[] = "#9399AE";
static const char sel_border[] = "#dde0e7";

static const char urg_fg[] = "#dde0e7";
static const char urg_bg[] = "#75A8CC";
static const char urg_border[] = "#75A8CC";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
