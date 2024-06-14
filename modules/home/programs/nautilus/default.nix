{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.home.programs.nautilus;
  file-explorer = "org.gnome.Nautilus.desktop";
  zip-manager = "org.gnome.FileRoller.desktop";
in {
  config = mkIf cfg.enable {
    xdg.mimeApps = mkIf (config.modules.home.desktop.session != "") {
      enable = true;
      defaultApplications = {
        "application/zip" = [zip-manager];
        "inode/directory" = [file-explorer];
      };
    };
    home.packages = with pkgs.gnome; [nautilus file-roller];
  };
}
