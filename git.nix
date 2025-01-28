{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "anatofuz";
    userEmail = "anatofuz@gmail.com";
    extraConfig = {
      color = {
        ui = "auto";
        status = "auto";
        branch = "auto";
        grep = "auto";
        diff = "auto";
      };
      ghq = {
        root = [ "~/src" ];
      };
      pull.rebase = false;
      push.default = "current";
    };
    aliases = {
      st = "status";
      co = "checkout";
      ci = "commit -v";
      br = "branch";
      puhs = "push";
      psuh = "push";
      pus = "push";
      puh = "push";
      diffs = "diff --cached";
      cop = "!git branch --all | tr -d '* ' | grep -v -e '->' | peco | sed -e 's+remotes/[^/]*/++g' | xargs git checkout";
      r = "!git reflog -n 50 --pretty='format:%gs' | perl -anal -e '$seen{$1}++ or print $1 if /checkout:.*to (.+)/'";
    };
    lfs = {
      enable = true;
    };
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-markdown-preview
    ];
    settings = {
      editor = "vim";
    };
  };
}
