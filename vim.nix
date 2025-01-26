{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    settings = {
      expandtab = true;
    };

    extraConfig = ''
      set expandtab
      set sw=4 sts=2 ts=2
      set softtabstop=2
      set nocompatible
      set backupcopy=yes
    '';
  };
}
