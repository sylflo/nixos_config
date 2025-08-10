# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS configuration repository using Nix Flakes with Home Manager integration. It defines system configurations for multiple hosts (desktop, personal-laptop, work-laptop) with a shared common configuration and user-specific home management.

## Architecture

### Repository Structure
- `flake.nix` - Main flake configuration defining inputs and nixosConfigurations
- `common/` - Shared configuration modules
  - `configuration.nix` - Common system-wide NixOS configuration
  - `home.nix` - Common Home Manager configuration for user environment
- `hosts/` - Host-specific configurations
  - `desktop/`, `personal-laptop/`, `work-laptop/` - Individual host configurations
  - Each host has `configuration.nix`, `hardware-configuration.nix`, and some have `home.nix`

### Configuration Pattern
The flake defines three nixosConfigurations that follow this pattern:
1. Import common system configuration from `common/configuration.nix`
2. Import host-specific configuration from `hosts/{hostname}/configuration.nix`
3. Integrate Home Manager as a NixOS module
4. Set user-specific Home Manager configuration (either common or host-specific)

### Key Components
- **NixOS 25.05**: Base system using the upcoming NixOS release
- **Home Manager 25.05**: User environment management
- **Hyprland**: Window manager with virtual desktops plugin
- **Docker**: Containerization support enabled system-wide
- **User**: Primary user is `sylflo` with sudo privileges

## Common Commands

### Building and Switching Configurations
```bash
# Build and switch to desktop configuration
sudo nixos-rebuild switch --flake .#desktop

# Build and switch to personal-laptop configuration  
sudo nixos-rebuild switch --flake .#personal-laptop

# Build and switch to work-laptop configuration
sudo nixos-rebuild switch --flake .#work-laptop

# Test configuration without switching
sudo nixos-rebuild test --flake .#desktop

# Build configuration without switching
sudo nixos-rebuild build --flake .#desktop
```

### Flake Management
```bash
# Update flake inputs
nix flake update

# Show flake info
nix flake show

# Check flake
nix flake check
```

### Home Manager (if used standalone)
```bash
# Apply home manager configuration
home-manager switch --flake .#sylflo
```

## Configuration Details

### Host Differences
- **desktop**: Includes Steam, GNOME desktop, Sunshine remote desktop (with firewall exceptions)
- **personal-laptop & work-laptop**: Use common home configuration, minimal host-specific settings
- All hosts share common base configuration including Hyprland, Docker, basic system packages

### User Environment
The Home Manager configuration includes:
- Hyprland window manager with virtual desktops
- Firefox (LibreWolf) with privacy-focused policies and extensions
- VSCodium with Dracula theme
- Zsh with Oh My Zsh (agnoster theme)
- Various multimedia and development packages

### Key Features
- Experimental Nix features (flakes, nix-command) enabled
- Hyprland cachix binary cache configured
- Docker virtualization enabled
- Bluetooth support
- Japanese input method (ibus-mozc)
- Firewall enabled by default with service-specific exceptions