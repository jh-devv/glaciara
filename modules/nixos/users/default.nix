{config, ...}: {
  imports = [
    ./options.nix
  ];
  config = {
    users = {inherit (config.modules.nixos) users;};
  };
}
