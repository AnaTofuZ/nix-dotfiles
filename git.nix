{pkgs, ... } : {
   programs.git = {
      enable = true;
      userName = "anatofuz";
      userEmail = "anatofuz@gmail.com";
      extraConfig = {
         color = { ui = true; };
         ghq = { root = [ "~/src"]; };
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
