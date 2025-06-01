{ pkgs, lib, ... }:
{
  imports = [
    ../../common/home.nix
  ];

  # home.packages = lib.mkMerge [
  #   (lib.mkDefault [ ])
  #   [
  #     pkgs.steam
  #     pkgs.vulkan-loader
  #     pkgs.vulkan-validation-layers
  #     pkgs.vulkan-extension-layer
  #   ]
  # ];
}
