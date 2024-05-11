{lib, ...}:
with lib; {
  options.modules.nixos.boot =
    genAttrs ["systemd" "secure-boot" "plymouth"] (k: {enable = mkEnableOption k // {default = true;};})
    // {
      kernel.configuration.enable = mkEnableOption "kernel configuration";
    };
}