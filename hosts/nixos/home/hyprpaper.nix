{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${config.home.homeDirectory}/.config/wallpapers/meadow.jpg"
      ];

      wallpaper = [" , ${config.home.homeDirectory}/.config/wallpapers/meadow.jpg"];
    };
  };

  home.file.".config/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };
}
