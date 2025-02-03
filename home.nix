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
    awscli2
    azure-cli
    bat
    bitwarden-desktop
    discord
    emacs
    fd
    ghq
    go-task
    gojq
    httpie
    hub
    jq
    kubectl
    kubelogin
    mdcat
    mmv-go
    mycli
    peco
    ripgrep
    slack
    tmux
    unar
    vscode
    wezterm
    xsel
    yq
    zoom-us
  ];

  home.file.".config/peco/config.json" = {
    text = ''
      {
          "Keymap": {
              "C-j":"peco.SelectDown",
              "C-k":"peco.SelectUp",
              "C-d":"peco.ScrollPageDown",
              "C-b":"peco.ScrollPageUp"
          }
      }
    '';
  };

  imports = [
    ./git.nix
    ./browser.nix
    ./input-method.nix
    ./zsh.nix
    ./direnv.nix
    ./vim.nix
  ];
}
