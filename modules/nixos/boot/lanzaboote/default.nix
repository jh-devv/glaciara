{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.boot.lanzaboote;
in {
  config = mkIf cfg.enable {
    boot = {
      loader.systemd-boot.enable = mkForce (!cfg.enable);

      lanzaboote = mkIf cfg.enable {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };

    environment.systemPackages = with pkgs; [
      sbctl
      efibootmgr
      e2fsprogs.bin
    ];
  };
}
