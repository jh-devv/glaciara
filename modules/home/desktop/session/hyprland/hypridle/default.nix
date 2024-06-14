{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.home.desktop;
in {
  config = mkIf ((cfg.session == "hyprland") && (cfg.power.lockscreen.enable || cfg.power.suspend.enable)) {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "hyprlock";
          ignore_dbus_inhibit = false;
        };
        listener =
          optionals cfg.power.lockscreen.enable [
            {
              timeout = cfg.power.lockscreen.timeout * 60;
              onTimeout = "loginctl lock-session";
            }
          ]
          ++ optionals cfg.power.suspend.enable [
            {
              timeout = cfg.power.suspend.timeout * 60;
              onTimeout = "systemctl suspend";
            }
          ];
      };
    };
    systemd.user.services.hypridle.Service.Environment = "PATH=$PATH:${makeBinPath [pkgs.hyprlock]}";
  };
}
