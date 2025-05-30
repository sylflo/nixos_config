{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.46.2";
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-virtual-desktops = {
      url = "github:levnikmyskin/hyprland-virtual-desktops";
      inputs.hyprland.follows = "hyprland";
    };
   };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: {

    nixosConfigurations = {
      desktop= nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./common/configuration.nix
          ./hosts/desktop/configuration.nix
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            #home-manager.extraSpecialArgs = { inherit inputs;};
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.sylflo = import ./hosts/desktop/home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ]; 
      };
      personal-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./common/configuration.nix
          ./hosts/personal-laptop/configuration.nix
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            #home-manager.extraSpecialArgs = { inherit inputs;};
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.sylflo = import ./common/home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ]; 
      };
      work-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./common/configuration.nix
          ./hosts/work-laptop/configuration.nix
          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          {
            #home-manager.extraSpecialArgs = { inherit inputs;};
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.sylflo = import ./common/home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ]; 
      };
    };
  };
}
