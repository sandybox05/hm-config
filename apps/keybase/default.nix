{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keybase
  ];

  services.keybase = {
    enable = true;
  };
}
