{lib, ...}:
with lib; {
  options.modules.nixos.services =
    genAttrs ["bluetooth" "cups" "flatpak" "i2c" "pipewire" "smart-card"] (k: {enable = mkEnableOption k;})
    // {
      gnome = genAttrs ["gdm" "keyring" "polkit"] (k: {enable = mkEnableOption k;});
    };
}
