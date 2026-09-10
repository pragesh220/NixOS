# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/fish.nix
      ./modules/nvidia.nix
      ./modules/ly.nix
      ./modules/performance.nix
      ./modules/ai.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Polkit 
  security.polkit.enable = true; 
  security.wrappers.pkexec.enable = pkgs.lib.mkForce true;

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable power.prpfile.daemon 
  services.power-profiles-daemon.enable = true; # Or services.tuned.enable
  
  services.upower.enable = true;

  programs.nix-ld.enable = true;

  
  # Enable Niri
  programs.niri.enable = true;

  xdg.portal.config.niri = {
  "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
  };

  # Enable Fstrim
  services.fstrim.enable = true;

 
  # File Manger (Thunar and plugins)
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
    ristretto
  ];
  services.gvfs.enable = true;
  services.tumbler.enable = true; 

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  }; 


  # Enable mate-polkit 
  systemd.user.services.polkit-mate-authentication-agent-1 = {
    description = "polkit-mate-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;

    };
  };
  

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."pragesh220" = {
    isNormalUser = true;
    description = "Pragesh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    fastfetch
    brave
    kdePackages.kate
    btop
    cava
    libreoffice
    grim
    slurp
    wl-clipboard
    socat
    vlc
    pciutils
    noctalia
    motrix-next

    # Programming stuffs
    gcc 
    gnumake 
    cmake 
    gdb
    python3 
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
    xwayland-satellite # xwayland support
    qutebrowser
    zed-editor

    # Terminal Stuffs
    kitty
    eza
    starship
    mako
    bat
    cmatrix
    zathura   # Terminal_PDF_Viewer


    #polkit
    mate-polkit

    #FileSystems 
    file-roller
    unzip
    zip
    xdg-user-dirs
    xdg-utils
    kdePackages.filelight

   #THEMES AND CUSTOMIZATIONS
    nwg-look
    gimp
   
   ];
 
  fonts.packages = with pkgs; [
    google-fonts

   ]; 

   # Automatically mount secondary HDD on boot
  fileSystems."/run/media/pragesh220/D" = {
    device = "/dev/disk/by-uuid/98d7baf9-06fa-4a9b-86e3-543b24b5674b";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
# Auto Cleanup
nix = {
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  settings.auto-optimise-store = true;
}; 

# Cuda binary cache
nix.settings = {
  substituters = [ "https://cache.nixos-cuda.org" ];
  trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
};

 # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
