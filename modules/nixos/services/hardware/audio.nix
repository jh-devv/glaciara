{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.services.hardware.audio;
in {
  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
