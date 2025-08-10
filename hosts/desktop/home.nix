{ pkgs, lib, ... }:

let
  stopScript = pkgs.writeShellScript "hyprland-stop" ''
    pid=$(pgrep Hyprland)
    if [ -n "$pid" ]; then
      kill -STOP "$pid"
    fi
  '';

  contScript = pkgs.writeShellScript "hyprland-cont" ''
    pid=$(pgrep Hyprland)
    if [ -n "$pid" ]; then
      kill -CONT "$pid"
    fi
  '';
in {
  imports = [
    ../../common/home.nix
  ];

  systemd.user.services.hyprland-pause = {
    Unit = {
      Description = "Pause Hyprland before suspend";
      Before = [ "sleep.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = stopScript;
    };

    Install = {
      WantedBy = [ "sleep.target" ];
    };
  };

  systemd.user.services.hyprland-resume = {
    Unit = {
      Description = "Resume Hyprland after suspend";
      After = [ "sleep.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = contScript;
    };

    Install = {
      WantedBy = [ "suspend.target" ];
    };
  };
}
