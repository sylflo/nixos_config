{ pkgs, lib, ... }:
{
  imports = [
    ../../common/home.nix
  ];

  home.packages = lib.mkMerge [
    (lib.mkDefault [ ])
    [ pkgs.steam ]
  ];
}
