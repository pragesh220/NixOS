{ config, pkgs, inputs, ... }:

{
  home.username = "pragesh220";
  home.homeDirectory = "/home/pragesh220";

  # Keep this at the version you initially chose.
  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    papirus-icon-theme
    papirus-folders
    bibata-cursors
    flat-remix-icom-theme
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 24;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.configFile."starship.toml".source = ./starship.toml;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}

