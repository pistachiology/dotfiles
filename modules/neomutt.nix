{ config, pkgs, libs, lib, ... }:
{
  programs.neomutt = {
    enable = true;
    vimKeys = true;
    checkStatsInterval = 60;
    sidebar = {
      enable = true;
      width = 30;
    };

    binds = [
      {
        action = "view-mailcap";
        key = "<return>";
        map = [ "attach" ];
      }
    ];

    macros = [
      {
        action = "<sidebar-next><sidebar-open>";
        key = "J";
        map = [ "index" "pager" ];
      }
      {
        action = "<sidebar-prev><sidebar-open>";
        key = "K";
        map = [ "index" "pager" ];
      }
    ];

    extraConfig = ''
      alternative_order text/plain text/enriched text/html
      auto_view text/html
      set mailcap_path   = ~/.mailcap

      set new_mail_command="notify-send 'New Email' '%n new messages, %u unread.' &"

      # nord theme
      # source https://github.com/marcothms/mutt-nord/blob/master/nord.theme
      color normal           default default             # default colours
      color index            brightblue default ~N       # new messages
      color index            red default ~F              # flagged messages
      color index            blue default ~T             # tagged messages
      color index            brightred default ~D        # deleted messages
      color body             brightgreen default         (https?|ftp)://[\-\.+,/%~_:?&=\#a-zA-Z0-9]+  # links
      color body             brightgreen default         [\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+          # email-addresses
      color attachment       magenta default             # attachments
      color signature        brightwhite default         # sigs
      color search           brightred black             # highlight results

      color indicator        black cyan                  # currently highlighted message
      color error            red default                 # error messages
      color status           white brightblack           # status line
      color tree             white default               # thread tree arrows
      color tilde            cyan default                # blank line padding

      color hdrdefault       brightblue default          # default headers
      color header           cyan default "^From:"
      color header           cyan default "^Subject:"

      color quoted           cyan default                # quote colours
      color quoted1          brightcyan default
      color quoted2          blue default
      color quoted3          green default
      color quoted4          yellow default
      color quoted5          red default
    '';
  };
}


