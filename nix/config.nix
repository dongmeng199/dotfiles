{ pkgs, lib, ... }:
{
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.trusted-users = [
    "@admin"
  ];
  nix.configureBuildUsers = true;

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
  ];

  programs.nix-index.enable = true;

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
     recursive
     (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
   ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  system.defaults = {
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = true;
      dock.autohide = true;
      NSGlobalDomain.AppleShowAllExtensions = true;
      NSGlobalDomain.InitialKeyRepeat = 10;
      NSGlobalDomain.KeyRepeat = 1;
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    #casks = [ "raycast" "amethyst" "google-chrome" "obsidian"];
    casks = [ "raycast" "amethyst" "obsidian" "dropbox"];
  };
}
