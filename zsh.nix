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
        };
      };
  };
}
