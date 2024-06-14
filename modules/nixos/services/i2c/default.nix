{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.services.i2c;
in {
  config = mkIf cfg.enable {
    hardware.i2c.enable = true;
  };
}
