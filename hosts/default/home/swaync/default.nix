{
  pkgs,
  config,
  ...
}: {
  services.swaync = {
    enable = true;
    package = pkgs.swaynotificationcenter;
    settings = {
      positionX = "right";
      positionY = "top";
      cssPriority = "user";

      control-center-width = 380;
      control-center-height = 860;
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-right = 1;
      control-center-margin-left = 0;

      notification-window-width = 400;
      notification-icon-size = 48;
      notification-body-image-height = 160;
      notification-body-image-width = 200;

      timeout = 4;
      timeout-low = 2;
      timeout-critical = 0;

      fit-to-screen = false;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;

      widgets = [
        "label"
        "title"
        "buttons-grid"
        # "mpris"
        "volume"
        "dnd"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Notification Center";
          clear-all-button = true;
          button-text = "󰆴 Clear All";
        };

        dnd = {
          text = "Do Not Disturb";
        };

        label = {
          max-lines = 1;
          text = "Notification Center";
        };

        # mpris = {
        #   image-size = 96;
        #   image-radius = 7;
        # };

        volume = {
          label = "󰕾";
          show-per-app = true;
        };

        buttons-grid = {
          actions = [
            {
              label = "⏹️";
              command = "systemctl poweroff";
            }
            {
              label = "🔄";
              command = "systemctl reboot";
            }
            {
              label = "🚪";
              command = "hyprctl dispatch exit";
            }
            {
              label = "🎮";
              command = "steam";
            }
            {
              label = "🌏";
              command = "firefox";
            }
          ];
        };
      };
    };
  };

  home.file.".config/swaync/central_control.css".source = ./central_control.css;
  home.file.".config/swaync/notifications.css".source = ./notifications.css;
  home.file.".config/swaync/styles.css".source = ./styles.css;
  # home.file.".config/swaync/config.json".text = builtins.toJSON = {};

  # systemd.user.services.swaync = {
  #   Unit = {
  #     Description = "Sway Notification Center";
  #     After = ["graphical-session-pre.target"];
  #     PartOf = ["graphical-session.target"];
  #   };

  #   Install = {WantedBy = ["graphical-session.target"];};

  #   Service = {
  #     ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
  #     Restart = "always";
  #     RestartSec = 3;
  #   };
  # };
}
