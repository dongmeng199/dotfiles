{ config, pkgs, libs, ... }:
{
  programs.starship = {
    enable = true;
    enableNushellIntegration = false;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };
      directory = {
        truncate_to_repo=false;
        truncation_length=0;
      };
    };
  };
}

