{ lib, inputs, config, pkgs, ... }:
{
  
  home.username = "sylflo";
  home.homeDirectory = "/home/sylflo";

  home.packages = with pkgs; [
    firefox
    spotify
    rofi-wayland
    swww
    waypaper
    eww
    #hyprlock # TODO use flake cos of compatbility with hyprland
    grim
    slurp
    kitty
    playerctl
    pipewire
    wireplumber
    #dolphin # TODO to change/customize
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [
      inputs.hyprland-virtual-desktops.packages.${pkgs.system}.virtual-desktops
    ];
    extraConfig = ''
      #source = ~/.config/hypr/hyprland-source.conf
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

  programs.git = {
    enable = true;
    userName = "sylflo";
    userEmail = "git@sylvain-chateau.com";
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
