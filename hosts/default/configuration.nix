# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Home manager
    inputs.home-manager.nixosModules.default

    # Stylix
    ./../../modules/nixos/stylix.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # IOMMU
  # https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/
  boot.kernelParams = ["amd_iommu=on"];

  # Virtualization
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          })
          .fd
        ];
      };
    };
  };

  networking.hostName = "hyprnix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "oss_nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tet = {
    isNormalUser = true;
    description = "tet";
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
      neovim
    ];
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "tet" = import ./home;
    };
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "tet";

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Utils
    # gnome-randr
    wlr-randr
    xorg.xrandr
    wget
    gh
    curl
    git
    btop
    nvtopPackages.full
    neofetch

    # File manager
    gnome.nautilus
    deepin.udisks2-qt5
    udiskie

    # Image viewer
    feh

    # Polkit
    polkit_gnome
    lxqt.lxqt-policykit

    # WallPaper
    swww

    # Terminal & Editor
    kitty
    zed-editor
    vscode
    vim

    # App Launcher
    rofi-wayland

    # Sound
    spotify
    playerctl

    # Notification daemon
    libnotify

    # ProtonGE (for steam)
    protonup

    # Firefox
    firefox

    # Thunderbiiiird
    thunderbird

    # QEMU & Related
    qemu
    virt-manager
    virt-viewer
    dnsmasq
    vde2
    bridge-utils
    netcat-openbsd
    ebtables
    iptables
    libguestfs

    # idk man
    home-manager
  ];

  programs.virt-manager.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Polkit
  security.polkit.enable = true;
  security.rtkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
    			if (
      			subject.isInGroup("users")
        		&& (
          			action.id == "org.freedesktop.login1.reboot" ||
          			action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
          			action.id == "org.freedesktop.login1.power-off" ||
          			action.id == "org.freedesktop.login1.power-off-multiple-sessions"
        		))
    			{
      			return polkit.Result.YES;
    			}
    })
  '';

  # Desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Enable sound with pipewire
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enabling HyprLand
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # Test
    # WLR_RENDERER_ALLOW_SOFTWARE = "1";

    # Laggy mouse
    OGL_DEDICATED_HW_STATE_PER_CONTEXT = "ENABLE_ROBUST";
    # If cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron app to use wayland
    NIXOS_OZONE_WL = "1";
  };

  # Load nvidia driver for Xorg & Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    # Opengl
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      # extraPackages = with pkgs; [
      # 	vaapiVdpau
      # 	libvdpau-va-gl
      # ];
    };

    # NVIDIA
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
