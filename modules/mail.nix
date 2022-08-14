{ config, pkgs, ... }:
let
  pass = "${config.programs.password-store.package}/bin/pass";
in
{

  programs.mbsync.enable = true;
  services.mbsync.enable = true;
  programs.msmtp.enable = true;

  home.packages = with pkgs; [ mailcap ];

  accounts.email = {
    maildirBasePath = "mail";
    accounts = {
      itua = rec {
        primary = true;
        address = "im@itua.dev";
        userName = "tua@allite.io";
        realName = "Nuttapol Laoticharoen";
        passwordCommand = "${pass} mail/${address}";

        imap = {
          host = "imap.fastmail.com";
          port = 993;
        };

        smtp = {
          host = "smtp.fastmail.com";
          port = 465;
        };

        jmap = {
          host = "fastmail.com";
          sessionUrl = "https://jmap.fastmail.com/.well-known/jmap";
        };

        msmtp.enable = true;
        neomutt = {
          enable = true;
          extraMailboxes = [ "Drafts" "Sent" "Trash" "Archive" "Jobs" ];
        };
        mbsync = {
          enable = true;
          create = "maildir";
          expunge = "both";
        };
      };
    };
  };

  home.file.".mailcap".text = ''
    # text/html; lynx -stdin -dump | bat
    text/html; elinks -dump -dump-color-mode 1 | bat
  '';

  home.file.".lynxrc".text = ''
    vi_keys=on
  '';
}

