{config, ...}: {
  modules.nixos = {
    language = {
      layout = "fi";
      time = "Europe/Helsinki";
    };

    users = {
      jh-devv = {
        shell = config.modules.nixos.shell.package;
        isNormalUser = true;
        extraGroups = ["wheel" "i2c"];
      };
    };

    networking = {
      hostName = "aisu";
      networkmanager.enable = true;
    };

    desktop = {
      session = "hyprland";
    };

    boot = {
      systemd.enable = true;
      lanzaboote.enable = true;
    };

    services = {
      smart-card.enable = true;
      i2c.enable = true;
    };
  };

  system.stateVersion = "23.05";
}
