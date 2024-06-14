{config, ...}: let
  cfg = config.modules.nixos.language;
in {
  imports = [
    ./options.nix
  ];
  config = {
    services.xserver.xkb.layout = cfg.layout;
    console.useXkbConfig = true;

    i18n.defaultLocale = cfg.locale;

    time.timeZone = cfg.time;
  };
}
