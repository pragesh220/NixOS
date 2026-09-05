{pkgs, ... }:

{
# Enable Fish_shell globally
programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Disable greeting
      set -g fish_greeting ""

      # Initialize starship prompt
      starship init fish | source
    '';

    shellAliases = {
      # Replace ls with eza
      ls = "eza -al --color=always --group-directories-first --icons=always";
      la = "eza -a --color=always --group-directories-first --icons=always";
      ll = "eza -l --color=always --group-directories-first --icons=always";
      lt = "eza -aT --color=always --group-directories-first --icons=always";

      # Navigation shortcuts
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      # Common utilities
      tarnow = "tar -acf ";
      untar = "tar -zxvf ";
      wget = "wget -c ";
      psmem = "ps auxf | sort -nr -k 4";
      psmem10 = "ps auxf | sort -nr -k 4 | head -10";
      dir = "dir --color=auto";
      vdir = "vdir --color=auto";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      hw = "hwinfo --short";
      tb = "nc termbin.com 9999";
      jctl = "journalctl -p 3 -xb";
      cat = "bat";
      v = "nvim";
      vim = "nvim";

      # NixOS equivalents for system updates and cleanup
      update = "sudo nixos-rebuild switch --flake .#nixos";
      cleanup = "sudo nix-collect-garbage -d";
  };
};
# Set Fish as default shell for pragesh220
  users.users."pragesh220".shell = pkgs.fish;
}

