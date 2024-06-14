{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.programs.wayland;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libnotify
      libsecret
      libvirt
      cliphist
      wl-clipboard
      wlr-randr
      kitty
    ];
  };
}
