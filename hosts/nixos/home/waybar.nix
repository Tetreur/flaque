{pkgs, ...}:
# let
# betterTransition = "all 0.3s cubic-bezier(.55,-0.068,.48,1.682)";
# in
# with lib;
{
  # Config & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    style = ''
      /* ----------- 💫 https://github.com/JaKooLit 💫 -------- */
      /* ..........................................*/
      /* .......Crystal Clear....................... */
      /* ......................................... */
      /* --- 👍 designed by https://github.com/Krautt  👍 --- */

      * {
      	font-family: "GeistMono Nerd Font";
      	font-weight: bold;
      	min-height: 0;
      	/* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
      	font-size: 100%;
      	font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
      	padding: 1px;
      }

      window#waybar {
      	background:transparent;
      	color: whitesmoke;
      }

      window#waybar.hidden {
      	opacity: 0.5;
      }
      window#waybar.empty {
      	background-color: transparent;
      }

      window#waybar.empty #window {
      padding: 0px;
      border: 0px;
      background-color: transparent;
      }

      tooltip {
      	background: #1e1e2e;
      	border-radius: 10px;
      	border-width: 2px;
      	border-style: solid;
      	border-color: #11111b;
      	color: #cba6f7;
      }

      /*-----module groups----*/
      .modules-right {
      	margin-right: 6px;
      }

      .modules-center {

      }

      .modules-left {
      	margin-left: 6px;
      }

      #workspaces button {
      	color: #6E6A86;
      	box-shadow: none;
      	text-shadow: none;
      	padding-left: 4px;
      	padding-right: 4px;
      	animation: gradient_f 20s ease-in infinite;
      	transition: color, border 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.active {
      	color: whitesmoke;
      	animation: gradient_f 20s ease-in infinite;
      	transition: color, border 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #workspaces button.focused {
      	color: #d8dee9;
      }

      #workspaces button.urgent {
      	color: #11111b;
      }

      #workspaces button:hover {
      	color: whitesmoke;
      	animation: gradient_f 20s ease-in infinite;
      	transition: color, border 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #backlight,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #disk,
      #idle_inhibitor,
      #keyboard-state,
      #memory,
      #mode,
      #mpris,
      #network,
      #pulseaudio,
      #taskbar,
      #temperature,
      #tray,
      #window,
      #wireplumber,
      #workspaces,
      #custom-cycle_wall,
      #custom-keybinds,
      #custom-keyboard,
      #custom-light_dark,
      #custom-lock,
      #custom-menu,
      #custom-power_vertical,
      #custom-power,
      #custom-swaync,
      #custom-spotify,
      #custom-updater,
      #custom-weather,
      #custom-weather.clearNight,
      #custom-weather.cloudyFoggyDay,
      #custom-weather.cloudyFoggyNight,
      #custom-weather.default
      #custom-weather.rainyDay,
      #custom-weather.rainyNight,
      #custom-weather.severe,
      #custom-weather.showyIcyDay,
      #custom-weather.snowyIcyNight,
      #custom-weather.sunnyDay {
      	padding-top: 6px;
      	padding-bottom: 6px;
      	padding-right: 6px;
      	padding-left: 6px;
      }

      #temperature.critical {
      	background-color: #ff0000;
      }

      @keyframes blink {
      	to {
      	color: #000000;
      	}
      }

      #taskbar button:hover {
      	padding-left: 3px;
      	padding-right: 3px;
      	animation: gradient_f 20s ease-in infinite;
      	transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #taskbar button.active {
      	background-color: #7f849c;
      	padding-left: 12px;
      	padding-right: 12px;
      	animation: gradient_f 20s ease-in infinite;
      	transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #battery.critical:not(.charging) {
      	color: #f53c3c;
      	animation-name: blink;
      	animation-duration: 0.5s;
      	animation-timing-function: linear;
      	animation-iteration-count: infinite;
      	animation-direction: alternate;
      }

      #pulseaudio-slider slider {
      	min-width: 0px;
      	min-height: 0px;
      	opacity: 0;
      	background-image: none;
      	border: none;
      	box-shadow: none;
      }

      #pulseaudio-slider trough {
      	min-width: 80px;
      	min-height: 10px;
      	border-radius: 5px;
      	background-color: black;
      }

      #pulseaudio-slider highlight {
      	min-height: 10px;
      	border-radius: 5px;
      	background-color: wheat;
      }

      #backlight-slider slider {
      	min-width: 0px;
      	min-height: 0px;
      	opacity: 0;
      	background-image: none;
      	border: none;
      	box-shadow: none;
      }

      #backlight-slider trough {
      	min-width: 80px;
      	min-height: 10px;
      	border-radius: 5px;
      	background-color: black;
      }

      #backlight-slider highlight {
      	min-width: 10px;
      	border-radius: 5px;
      	background-color: wheat;
      }
    '';

    settings = [
      {
        layer = "top";
        positon = "top";

        modules-left = [
          "custom/menu"
          "custom/separator#blank_2"
          "group/motherboard"
          "custom/separator#blank_2"
          "tray"
        ];

        modules-center = [
          "hyprland/workspaces#kanji"
        ];

        modules-right = [
          "mpris"
          "custom/separator#blank_2"
          "group/audio"
          "custom/separator#blank_2"
          "network"
          "custom/separator#blank_2"
          "clock"
          "custom/separator#blank_2"
          "custom/swaync"
        ];

        # ------ #
        # GROUPS #
        # ------ #

        "group/motherboard" = {
          orientation = "horizontal";
          modules = ["cpu" "memory" "temperature" "disk"];
        };

        "group/audio" = {
          orientation = "horizontal";
          modules = ["pulseaudio" "pulseaudio#microphone"];
        };

        # ----- #
        # UTILS #
        # ----- #

        "custom/separator#blank_2" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };

        "tray" = {
          spacing = 12;
        };

        "hyprland/workspaces#kanji" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
        };

        "custom/menu" = {
          format = "{}";
          exec = "echo ; echo 󱓟 app launcher";
          interval = 86400; # once every day
          tooltip = true;
          on-click = "sleep 0.1 && rofi-launcher";
          # on-click-middle = "~/.config/hypr/scripts/wallpaperSelect.sh";
          # on-click-right = "~/.config/hypr/scripts/WaybarLayout.sh";
        };

        "network" = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-disconnected = "󰤮";
          format = "{ifname}";
          tooltip-format = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          format-wifi = "{icon} {signalStrength}%";
          tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
          tooltip-format-disconnected = "󰌙 Disconnected";
          format-ethernet = "󰌘 {bandwidthDownOctets}";
          tooltip-format-ethernet = "{ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
          max-length = 50;
          tooltip = true;
        };

        # MOTHERBOARD GROUP
        "memory" = {
          interval = 10;
          format = "{used:0.1f}G 󰾆";
          format-alt = "{percentage}% 󰾆";
          format-alt-click = "click";
          tooltip = true;
          tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
          on-click = "wezterm cli spawn --new-window btop";
        };

        "cpu" = {
          format = "{usage}% 󰍛";
          interval = 1;
          format-alt-click = "click";
          format-alt = "{icon0}{icon1}{icon2}{icon3} {usage:>2}% 󰍛";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          tooltip = true;
        };

        "temperature" = {
          interval = 10;
          tooltip = true;
          hwmon-path = ["/sys/class/hwmon/hwmon1/temp1_input" "/sys/class/thermal/thermal_zone0/temp"];
          # thermal-zone = 0;
          critical-threshold = 82;
          format-critical = "{temperatureC}°C {icon}";
          format = "{temperatureC}°C {icon}";
          format-icons = ["󰈸"];
          on-click = "wezterm cli spawn --new-window nvtop";
        };

        "disk" = {
          interval = 30;
          path = "/";
          # format-alt-click = "click",
          format = "{percentage_used}% 󰋊";
          # tooltip = true;
          tooltip-format = "{used} used out of {total} on {path} ({percentage_used}%)";
        };

        # AUDIO GROUP
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} 󰂰 {volume}%";
          format-muted = "󰖁";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" "󰕾" ""];
            ignored-sinks = ["Easy Effects Sink"];
          };
          scroll-step = 5.0;
          # on-click-right = "~/.config/hypr/scripts/volume_control.sh --toggle";
          # on-click = "pavucontrol -t 3";
          # on-scroll-up = "~/.config/hypr/scripts/volume_control.sh --inc";
          # on-scroll-down = "~/.config/hypr/scripts/volume_control.sh --dec";
          tooltip-format = "{icon} {desc} | {volume}%";
          smooth-scrolling-threshold = 1;
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          # on-click-right = "~/.config/hypr/scripts/volume_control.sh --toggle-mic";
          # on-click = "pavucontrol -t 4";
          # on-scroll-up = "~/.config/hypr/scripts/volume_control.sh --mic-inc";
          # on-scroll-down = "~/.config/hypr/scripts/volume_control.sh --mic-dec";
          tooltip-format = "{source_desc} | {source_volume}%";
          scroll-step = 5;
        };

        "mpris" = {
          interval = 10;
          format = "{player_icon} ";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          on-click-middle = "playerctl play-pause";
          on-click = "playerctl previous";
          on-click-right = "playerctl next";
          scroll-step = 5.0;
          # on-scroll-up = "~/.config/hypr/scripts/volume_control.sh --inc";
          # on-scroll-down = "~/.config/hypr/scripts/volume_control.sh --dec";
          smooth-scrolling-threshold = 1;
          player-icons = {
            chromium = "";
            default = "";
            firefox = "";
            kdeconnect = "";
            mopidy = "";
            mpv = "󰐹";
            spotify = "";
            vlc = "󰕼";
          };
          status-icons = {
            paused = "󰐎";
            playing = "";
            stopped = "";
          };
          # ignored-players = ["firefox"];
          max-length = 30;
        };

        "clock" = {
          tooltip = true;
          interval = 1;
          format = "{:%a %d %h %H:%M}";
          # format-alt = " {:%H:%M   %Y, %d %B, %A}";
          # tooltip-format = "<tt><small>{calendar}</small></tt>";
          # calendar = {
          # 	mode = 		   "year";
          # 	mode-mon-col = 3;
          # 	weeks-pos =    "right";
          # 	on-scroll =    1;
          # 	format = {
          # 		months =   "<span color='#ffead3'><b>{}</b></span>";
          # 		days =     "<span color='#ecc6d9'><b>{}</b></span>";
          # 		weeks =    "<span color='#99ffdd'><b>W{}</b></span>";
          # 		weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          # 		today =    "<span color='#ff6699'><b><u>{}</u></b></span>";
          # 	};
          # };
          # actions =  {
          # 	on-click-right = "mode";
          # 	on-click-forward = "tz_up";
          # 	on-click-backward = "tz_down";
          # 	on-scroll-up = "shift_up";
          # 	on-scroll-down = "shift_down"
          # },
        };

        "custom/swaync" = {
          tooltip = true;
          format = "{icon} {}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "sleep 0.1 && swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      }
    ];
  };
}
