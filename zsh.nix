{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      defaultKeymap = "emacs";
      syntaxHighlighting.enable = true;
      enableCompletion = true;

      initExtra = ''
         unsetopt BEEP
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

         function dirfileuniq {
           local new_dirfile=$(cat $dirfile | perl -ne 'BEGIN{%dir;} chomp($_); $dir{$_}++; END{map { print "$_\n" if (-d $_) } keys %dir}')
           echo $new_dirfile >| $dirfile
         }

         function dirfile_frequency_cut {
           local new_dirfile=$(cat $dirfile | perl -ne 'BEGIN{%dir;} chomp($_); $dir{$_}++; END{map { print "$_\n" if (-d $_) } sort grep { $dir{$_} > 1} keys %dir}')
           echo $new_dirfile >| $dirfile
         }

         function dirfile_frequency {
          local new_dirfile=$(cat $dirfile | perl -ne 'BEGIN{%dir;} chomp($_); $dir{$_}++; END{map { print "$dir{$_} : $_\n" if (-d $_) } sort grep { $dir{$_} > 1} keys %dir}')
           echo $new_dirfile
         }


         function peco-z-search {
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

        function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}


        function peco-history-selection() {
            BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
            CURSOR=$#BUFFER
            zle reset-prompt
        }

        zle -N peco-history-selection
        bindkey '^R' peco-history-selection

        function phr() {
            BUFFER=`cat $HOME/.history | perl -CSD -nle 'print $1 if /\d+\s+\d{2}:\d{2}\s+(.*)/' | perl -e 'print reverse <>' | peco`
            CURSOR=$#BUFFER
            zle reset-prompt
        }
        zle -N phr
      '';

      shellAliases = {
        sl = "ls";
        gia = "git add";
        gs = "git status";
        gc = "git commit --verbose";
        gp = "git push";
        g = "cd $(ghq root)/$(ghq list | peco)";

        la = "ls -a";
        lal = "ls -la";
        ltr = "ls -ltr";
        latr = "ls -latr";

        drspec = "docker compose exec rails bin/rspec";
        drspec-skip-precompile = "docker compose exec -e SKIP_PRECOMPILE=true rails bin/rspec";
      };
    };
  };
}
