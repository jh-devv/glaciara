{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.home.programs.newsboat;
in {
  config = mkIf cfg.enable {
    programs.newsboat.enable = true;
  };
}
