{ config, pkgs, lib, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "meng.dong";
    userEmail = "2497223924@qq.com";

    delta = {
      enable = true;
      options = {
        syntax-theme = "solarized-dark";
        side-by-side = true;
      };
    };

    extraConfig = {
      # http.proxy = "socks5h://127.0.0.1:1086";

      init.defaultBranch = "main";

      pull.rebase = true;
      push.autoSetupRemote = true;

      core.editor = "nvim";
      core.fileMode = false;
      core.ignorecase = false;

      merge.conflictstyle = "diff3";

      url = {
        "ssh://git@gitlab.hoxigames.com" = {
          insteadOf = "https://gitlab.hoxigames.com";
        };
      };
    };
  };
}
