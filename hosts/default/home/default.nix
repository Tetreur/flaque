{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Enable &/ Configure Programs
    # ./mako.nix
    ./neovim.nix
    ./starship
    ./swaync
    ./virt-manager.nix
    ./waybar.nix
    ./wezterm.nix
    ./zsh.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tet";
  home.homeDirectory = "/home/tet";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # GIT
    git

    # CLI UTILS
    tldr
    tree
    tokei

    # PROMPT
    starship

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (nerdfonts.override {fonts = ["GeistMono" "FiraCode" "JetBrainsMono"];})

    # # Import Scripts
    (import ./../../../scripts/rofi-launcher.nix {inherit pkgs;})
    (import ./../../../scripts/iommu-groups.nix {inherit pkgs;})

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (writeShellScriptBin "my-hello" ''
    #       echo "Rip & Tear, ${config.home.username}!"
    # '')
  ];

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # Install the gitconfig file, as .gitconfig in the home directory
    ## ".gitconfig".source = ./gitconfig;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tet/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # PROTON
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    starship = {
      enable = true;
      package = pkgs.starship;
    };
  };
}
