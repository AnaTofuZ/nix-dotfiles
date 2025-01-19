{ config, pkgs, ... }:

{
  home = rec {
    username = "anatofuz";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  home.sessionVariables = {
    EDITOR = "vim";
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
     bitwarden-desktop
     slack
     wezterm
  ];

  imports = [
    ./git.nix
    ./browser.nix
    ./input-method.nix
    ./zsh.nix
    ./direnv.nix
  ];
}
