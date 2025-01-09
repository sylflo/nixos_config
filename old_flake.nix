{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    #hyprland = {
    #  url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #  follows = "hyprland-virtual-desktops/hyprland"; # To make sure we run the same version of hyprland that the plugin was built against
    #};
    #hyprland-virtual-desktops.url = "github:levnikmyskin/hyprland-virtual-desktops";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; # this is the important part
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        # make home-manager as a module of nixos
        # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.sylflo = import ./home.nix;
          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };
  };
}
