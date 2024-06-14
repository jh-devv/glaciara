{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.desktop;
in {
  config = mkIf (cfg.session == "hyprland") {
    modules.nixos = {
      services = {
        pipewire.enable = true;
        bluetooth.enable = true;
        gnome = {
          keyring.enable = true;
          polkit.enable = true;
          gdm.enable = true;
        };
      };
      programs = {
        wayland.enable = true;
        steam.enable = true;
      };
    };
    programs.hyprland = {
      enable = true;
    };
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };
}
