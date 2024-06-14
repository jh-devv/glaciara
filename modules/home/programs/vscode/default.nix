{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.home.programs.vscode;
in {
  config = mkIf cfg.enable {
    programs.vscode.enable = true;
  };
}
