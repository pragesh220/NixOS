{ pkgs, ... }:
{
services.displayManager.ly = {
    enable = true;
    settings = {
        animation = 1;  # 0 = none | 1 = Cmatrix | 2 = PSX Fire, etc.
        bg = 0;
        fg = 7;
        hide_borders = false;
        margin_box = true;
        clock = "%c";
      };
  };
}  
