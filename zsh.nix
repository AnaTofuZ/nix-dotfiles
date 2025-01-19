{
   programs = {
      zsh = {
	enable = true;
	dotDir = ".config/zsh";
        defaultKeymap = "emacs";
        syntaxHighlighting.enable = true;
        enableCompletion = true;
	
	shellAliases = {
	   gs = "git status";
	   gc = "git commit";
	   gp = "git push";
	   g  = "cd $(ghq root)/$(ghq list | peco)";

	   la = "ls -a";
        };
      };
  };
}
