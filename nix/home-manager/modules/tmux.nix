{ config, pkgs, libs, ... }:
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    baseIndex = 1;
    mouse = true;
    prefix = "C-e";
    shell = "${pkgs.nushell}/bin/nu";
    newSession = true;
    extraConfig = ''
      set -g default-terminal screen-256color
      set-option -ga terminal-overrides ",*256col*:Tc" #这句是关键
      set -g default-command "${pkgs.nushell}/bin/nu"

      set -g display-panes-time 4000
      unbind '"'
      unbind %
      unbind c

      bind t new-window 
      bind p previous-window
      bind n next-window
    '';

    plugins = [
      {
        plugin = pkgs.tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-plugins "cpu-usage ram-usage time"
          set -g @dracula-git-disable-status false 
          set -g @dracula-show-flags true
          set -g @dracula-show-left-icon window
          set -g @dracula-show-timezone false
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.vim-tmux-navigator;
      }
    ];

  };
}
