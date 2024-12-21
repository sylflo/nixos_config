{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.sylflo = {
    home.stateVersion = "22.11"; # Adjust based on your setup

    # Enable Zsh as the shell
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true; # Install and manage Oh My Zsh
        plugins = [ "git" "z" "vi-mode" ]; # Add desired plugins
        theme = "agnoster"; # Set your desired theme
      };
    };

    # Manage your .zshrc configuration
    home.file.".zshrc".text = ''
      # Custom .zshrc configuration
      export PATH=$HOME/.local/bin:$PATH

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
