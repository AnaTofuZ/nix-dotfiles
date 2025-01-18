{ config, pkgs, ... }:

{
  home = rec {
    username = "anatofuz";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
     bat
     httpie
     ripgrep
     mdcat
     ghq
     peco
     vim
  ];

  imports = [
    ./git.nix
  ];
}
