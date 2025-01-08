# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./home-manager-config.nix
    ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    # Experimental feature
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  #boot.loader.systemd-boot.loader.generations = 2;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  #services.udev.extraRules = ''
  #  # Allow non-root users to access backlight control
  #  KERNEL=="backlight", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/backlight/*/brightness"
  #  KERNEL=="backlight", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/backlight/*/max_brightness"
  #'';

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

  # Enable graphics for steam
  hardware.graphics.enable = true;
  #hardware.video.hardenedIntel = false;  # Disable hardened Intel for better performance.
  #hardware.video.intel.vaapi.enable = true;  # For hardware-accelerated video decoding.

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sylflo = {
    isNormalUser = true;
    description = "sylflo";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Install Hyprland
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland # TODO Why did I enable this ???
    xwayland.enable = true;
    #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Install zsh
  programs = {
      zsh = {
        enable = true;
        ohMyZsh = {
          enable = true;
          theme = "robbyrussell";
          plugins = [
            "sudo"
            "terraform"
            "systemadmin"
            "vi-mode"
          ];
        };
      };
  };
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # BEGIN WM
    glib
    mpv
    brightnessctl
    #light
    procps
    inotify-tools
    acpid
    acpi
    #brightnessctl
    #pulseaudio
    #hyprexpo

    cmake
    meson
    cpio

    htop
    iproute2
    jq
    killall
    libsecret
    pciutils
    podman-compose
    pipx
    python312
    nodejs
    ruff
    socat
    tmux
    vscodium
    wget
    unzip
    yarn
    # TODO put it in hardware.config
    vulkan-loader
    vulkan-tools
  ];

  #fonts = {
  #  enableDefaultFonts = true;  # Optional: Ensures basic system fonts are available
  #  fonts = with pkgs; [
  #    google-fonts
  #    nerdfonts
  #  ];
  #};

  # Install Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Install podman
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      #dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.acpid.enable = true;

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
