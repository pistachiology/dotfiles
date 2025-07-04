{ config, pkgs, libs, lib, ... }:
let
  overlays = [
    (final: prev: {
      tmux = prev.tmux.overrideAttrs
        (attrs: {
          buildInputs = attrs.buildInputs ++ [ pkgs.utf8proc ];
          configureFlags = attrs.configureFlags ++ [ "--enable-utf8proc" ];
        });
    })
  ];

  pluginName = p: if lib.types.package.check p then p.pname else p.plugin.pname;

  plugins = with pkgs; [
    tmuxPlugins.sensible
    tmuxPlugins.resurrect
    tmuxPlugins.continuum
    tmuxPlugins.yank
    tmuxPlugins.pain-control
    tmuxPlugins.copycat
    tmuxPlugins.open
    tmuxPlugins.battery
    tmuxPlugins.cpu
    tmuxPlugins.prefix-highlight
    tmuxPlugins.continuum
  ];
in
{
  home.packages = with pkgs; [ tmux ] ++ plugins;
  nixpkgs.overlays = overlays;

  xdg.configFile."tmux/tmux.conf".text = with lib; ''
    # terminal color
    set -g default-terminal "xterm-ghostty"
    # set -g default-terminal "screen-256color"
    # set-option default-terminal "tmux-256color"
    # set-option -ga terminal-overrides ",xterm-256color:Tc"
    set-option -sa terminal-overrides ",xterm*:Tc"
    # set -ga terminal-overrides ",xterm-256color:Tc"

    set-option -g default-shell "${pkgs.fish}/bin/fish"
    set -g default-command "${pkgs.fish}/bin/fish"

    # use system clipboard
    bind -T copy-mode-vi y send -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
    # handle osc52
    set -g set-clipboard on
    set -g mouse on

    setw -g mode-keys vi
    set -g status-keys vi
    set -g history-limit 500000

    # Vim style pane selection
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    bind -r H resize-pane -L 15
    bind -r J resize-pane -D 15
    bind -r K resize-pane -U 15
    bind -r L resize-pane -R 15

    bind -r Left resize-pane -L 15
    bind -r Down resize-pane -D 15
    bind -r Up resize-pane -U 15
    bind -r Right resize-pane -R 15


    unbind-key C-b
    set -g prefix 'C-a'

    ${if pkgs.stdenv.isDarwin then "" else "set-option -g prefix2 'C-b'"}
    bind-key 'C-a' send-prefix
    set-option -g renumber-windows on

    set -g base-index 1
    set -g pane-base-index 1

    # set-option -g status-position top

    set-option -g repeat-time 500

    # Removes ESC delay
    set -sg escape-time 0

    # bottom bar
    # set-window-option -g status-left " #S "
    run-shell '~/.tmux/custom_theme.sh'

    bind -r f run-shell "tmux neww ~/.tmux/bin/tmux-sessionizer"
    bind A run-shell "~/.tmux/bin/tmux-popup"

    # ============================================= #
    # Load plugins with Home Manager                #
    # --------------------------------------------- #
    ${(concatMapStringsSep "\n\n" (p: ''
      # ${pluginName p}
      # ---------------------
      ${p.extraConfig or ""}
      run-shell ${if types.package.check p then p.rtp else p.plugin.rtp}
    '') plugins)}
    # ============================================= #

  '';

  home.file.".tmux" = {
    source = ../config/tmux;
    recursive = true;
  };
}
