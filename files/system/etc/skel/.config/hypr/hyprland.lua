-- Minimal default Hyprland config (Fedora Atomic / hyprland-nvidia image)
-- Bootstrap config: fresh users get a working session, then override with
-- their own ~/.config/hypr/hyprland.lua. Keybinds follow the established
-- scheme: SUPER for WM, SUPER+SHIFT for windows/apps, hjkl + arrows for
-- directions. API verified against the official example config (0.55+ Lua).

hl.config({
  scrolling = {
    direction    = "right",
    column_width = 0.5,
  },
})

-- Autostart: bar + idle daemon
hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
  hl.exec_cmd("hypridle")
end)

local mainMod = "SUPER"

-- ── Terminal / apps ──
hl.bind(mainMod .. " + SHIFT + t", hl.dsp.exec_cmd("kitty"))

-- ── Core WM ──
hl.bind(mainMod .. " + SHIFT + q",     hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + m",             hl.dsp.exit())

-- ── Launcher / panels / lock ──
hl.bind(mainMod .. " + space",     hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + SHIFT + w", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mainMod .. " + Escape",    hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mainMod .. " + backspace", hl.dsp.exec_cmd("hyprlock"))

-- ── Focus direction (hjkl + arrows) ──
hl.bind(mainMod .. " + h",     hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l",     hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k",     hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j",     hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))

-- ── Scrolling layout: swap columns l/r ──
hl.bind(mainMod .. " + SHIFT + h",     hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + l",     hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.layout("swapcol r"))

-- ── Workspaces 1-10 (0 key = 10) ──
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ── Volume (pactl) ──
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),  { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true, repeating = true })

-- ── Media (playerctl) ──
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"),       { locked = true })

-- ── Screenshot (region → clipboard) ──
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
