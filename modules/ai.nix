{ config, pkgs, ... }:

{
  # 1. Enable Ollama service with NVIDIA CUDA acceleration
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # 2. Enable Open WebUI
  services.open-webui = {
    enable = true;
    port = 8080;
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
    };
  };

  # 3. Add Stable Diffusion FHS environment runner
  environment.systemPackages = [
    (pkgs.buildFHSEnv {
      name = "a1111-fhs";
      targetPkgs = pkgs: (with pkgs; [
        python311
        git-lfs
        stdenv.cc.cc.lib
        glib
        libGL
        openssl
        cudaPackages.cudatoolkit
        cudaPackages.cudnn
        libX11
        libXext
        libXrender
        libXinerama
        libXi
        libXrandr
        libXcursor
      ]);
      runScript = "bash";
    })
  ];
}
