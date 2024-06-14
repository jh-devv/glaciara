{
  lib,
  pkgs,
  ...
}:
with lib; {
  options.modules.home.programs =
    genAttrs ["fractal" "kitty" "mpv" "nautilus" "neovim" "newsboat" "text-editor" "vscode"] (k: {enable = mkEnableOption k;})
    // {
      firefox = {
        enable = mkEnableOption "firefox";
        theme.package = mkOption {
          example = pkgs.firefox-gnome-theme;

          type = types.nullOr types.package;
          default = pkgs.firefox-gnome-theme;
          description = ''
            An user theme you want to apply
          '';
        };
      };
    };
}
