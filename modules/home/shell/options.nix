{
  lib,
  pkgs,
  ...
}:
with lib; {
  options.modules.home.shell = {
    subtitutes.enable = mkEnableOption "list of subtitutes for common shell tools";
    fetcher.package = mkOption {
      type = types.package;
      description = ''
        Which fetcher (e.g. neofetch, nitch, hyfetch) you want to use
      '';
      example = pkgs.hyfetch;
      default = pkgs.nitch;
    };
    package = mkOption {
      type = types.package;
      description = ''
        Select the shell you want to use.
      '';
      example = pkgs.bash;
      default = pkgs.zsh;
    };
  };
}
