{ config, pkgs, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "pistachiology";
    userEmail = "im@itua.dev";

    ignores = [ ];

    aliases = {
      lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      lg = "!\"git lg1\"";
      parent = "!git show-branch | grep '*' | grep -v \"$(git rev-parse --abbrev-ref HEAD)\" | head -n1 | sed 's/.*\\[\\(.*\\)\\].*/\\1/' | sed 's/[\\^~].*//' #";
    };

    extraConfig = {
      colors = {
        branch = "auto";
        diff = "auto";
        interactive = "auto";
        status = "auto";
        ui = "true";
        pager = "true";
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
      };
    };

    delta = {
      enable = true;
      options = {
        plus-color = "#012800";
        minus-color = "#340001";
        syntax-theme = "DarkNeon";
      };
    };
  };
}
