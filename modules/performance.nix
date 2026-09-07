{ config, pkgs, ... }:

{
  # Kernel Sysctl Optimizations
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.max_map_count" = 2147483642;
  };

  # Compress RAM before swapping to disk
  zramSwap.enable = true;

  # Enable GameMode
  programs.gamemode.enable = true;

  # Custom eBPF CPU Scheduler (Active when supported by kernel)
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  # Gaming & Performance Tools
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    scx
    steam-run
    wineWow64Packages.stable
    winetricks
    lutris
    protonup-qt
    gamescope


  ];
}
