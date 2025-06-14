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
  '';

  services.avahi.enable = true;
  services.avahi.nssmdns = true; 


}
