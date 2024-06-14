{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.home.programs.kitty;
in {
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font.name = "JetBrainsMono Nerd Font";
      theme = "Catppuccin-Mocha";
    };
  };
}
