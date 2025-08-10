# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "work-laptop"; # Define your hostname.
  networking.extraHosts = ''
    127.0.0.1 cinemaster.docker
    127.0.0.1 flower.docker
    127.0.0.1 s3.docker
    127.0.0.1 stockproject.docker
    127.0.0.1 mailcatcher.docker
    127.0.0.1 stock-api.docker
    127.0.0.1 stock-root.docker
    127.0.0.1 stock.docker
    192.168.210.179 wgdashboard.cinego.net
  '';

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  virtualisation.libvirtd.enable = true;

}
