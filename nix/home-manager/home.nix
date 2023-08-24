{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    # Some basics
    coreutils
    curl
    wget

    lazydocker
    mycli
    # Dev stuff
    jq
    fx
    ripgrep
    fd
    just
    httpie
    ast-grep
    nodePackages.cspell
    golangci-lint
    protobuf3_20
    protoc-gen-go
    protoc-gen-go-grpc
    sd

    # languages
    go
    python3
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
      enableNushellIntegration = true;
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

    fzf = {
      enable = true;
    };
  };
}
