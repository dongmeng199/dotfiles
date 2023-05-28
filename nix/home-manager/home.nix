{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    # Some basics
    coreutils
    curl
    wget

    # Dev stuff
    jq
    ripgrep
    fd
    httpie
  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];

  imports = [
    ./modules/alacritty.nix
    ./modules/nu.nix
    ./modules/starship.nix
    ./modules/tmux.nix
    ./modules/git.nix
    ./modules/lazygit.nix
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    lf = {
      enable = true;
    };

    # programs.lazygit.settings = '' '' ;
    zoxide = {
      enable = true;
      enableNushellIntegration = false;
    };
  };
}
