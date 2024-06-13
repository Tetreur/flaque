{
  pkgs,
  config,
  lib,
  hosts,
  ...
}: {
  # Config & Theme Waybar
  services.mako = {
    enable = true;
    anchor = "top-right";
    borderRadius = 10;
    borderSize = 2;
    padding = "15,10,15";
    # borderColor = "#000000FF";
    # backgroundColor = "#000000FF";
    # defaultTimeout = 3500;
    # sort = "-priority";
    #extraConfig = ''
    # 	[urgency=low]
    #	border-color=#282A36
    #	[urgency=normal]
    #	border-color=#000000FF
    #	[urgency=high]
    #	border-color=#FF5555
    #'';
  };
}
