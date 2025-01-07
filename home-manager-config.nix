{ config, pkgs, lib, inputs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
  #dotfiles = builtins.fetchGit {
  #  url = "https://github.com/sylflo/dotfiles.git";
  #  ref = "main"; # Replace with the desired branch or tag
  #};
  dotfiles = "/home/sylflo/Projects/dotfiles";

in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.sylflo = {
    home.stateVersion = "22.11"; # Adjust based on your setup

  home.packages = with pkgs; [
    spotify
    ## Window manager
    eww
    hyprlock
    grim
    slurp
    kitty
    playerctl
    swaynotificationcenter
    pipewire
    wireplumber
    dolphin # TODO to change/customize
  ];

    # Adding Hyprland plugins
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        pkgs.hyprlandPlugins.hyprexpo
      ];
    };


  #home.file = {
  #  #".config/hypr/hyprland.conf".source = "${dotfiles}/hyprland.conf";
  #  ".config/hypr/hyprlock.conf".source = "${dotfiles}/hyprlock.conf";
  #};
    home.file.".config/kitty".source = "${dotfiles}/config/kitty";
    home.file.".config/kitty".recursive = true;

    home.file.".config/eww".source = "${dotfiles}/config/eww";
    home.file.".config/eww".recursive = true;

    home.file.".config/rofi".source = "${dotfiles}/config/rofi";
    home.file.".config/rofi".recursive = true;

    home.file.".config/hypr".source = "${dotfiles}/config/hypr";
    home.file.".config/hypr".recursive = true;
    home.file.".config/hypr".force = true;

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
  };
}
