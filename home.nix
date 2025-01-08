{ inputs, config, pkgs, ... }:

  #dotfiles = builtins.fetchGit {
  #  url = "https://github.com/sylflo/dotfiles.git";
  #  ref = "main"; # Replace with the desired branch or tag
  #};

let 
 dotfiles = "/home/sylflo/Projects/dotfiles";
in
{

  home.username = "sylflo";
  home.homeDirectory = "/home/sylflo";

  home.packages = with pkgs; [
    git
    spotify
    rofi-wayland
    swww
    waypaper
    ## Window manager
    eww
    #hyprlock
    grim
    slurp
    kitty
    playerctl
    swaynotificationcenter
    pipewire
    wireplumber
    dolphin # TODO to change/customize
  ];

  #dotfiles = "/home/sylflo/Projects/dotfiles";
  ###################
  # Start Dotfiles  #
  ###################
  home.file.".config/hypr".source = "${dotfiles}/config/hypr";
  home.file.".config/hypr".recursive = true;
  home.file.".config/hypr".force = true;
  
  home.file.".config/kitty".source = "${dotfiles}/config/kitty";
  home.file.".config/kitty".recursive = true;

  home.file.".config/eww".source = "${dotfiles}/config/eww";
  home.file.".config/eww".recursive = true;

  home.file.".config/rofi".source = "${dotfiles}/config/rofi";
  home.file.".config/rofi".recursive = true;

  ################
  # End dotfiles #
  ################

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
