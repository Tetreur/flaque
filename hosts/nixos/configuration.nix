 { inputs, pkgs, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
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

  # Enable udisk2 to manage removable media
  services.udisks2.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Audio
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;

  #   # This section explicitly configures audio properties
  #   # To prevent conflicts that can cause static.inherit
  #   extraConfig.pipewire."99-custom-audio-config" = {
  #     # Add your custom audio configuration here
  #     "context.properties" = {
  #       # Set a common default sample rate. 48000 is a safe bet
  #       "default.clock.rate" = 48000;
  #       "default.clock.allowed-rates" = [44100 48000]; # Common rates

  #       # Adjust buffer size (quantum). Static can happen if this is too low.inherit
  #       # 1024 is a good default. If you still get pops, try 2048
  #       "default.clock.quantum" = 1024;
  #       "default.clock.min-quantum" = 32;
  #       "default.clock.max-quantum" = 2048;
  #     };
  #   };
  # };

  # Nvidia
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg & Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking up from sleep.
      # This fixes it by saving the entire VRAM memory to /tmp/ instead of just the bare essentials.
      powerManagement.enable = false;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;
      # prime.offload.enable = true;

      # Use the NVidia open source kernel module (not nouveau).
      # Support is limited to the Turing and later arch.
      open = true;

      # Enable the nvidia settings menu (nvidia-settings).
      nvidiaSettings = true;

      # Optionally, select the approprate driver version for specific GPU.
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tet = {
    isNormalUser = true;
    description = "tet";
    extraGroups = [ "networkmanager" "wheel" ];
    packages =  [];
    shell = pkgs.fish;
  };

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"tet" = import ./home;
		};
	};

  # Enable automatic login for the user.
  services.getty.autologinUser = "tet";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Hyprland
  programs.hyprland = {
    # Install the pkg from nixpkgs
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wezterm
     # Waybar
     waybar
     power-profiles-daemon
     wget
     rofi-wayland
     kitty

     # Editors
     zed-editor
     neovim
     vim

     # Fish shell plugins
     fishPlugins.done
     fishPlugins.fzf-fish
     fishPlugins.forgit
     fishPlugins.git-abbr
     fishPlugins.hydro
     fzf
     fishPlugins.grc
     grc

     # Languages
     zig

     # Browsers
     librewolf
     chromium

     # Explorer
     kdePackages.dolphin

     # Utils
     git
     gh
     tlrc
     lshw
     btop
     nvtopPackages.nvidia
     nvtopPackages.amd

     # Keyboard
     qmk

     # Language server
     nixd
     nil

     # Sound & Audio
     # pavucontrol
     spotify

     # Comms
     discord

     # Gaming, ProtonGE (for steam)
     protonup

     # Home Manger
     home-manager
  ];

  # Docker
  virtualisation.docker.enable = true;

  # --- Keyring for login persistence ---
  # 1. Enable the secret service daemon
  services.gnome.gnome-keyring.enable = true;
  # Automatically unlock the keyring with login password
  security.pam.services.login.enableGnomeKeyring = true;

  # Steam
  programs = {
  	steam = {
    		enable = true;
    		gamescopeSession.enable = false;
    		remotePlay.openFirewall = false;
    		dedicatedServer.openFirewall = false;
    		extraCompatPackages = [pkgs.proton-ge-bin pkgs.vkd3d-proton];
  	};
  	gamescope = {
    		enable = true;
    		capSysNice = true;
    		args = [
    			"--rt"
    			"--expose-wayland"
    		];
  	};
  	gamemode.enable = true;
  };

  # Desktop portals
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
};

  environment.sessionVariables = {
    # Test
    DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = "1";
    ENABLE_VK_LAYER_VALVE_steam_overlay = "0";
    ENABLE_VK_LAYER_VALVE_steam_fossilize = "0";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __VK_LAYER_NV_optimus = "NVIDIA_only";
    DXVK_FILTER_DEVICE_NAME = "NVIDIA";
    DXVK_LOG_LEVEL = "warn";
    WINEDEBUG = "-all";
    # WLR_RENDERER_ALLOW_SOFTWARE = "1";

    # Laggy mouse
    OGL_DEDICATED_HW_STATE_PER_CONTEXT = "ENABLE_ROBUST";
    # If cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron app to use wayland
    NIXOS_OZONE_WL = "1";
  };

  # Change default shell
  programs.fish.enable = true;

  # Git
  programs.git = {
    enable = true;
    config.user = {
   	name = "Tetreur";
   	email = "tetreur@gmail.com";
    };
  };

  services = {
    power-profiles-daemon.enable = true;
  };

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
  system.stateVersion = "24.11"; # Did you read the comment?
}
