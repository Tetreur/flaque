{
  pkgs,
  config,
  lib,
  host,
  ...
}: {
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = /home/tet/wallpapers/meadow.jpg
    wallpaper = , /home/tet/wallpapers/meadow.jpg
  '';
 }
