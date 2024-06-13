{
  pkgs,
  config,
  inputs,
  stylix,
  ...
}: {
  stylix = {
    autoEnable = true;
    image = pkgs.fetchurl {
      url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
      sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    fonts = {
      monospace = {
        package = with pkgs; nerdfonts.override {fonts = ["GeistMono"];};
        name = "GeistMonoNerdFont";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Serif";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 10;
        terminal = 13;
        desktop = 10;
        popups = 11;
      };
    };

    cursor.package = pkgs.qogir-icon-theme;
    cursor.name = "Qogir Cursors";

    #opacity = {
    #	applications = 1.0;
    #	terminal = 1.0;

    #	desktop = 1.0;
    #	popups = 1.0;
    #};

    polarity = "dark";
    targets = {
      grub.enable = false;
      gnome.enable = false;
      gtk.enable = true;
      nixos-icons.enable = true;
    };
  };
}
