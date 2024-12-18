local wezterm = require("wezterm")
wezterm.on(
    "update-right-status",
    function(window, pane)
        window:set_right_status(window:active_workspace())
    end
)

local config = {
    --automatically_reload_config = false,

    color_scheme = "zenbones_dark",
    colors = {
        background = "black",
        foreground = "white",
        cursor_bg = "white",
        cursor_fg = "black",
    },

    use_fancy_tab_bar = false,
    window_decorations = "RESIZE",
    show_update_window = false,
    enable_scroll_bar = false,
    inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
    window_padding = {
      left = "1cell",
      right = "1cell",
      top = "0.5cell",
      bottom = "0.5cell",
    },

    --freetype_load_flags = "DEFAULT",
    --freetype_load_flags = "NO_HINTING",
    --freetype_load_flags = "NO_HINTING|MONOCHROME",
    --freetype_load_flags = "FORCE_AUTOHINT",

    --freetype_load_target = "Normal",
    --freetype_load_target = "Light",
    --freetype_load_target = "Mono",
    --freetype_load_target = "HorizontalLcd",

    --freetype_render_target = "Normal",
    --freetype_render_target = "Light",
    --freetype_render_target = "Mono",
    --freetype_render_target = "HorizontalLcd",

    freetype_interpreter_version = 40,
    font = wezterm.font("CommitMono", {weight="Regular", stretch="Normal", style="Normal"}),
    freetype_load_flags = "NO_HINTING",
    -- Use grayscale anti-aliasing.
    freetype_render_target = "Normal",
    font_size = 13,

    front_end = "OpenGL",
    prefer_egl = true,

    default_domain = "local",
    wsl_domains = {},

    disable_default_key_bindings = true,
    leader = { key = "a", mods = "CTRL" },
    keys = {
        { key = "w", mods = "LEADER", action = wezterm.action.SwitchToWorkspace},
        { key = "n", mods = "LEADER", action = wezterm.action.SwitchWorkspaceRelative(1)},
        { key = "p", mods = "LEADER", action = wezterm.action.SwitchWorkspaceRelative(-1)},

        { key = "v", mods = "LEADER", action = wezterm.action{ SplitHorizontal = { domain = "CurrentPaneDomain" }}},
        { key = "s", mods = "LEADER", action = wezterm.action{ SplitVertical   = { domain = "CurrentPaneDomain" }}},
        { key = "h", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Left"  }},
        { key = "j", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Down"  }},
        { key = "k", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Up"    }},
        { key = "l", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Right" }},
        { key = "H", mods = "LEADER", action = wezterm.action{ AdjustPaneSize = {"Left",  5}}},
        { key = "J", mods = "LEADER", action = wezterm.action{ AdjustPaneSize = {"Down",  5}}},
        { key = "K", mods = "LEADER", action = wezterm.action{ AdjustPaneSize = {"Up",    5}}},
        { key = "L", mods = "LEADER", action = wezterm.action{ AdjustPaneSize = {"Right", 5}}},
        { key = "c", mods = "LEADER", action = wezterm.action{ SpawnTab = "CurrentPaneDomain" }},

        { key = "1", mods = "LEADER", action = wezterm.action{ ActivateTab = 0 }},
        { key = "2", mods = "LEADER", action = wezterm.action{ ActivateTab = 1 }},
        { key = "3", mods = "LEADER", action = wezterm.action{ ActivateTab = 2 }},
        { key = "4", mods = "LEADER", action = wezterm.action{ ActivateTab = 3 }},
        { key = "5", mods = "LEADER", action = wezterm.action{ ActivateTab = 4 }},
        { key = "6", mods = "LEADER", action = wezterm.action{ ActivateTab = 5 }},
        { key = "7", mods = "LEADER", action = wezterm.action{ ActivateTab = 6 }},
        { key = "8", mods = "LEADER", action = wezterm.action{ ActivateTab = 7 }},
        { key = "9", mods = "LEADER", action = wezterm.action{ ActivateTab = 8 }},
        { key = "0", mods = "LEADER", action = wezterm.action{ ActivateTab = 9 }},

        { key = "1", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(0)},
        { key = "2", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(1)},
        { key = "3", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(2)},
        { key = "4", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(3)},
        { key = "5", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(4)},
        { key = "6", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(5)},
        { key = "7", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(6)},
        { key = "8", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(7)},
        { key = "9", mods = "LEADER|CTRL", action = wezterm.action.MoveTab(8)},

        { key = "c", mods = "CTRL|SHIFT", action = wezterm.action{ CopyTo    = "Clipboard" }},
        { key = "v", mods = "CTRL|SHIFT", action = wezterm.action{ PasteFrom = "Clipboard" }},
    },
}

local local_overrides = require "local-overrides"
for key, value in pairs(local_overrides)
do
    config[key] = value
end

return config

