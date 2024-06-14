{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.home.programs.fractal;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [fractal];
  };
}
