{config, ...}: {
  imports = [
    ./options.nix
  ];
  config = {
    inherit (config.modules.nixos) networking;
  };
}
