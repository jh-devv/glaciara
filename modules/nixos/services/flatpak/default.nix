{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.services.flatpak;
in {
  config = mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
