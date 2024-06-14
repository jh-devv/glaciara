{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.home.programs.text-editor;
  text-editor = "org.gnome.TextEditor.desktop";
in {
  config = mkIf cfg.enable {
    xdg.mimeApps = optionalAttrs (options ? modules.home.desktop.session) {
      enable = true;
      defaultApplications = {
        "text/plain" = [text-editor];
      };
    };
    home.packages = with pkgs; [gnome-text-editor];
  };
}
