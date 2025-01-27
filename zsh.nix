{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      defaultKeymap = "emacs";
      syntaxHighlighting.enable = true;
      enableCompletion = true;

      initExtra = ''
        function peco-kill(){
            for pid in `ps aux| peco --prompt "PROCESS >" |awk '{ print $2 }'`
            do
                kill $pid
                echo "Killed $pid"
            done
        }
        alias pk="peco-kill"
        export dirfile="$HOME/.dirfile"

        autoload -Uz add-zsh-hook
        autoload -Uz chpwd_recent_dirs cdr
        add-zsh-hook chpwd chpwd_recent_dirs

        function save_dir_history {
            echo $PWD >>| $dirfile
        }

        chpwd_functions+=save_dir_history

        function hd {
            cd $(cat $dirfile | tail -1)
        }

        function peco-z-search
        {
            which peco > /dev/null
            if [ $? -ne 0 ]; then
                echo "Please install peco "
                return (1)
            fi
            local res=$(cat $dirfile | perl -CSD -ne 'BEGIN{%dir;} chomp($_); $dir{$_}++; END{map { print "$_\n" if (-d $_) } grep { $_ !~ /game/ } keys %dir}' | peco)
            if [ -n "$res" ]; then
                BUFFER+="cd $res"
                zle accept-line
                else
                    return 1
                fi
         }
        zle -N peco-z-search
        bindkey '^[pz' peco-z-search
      '';

      shellAliases = {
        sl = "ls";
        gs = "git status";
        gc = "git commit";
        gp = "git push";
        g = "cd $(ghq root)/$(ghq list | peco)";

        la = "ls -a";

        drspec = "docker compose exec rails bin/rspec";
        drspec-skip-precompile = "docker compose exec -e SKIP_PRECOMPILE=true rails bin/rspec";
      };
    };
  };
}
