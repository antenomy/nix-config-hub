{ pkgs, lib, ... }:

{
  home.packages = [
    pkgs.atool
    pkgs.httpie
  ];
  
  programs.bash.enable = true;
  programs.bash.bashrcExtra = ''
    # Aliases
    alias nrs='sudo nixos-rebuild switch'
    alias hyprcon='sudo vim ~/.config/hypr/hyprland.conf'
    alias nce='sudo vim /etc/nixos/configuration.nix'
    alias nhc='sudo vim /etc/nixos/home.nix'
  '';


  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };

    settings = {
      "$terminal" = "kitty";
      "$mainMod" = "SUPER";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";
      "$browser" = "brave";

      workspace = [
        "1,monitor:DP-2"
        "2,monitor:DP-1"
        "3,monitor:DP-3"
      ];

      monitor = [
        "DP-3,1920x1080@74.97,0x0, 1"
        "DP-2,2560x1440@165.08,1920x-440, 1"
        "DP-1,1920x1080@74.97,4480x40, 1"
      ];

      exec-once = [
        "openrgb --startminimized --profile \"purp\""
        "mpvpaper -o \"loop-file\" ALL ~/Documents/Wallpapers/aot-group-1-blur.jpg"
        # swww-daemon > /dev/null 2>&1 &
        #swww img ~/Downloads/.gif

        "hyprlock || hyprctl dispatch exit"

        "nm-applet"
        "waybar"
        "mako"

        "[workspace 1 silent] kitty -e bash -c \"neofetch; exec bash\""
        "hyprctl dispatch workspace 1"
        "wl-gammarelay-rs"
        "dropbox"
      ];

      

      input = {
        kb_layout = "us";
        # kb_variant = #nodeadkeys
        # kb_model =
        # kb_options =
        # kb_rules =

        follow_mouse = 1;

        sensitivity = -0.2; # -1.0 - 1.0, 0 means no modification

        touchpad = {
          natural_scroll = false;
        };
      };

      master = {
        new_status = "master";
      };


      # cursor = {
      #   enable_hyprcursor = true;
      # };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        # no_gaps_when_only = 0;
        smart_split = false;
        smart_resizing = false;
      };

      gestures = {
        workspace_swipe = false;
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, B, exec, $browser"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"

        "ALT, SPACE, exec, rofi -show run"

        "$mainMod ALT, up, exec, busctl --user -- call wl-gammarelay / wl-gammarelay-rs UpdateTemperature n -500"
        "$mainMod ALT, down, exec, busctl --user -- call wl-gammarelay-rs / wl-gammarelay-rs UpdateTemperature n +500"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgba(8200ffff)";
        "col.inactive_border" = "rgba(292929ff)";
        # col = {
        #   active_border = "rgba(8200ffff)";
        #   # inactive_border = "rgba(292929ff)";
        # };
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        rounding_power = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      windowrulev2 = [
        "noblur, title:^()$, class:^()$"
      ];

    };
    systemd = {
      enable = true;
    };
  };
  
  # imports = [
  #   (fetchTarball {
  #     url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
  #     sha256 = lib.fakeSha256;
  #   })/modules/vscode-server/home.nix
  # ];
  
  # services.vscode-server.enable = true;
  # services.vscode-server.enableFHS = true;


  home.stateVersion = "25.05";
  
}
