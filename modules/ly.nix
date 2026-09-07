{ pkgs, ... }:
{
  environment.etc."ly/blackhole-smooth-240x67.dur".source =
    ./blackhole-smooth-240x67.dur;

  services.displayManager.ly = {
    enable = true;

    settings = {
      # Black Hole animation
      animation = "dur_file";
      dur_file_path = "/etc/ly/blackhole-smooth-240x67.dur";

      # Required for the 256-color DUR file
      full_color = true;

      # Animation speed
      animation_frame_delay = 5;
      animation_timeout_sec = 0;

      # Colors
      bg = "0x00000000";
      fg = "0x00FFFFFF";

      hide_borders = false;
      margin_box = true;
      clock = "%c";
    };
  };
}
