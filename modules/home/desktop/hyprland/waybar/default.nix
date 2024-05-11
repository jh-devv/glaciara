{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.home.desktop;
in {
  config = mkIf (cfg.session == "hyprland") {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [
        {
          margin = "8px 15px -2px 15px";
          exclusive = true;
          passthrough = false;

          output = map (screen: screen.name) cfg.displays;

          gtk-layer-shell = true;

          layer = "top";
          position = "top";
          mod = "dock";

          modules-left = ["custom/nix" "hyprland/workspaces" "hyprland/window"];
          modules-center = ["custom/media"];
          modules-right = ["tray" "pulseaudio" "clock" "custom/powermenu"];

          "custom/nix" = {
            format = " ";
            tooltip = false;
            on-click = "rofi -show drun -show-icons";
          };
          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "●";
          };
          "clock" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format = " {:%H:%M}";
          };
          "hyprland/window" = {
            max-length = 48;
            format = "{}";
          };
          "custom/media" = {
            format = "{icon} <span>{}</span>";
            return-type = "json";
            max-length = 30;
            exec = "playerctl -a metadata --format '{\"text\": \"{{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{artist}} - {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
            on-click = "playerctl play-pause";
            on-click-middle = "playerctl previous";
            on-click-right = "playerctl next";
            format-icons = {
              Playing = "<span>󰒮 󰐌 󰒭</span>";
              Paused = "<span>󰒮 󰏥 󰒭</span>";
            };
          };
          "pulseaudio" = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon}⠀ {volume}%";
            format-muted = "󰝟";
            format-icons = {
              headphone = "";
              hands-free = "󰋋";
              headset = "󰋎";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click-middle = "pamixer -t";
            on-scroll-up = "pamixer -i 5";
            on-scroll-down = "pamixer -d 5";
            scroll-step = 1;
            on-click = "pavucontrol";
          };
          "tray" = {
            spacing = 10;
          };
          "custom/powermenu" = {
            on-click = "rofi -show power-menu -modi power-menu:'rofi-power-menu'";
            format = "";
          };
        }
      ];
      style = ''
        ${builtins.readFile ./css/theme.css}
        ${builtins.readFile ./css/style.css}
      '';
    };
    systemd.user.services.waybar.Service.Environment = "PATH=$PATH:${makeBinPath [pkgs.playerctl pkgs.pamixer]}";
    services.mpris-proxy.enable = true;
  };
}
