{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.services.cups;
in {
  config = mkIf cfg.enable {
    services.printing.enable = true;
  };
}
