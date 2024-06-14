{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.services.smart-card;
in {
  config = mkIf cfg.enable {
    services = {
      pcscd.enable = true;
    };
  };
}
