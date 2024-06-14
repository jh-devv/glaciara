{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.home.programs.mpv;
  video-player = "mpv.desktop";
  audio-player = "mpv.desktop";
  image-viewer = "mpv.desktop";
in {
  config = mkIf cfg.enable {
    xdg.mimeApps = optionalAttrs (options ? modules.home.desktop.session) {
      enable = true;
      defaultApplications = {
        "video/*" = [video-player];
        "audio/*" = [audio-player];
        "image/*" = [image-viewer];
      };
    };
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [mpris];
    };
    home = {
      packages = with pkgs; [playerctl cava];
      shellAliases = {
        mpvm = "mpv --vf=scale=350:-1 --loop-playlist=inf --shuffle";
      };
    };
  };
}
