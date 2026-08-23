-- Minimal default Hyprland config (Fedora Atomic / hyprland-nvidia image)
-- Bootstrap config: fresh users get a working session, then override with
-- their own ~/.config/hypr/hyprland.lua. Keybinds follow the established
-- scheme: SUPER for WM, SUPER+SHIFT for windows/apps, hjkl + arrows for
-- directions.

hl.config({
  scrolling = {
    direction    = "right",
    column_width = 0.5,
  },
})

-- Autostart: bar + idle daemon
hl.on("start", function()
  hl.spawn("noctalia")
  hl.spawn("hypridle")
end)

-- ── Terminal / apps ──
hl.bind("SUPER SHIFT, t", hl.spawn("kitty"))

-- ── Core WM ──
hl.bind("SUPER SHIFT, q",     hl.dsp.closewindow())
hl.bind("SUPER, f",           hl.dsp.fullscreen())
hl.bind("SUPER SHIFT, space", hl.dsp.togglefloating())
hl.bind("SUPER, r",           hl.dsp.reload())

-- ── Launcher / panels / lock ──
hl.bind("SUPER, space",     hl.spawn("fuzzel"))
hl.bind("SUPER SHIFT, w",   hl.spawn("noctalia msg panel-toggle control-center"))
hl.bind("SUPER, Escape",    hl.spawn("noctalia msg panel-toggle session"))
hl.bind("SUPER, backspace", hl.spawn("hyprlock"))

-- ── Focus direction (hjkl + arrows) ──
hl.bind("SUPER, h",        hl.dsp.movefocus("l"))
hl.bind("SUPER, l",        hl.dsp.movefocus("r"))
hl.bind("SUPER, k",        hl.dsp.movefocus("u"))
hl.bind("SUPER, j",        hl.dsp.movefocus("d"))
hl.bind("SUPER, Left",     hl.dsp.movefocus("l"))
hl.bind("SUPER, Right",    hl.dsp.movefocus("r"))
hl.bind("SUPER, Up",       hl.dsp.movefocus("u"))
hl.bind("SUPER, Down",     hl.dsp.movefocus("d"))

-- ── Swap windows ──
hl.bind("SUPER SHIFT, h",     hl.dsp.swapwindow("l"))
hl.bind("SUPER SHIFT, l",     hl.dsp.swapwindow("r"))
hl.bind("SUPER SHIFT, k",     hl.dsp.swapwindow("u"))
hl.bind("SUPER SHIFT, j",     hl.dsp.swapwindow("d"))
hl.bind("SUPER SHIFT, Left",  hl.dsp.swapwindow("l"))
hl.bind("SUPER SHIFT, Right", hl.dsp.swapwindow("r"))
hl.bind("SUPER SHIFT, Up",    hl.dsp.swapwindow("u"))
hl.bind("SUPER SHIFT, Down",  hl.dsp.swapwindow("d"))

-- ── Move windows ──
hl.bind("SUPER CTRL, h",     hl.dsp.movewindow("l"))
hl.bind("SUPER CTRL, l",     hl.dsp.movewindow("r"))
hl.bind("SUPER CTRL, k",     hl.dsp.movewindow("u"))
hl.bind("SUPER CTRL, j",     hl.dsp.movewindow("d"))
hl.bind("SUPER CTRL, Left",  hl.dsp.movewindow("l"))
hl.bind("SUPER CTRL, Right", hl.dsp.movewindow("r"))
hl.bind("SUPER CTRL, Up",    hl.dsp.movewindow("u"))
hl.bind("SUPER CTRL, Down",  hl.dsp.movewindow("d"))

-- ── Workspaces 1-10 (0 key = 10) ──
for i = 1, 10 do
  local key = i == 10 and "0" or tostring(i)
  hl.bind("SUPER, " .. key,        hl.dsp.workspace(tostring(i)))
  hl.bind("SUPER SHIFT, " .. key,  hl.dsp.movetoworkspacesilent(tostring(i)))
end

-- ── Volume ──
hl.bind(", XF86AudioRaiseVolume", hl.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind(", XF86AudioLowerVolume", hl.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind(", XF86AudioMute",        hl.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"))

-- ── Media ──
hl.bind(", XF86AudioNext",  hl.spawn("playerctl next"))
hl.bind(", XF86AudioPrev",  hl.spawn("playerctl previous"))
hl.bind(", XF86AudioPlay",  hl.spawn("playerctl play-pause"))
hl.bind(", XF86AudioStop",  hl.spawn("playerctl stop"))

-- ── Screenshot (region → clipboard) ──
hl.bind("SUPER SHIFT, p", hl.spawn("grim -g \"$(slurp)\" - | wl-copy"))
