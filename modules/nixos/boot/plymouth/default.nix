{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.boot.plymouth;
in {
  config = mkIf cfg.enable {
    boot = {
      plymouth.enable = true;
    };
  };
}
