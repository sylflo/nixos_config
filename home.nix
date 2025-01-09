{ lib, inputs, config, pkgs, ... }:
{
  
  home.username = "sylflo";
  home.homeDirectory = "/home/sylflo";


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
