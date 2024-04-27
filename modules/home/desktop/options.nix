{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.modules.home.desktop;
in {
  options.modules.home.desktop = {
    # The packages snippet below generates mkEnableOptions for the listed packages.
    # Though, you can still add more complex options for some packages using //.
    packages =
      lib.genAttrs ["code" "logseq" "fractal"] (k: {enable = mkEnableOption k;})
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

    # * https://github.com/catppuccin/nix/issues/96
    colorScheme = mkOption {
      default = inputs.nix-colors.colorSchemes.catppuccin-mocha;

      type = types.attrs;
      description = ''
        Your nix-colors scheme
      '';
    };

    gtk = {
      theme.package = mkOption {
        description = "The nixpkg for the gtk-theme";
        type = types.package;
        default = pkgs.catppuccin-gtk.override {
          accents = ["lavender"];
          variant = "mocha";
        };
      };
      iconTheme.package = mkOption {
        description = "The nixpkg for the gtk-icon theme";
        type = types.package;
        default = pkgs.catppuccin-papirus-folders;
      };
    };
    qt = {
      theme.package = mkOption {
        description = "The nixpkg for the qt-theme";
        type = types.package;
        default = pkgs.catppuccin-kvantum.override {
          accent = "Lavender";
          variant = "Mocha";
        };
      };
      name = mkOption {
        description = "The name of the package which it appears under";
        type = types.string;
        default = "kvantum";
      };
    };

    flatpak = {
      enable = mkEnableOption ''
        installing Flatpak applications with Nix from Home Manager
      '';
      packages = mkOption {
        example = ["com.obsproject.Studio"];

        type = types.listOf types.str;
        default = [""];
        description = ''
          You can choose few packages to install with Flatpak here.
           possible values: see Example.
        '';
      };
      groups = mkOption {
        example = ["media"];

        type = types.listOf types.str;
        default = [""];
        description = ''
          You can choose few package groups to install with Flatpak here.
          Though, these are just mine and how I see them!
           possible values: see Example.
        '';
      };
      overrides = mkOption {
        example = ''
          {
            com.visualstudio.code".Context.sockets = ["wayland" "!x11" "!fallback-x11"];
            global.Environment.LC_ALL = "C.UTF-8";
          };
        '';
        description = ''
          Applies provided attributes into Flatpak overrides file.
        '';
        type = with types; attrsOf (attrsOf (attrsOf (either str (listOf str))));
        default = {};
      };
    };
    power = {
      lockscreen = {
        enable = mkEnableOption "automatic system lockscreen";
        timeout = mkOption {
          default = 5;
          example = 5;

          type = types.int;
          description = "Timeout for automatic system lockscreen (in minutes)";
        };
      };
      hibernation = {
        enable = mkEnableOption "automatic system hibernation";
        timeout = mkOption {
          default = 30;
          example = 30;

          type = types.int;
          description = "Timeout for automatic system hibernation (in minutes)";
        };
      };
    };
    session = mkOption {
      example = ["hyprland"];

      type = types.enum ["hyprland" null];
      default = "hyprland";
      description = ''
        The session you want to use (DE or WM with everything around)
        Make sure to also enable it from NixOS
      '';
    };
    wallpaper = mkOption {
      type = types.path;
      description = "Configuration for settings the current wallpaper set on system boot";
      default = builtins.toString "${inputs.self}/assets/city.png";
    };

    displays = mkOption {
      description = "Config for new displays";
      type = with types;
        listOf (
          submodule {
            options = {
              name = mkOption {
                type = str;
                description = "The name of the display, e.g. eDP-1";
              };

              wallpaper = mkOption {
                type = path;
                default = cfg.wallpaper;
                description = "The local Flake path of the wallpaper for the given display.";
              };

              hyprland = mkOption {
                type = str;
                description = ''
                  Hyprland config for the monitor, see
                  https://wiki.hyprland.org/Configuring/Monitors/

                  e.g. 3440x1440@165,0x0,1.25
                '';
                default = "preferred,auto,auto";
              };

              workspaces = mkOption {
                type = listOf int;
                description = "List of workspace strings";
                default = [1 2 3 4 5 6 7 8 9 10];
              };
            };
          }
        );
      default = [];
    };
  };
}
