Put your wallpapers (PNG/JPG) in this folder. On first boot, they will be copied to ~/Pictures/Wallpapers and one will be set via swaybg in Hyprland startup.
# CyberNEO - Hyprland config (minimal, neon-friendly)
# Docs: https://wiki.hyprland.org/

# Monitors - auto, or specify your setup (example commented)
# monitor=,preferred,auto,1

# General
input {
  kb_layout = us
  follow_mouse = 1
  touchpad {
    natural_scroll = true
    tap-to-click = true
  }
}

general {
  gaps_in = 6
  gaps_out = 12
  border_size = 2
  col.active_border = rgba(7ec0eeff) rgba(9a7ef5ff) 45deg
  col.inactive_border = rgba(222222dd)
  layout = dwindle
}

decoration {
  rounding = 6
  active_opacity = 1.0
  inactive_opacity = 0.95
  blur = true
  blur_size = 6
  blur_passes = 3
}

# Animations
animations {
  enabled = true
}

# Keybinds
$mod = SUPER
bind = $mod, Return, exec, alacritty
bind = $mod SHIFT, Q, killactive, 
bind = $mod, F, fullscreen, 1
bind = $mod, Space, togglefloating, 

# Focus / Move
bind = $mod, H, movefocus, l
bind = $mod, J, movefocus, d
bind = $mod, K, movefocus, u
bind = $mod, L, movefocus, r
bind = $mod SHIFT, H, movewindow, l
bind = $mod SHIFT, J, movewindow, d
bind = $mod SHIFT, K, movewindow, u
bind = $mod SHIFT, L, movewindow, r

# Workspaces 1-9
bind = $mod, 1, workspace, 1
bind = $mod, 2, workspace, 2
bind = $mod, 3, workspace, 3
bind = $mod, 4, workspace, 4
bind = $mod, 5, workspace, 5
bind = $mod, 6, workspace, 6
bind = $mod, 7, workspace, 7
bind = $mod, 8, workspace, 8
bind = $mod, 9, workspace, 9

bind = $mod SHIFT, 1, movetoworkspace, 1
bind = $mod SHIFT, 2, movetoworkspace, 2
bind = $mod SHIFT, 3, movetoworkspace, 3
bind = $mod SHIFT, 4, movetoworkspace, 4
bind = $mod SHIFT, 5, movetoworkspace, 5
bind = $mod SHIFT, 6, movetoworkspace, 6
bind = $mod SHIFT, 7, movetoworkspace, 7
bind = $mod SHIFT, 8, movetoworkspace, 8
bind = $mod SHIFT, 9, movetoworkspace, 9

# Screenshot utils
bind = $mod, P, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +"%Y-%m-%d_%H-%M-%S").png

# Startup
exec-once = waybar
# Prefer user wallpapers if present; otherwise no-op
exec-once = bash -lc 'p=~/Pictures/Wallpapers; [ -d "$p" ] && swaybg -m fill -i "$(find "$p" -type f | head -n1)"'

# Window rules
windowrulev2 = float,class:^(pavucontrol)$
windowrulev2 = float,class:^(nm-connection-editor)$

