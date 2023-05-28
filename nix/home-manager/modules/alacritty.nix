{ config, pkgs, libs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "SauceCodePro Nerd Font";
        normal.style = "Regular";
        bold.style = "Bold";
        italic.style = "Italic";
        size = 24;
      };
      shell = {
        program = "${pkgs.nushell}/bin/nu";
      };
      window = {
        padding = {
          x= 5;
          y= 5;
        };
        dynamic_padding = false;
        startup_mode= "Maximized";
        decorations = "buttonless";
      };
    };
  };
}
