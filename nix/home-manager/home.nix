{ config, pkgs, ... }:

{
  home.username = "dongmeng.199";
  home.homeDirectory = "/home/dongmeng.199";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    curl
    wget
    git

    # Dev stuff
    jq
    fx
    ripgrep
    fd
    just

    yazi
    neovim
    zoxide
    starship
    fzf
    lazygit
    mcfly
    antlr
    bottom
    semgrep

    #languages
    go
    python3
    cargo
    nodejs
  ];
  programs.home-manager.enable = true;
}

