{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.programs.steam;
in {
  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
      };
      gamemode.enable = true;
    };
  };
}
