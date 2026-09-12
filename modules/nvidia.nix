{ config, pkgs, ... }:

{
  # Enable graphics driver support
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for 32-bit Wine/Steam games
    extraPackages32 = [
      config.hardware.nvidia.package.lib32
    ];
  };

  # Tell X11 / Wayland which drivers to use
  # "modesetting" handles the Intel iGPU, "nvidia" handles the dGPU —
  # both are required for offload mode to actually let the dGPU sleep
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  # Configure NVIDIA driver options
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    modesetting.enable = true;
    open = false;
    powerManagement.enable = true;
    nvidiaSettings = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:2@0:0:0";
    };
  };
}
