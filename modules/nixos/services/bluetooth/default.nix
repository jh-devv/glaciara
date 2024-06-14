{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.services.bluetooth;
in {
  config = mkIf cfg.enable {
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
  };
}
