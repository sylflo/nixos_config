{ lib, inputs, config, pkgs, ... }:
{

  home.username = "sylflo";
  home.homeDirectory = "/home/sylflo";

  home.packages = with pkgs; [
    mpv
    anki-bin
    # Music players
    spotify
    playerctl
    # Wallpaper
    swww
    waypaper
    # Launcher
    rofi-wayland
    #eww
    #hyprlock # TODO use flake cos of compatbility with hyprland
    # Screenshot
    grim
    slurp
    # Terminal
    kitty
    # low-level multimedia framework
    pipewire
    wireplumber
    #
    wireguard-tools
    acpi
    #
    google-chrome
    plex-media-player
    #
    poetry
    #
    wget
    eog
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [
      inputs.hyprland-virtual-desktops.packages.${pkgs.system}.virtual-desktops
    ];
    extraConfig = ''
      source = ~/.config/hypr/hyprland-source.conf
      stickyrule = class:^(kittysticky)$,3
      stickyrule = title:thunderbird,mail

      plugin {
        virtual-desktops {
          names = 1:coding, 2:internet, 3:mail and chats 
          cycleworkspaces = 1
          rememberlayout = size
          notifyinit = 0
          verbose_logging = 0
        }
     }
    '';
  };


  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
    extraConfig = ''
      source = ~/.config/hypr/hyprlock-source.conf
    '';
  };

  #programs.ladybird = {
  #  enable = true;
  #};

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = false;
      DisableAccounts = false;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
      ExtensionSettings = {
        "*".installation_mode = "blocked";
        # uBlock Origin:
       "uBlock0@raymondhill.net" = {
         install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
         installation_mode = "force_installed";
       };
       # Bitwarden
       "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
         install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
         installation_mode = "force_installed";
         #default_area = "navbar";
         default_area = "menupanel";
       };
       # MAL-Sync
       "{c84d89d9-a826-4015-957b-affebd9eb603}" = {
         install_url = "https://addons.mozilla.org/fr/firefox/addon/mal-sync/";
         installation_mode = "force_installed";
         default_area = "menupanel";
       };
       "{e2e52b5d-337a-4693-abde-a096277d3710}" = {
         install_url = "https://addons.mozilla.org/en-US/firefox/addon/leetcode-themes/latest.xpi";
         installation_mode = "force_installed";
         default_area = "menupanel";
       };
       
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "sylflo";  
    userEmail = "git@sylvain-chateau.com";
  };


  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      #vscodevim.vim
      #yzhang.markdown-all-in-one
    ];
  };


  # Enable Zsh as the shell
  programs.zsh = { enable = true; oh-my-zsh = {
      enable = true; # Install and manage Oh My Zsh
      plugins = [ "git" "z" "vi-mode" ]; # Add desired plugins
      theme = "agnoster"; # Set your desired theme
    };
  };

  # Manage your .zshrc configuration
  home.file.".zshrc".text = ''
    # Custom .zshrc configuration
    export PATH=$HOME/.local/bin:$HOME/.config/elenapan/bin:$PATH

    # Enable aliases
    alias ll='ls -la'
    alias gs='git status'

    # Source oh-my-zsh
    if [ -f $HOME/.oh-my-zsh/oh-my-zsh.sh ]; then
      source $HOME/.oh-my-zsh/oh-my-zsh.sh
    fi
  '';

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
