{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    settings = {
      expandtab = true;
    };

    plugins = with pkgs.vimPlugins; [
      easy-align
      surround
      fugitive
      rhubarb
    ];

    extraConfig = ''
      set expandtab
      set sw=4 sts=2 ts=2
      set softtabstop=2
      set nocompatible
      set backupcopy=yes

      set noswapfile

      " deactive insert mode from jj to ESC
      inoremap <silent> jj <ESC>
      " align {{{
      " Start interactive EasyAlign in visual mode (e.g. vipga)
      xmap ga <Plug>(EasyAlign)

      " Start interactive EasyAlign for a motion/text object (e.g. gaip)
      nmap ga <Plug>(EasyAlign)
      " }}}
    '';
  };
}
