{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.home.programs.neovim;
in {
  config = mkIf cfg.enable {
    programs.neovim.enable = true;
  };
}
