{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.services.desktop-manager.gdm;
in {
  config = mkIf cfg.enable {
    services = {
      libinput.enable = true;
      xserver = {
        enable = true;
        displayManager.gdm = {
          enable = true;
          wayland = true;
        };
        excludePackages = [pkgs.xterm];
      };
    };
  };
}
