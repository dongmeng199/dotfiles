{ config, pkgs, libs, ... }:
{
  programs.nushell = {
    enable = true;
    envFile.text = ''
      let-env PATH =  [
         $"/Users/($env.USER)/.nix-profile/bin"
         $"/etc/profiles/per-user/($env.USER)/bin"
         "/run/current-system/sw/bin"
         "/nix/var/nix/profiles/default/bin"
         "/opt/homebrew/bin"
         "/usr/local/bin"
         "/usr/bin"
         "/usr/sbin"
         "/bin"
         "/sbin"
      ]
      let-env EDITOR = "nvim"
      # let-env http_proxy = "http://127.0.0.1:1087"
    '';

    #configFile.text = ''
    #'';

    extraEnv = ''
      def mkdir_if_not_exit [path: string] {
        if not ($path | path exists) {
          mkdir $path
        }
      }

      let starship_cache = $"($env.HOME)/.cache/starship"
      mkdir_if_not_exit $starship_cache
      ${pkgs.starship}/bin/starship init nu | save --force $'($starship_cache)/init.nu'

      let zoxide_cache = $"($env.HOME)/.cache/zoxide"
      mkdir_if_not_exit $zoxide_cache
      ${pkgs.zoxide}/bin/zoxide init nushell | save --force $'($zoxide_cache)/init.nu'
    '';

    extraConfig = ''

      def tmux_auto_start [] {
        if $env.TMUX? == null {
          tmux
        }
      }

      def rebuild [] {
        let path = $"($env.HOME)/Code/dotfiles/nix"
        cd $path
        "result/sw/bin/darwin-rebuild switch --flake .#mac-mini" | sh
      }

      source ~/.cache/starship/init.nu
      source ~/.cache/zoxide/init.nu

      tmux_auto_start
    '';


    shellAliases = {
      v = "nvim";
      lg = "lazygit";
      j = "joshuto";
    };
  };
}

