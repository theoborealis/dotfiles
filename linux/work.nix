{
  lib,
  pkgs,
  username,
  homeDirectory,
  ...
}:
{
  imports = [ ../dev/home.nix ];

  nixpkgs.config = {
    users.defaultUserShell = pkgs.zsh;
  };
  targets.genericLinux = {
    enable = true;
    gpu.enable = false;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "25.05";
    sessionVariables = {
      TERM = "xterm-256color";
      SSH_AUTH_SOCK = "/run/user/1000/sshf.sock";
    };
    shellAliases = {
      hmu = "NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake 'path:${homeDirectory}/.config/home-manager#work@linux' --impure";
    };
  };

  home.packages = with pkgs; [
    fastfetch
  ];

  systemd.user = {
    enable = true;
    systemctlPath = "/usr/bin/systemctl";
    startServices = "sd-switch";
  };

  services = {
    home-manager.autoExpire = {
      enable = true;
      frequency = "weekly";
      timestamp = "-7 days";
      store.cleanup = true;
    };
  };

  programs.zsh = {
    enable = true;
    initContent = lib.mkBefore ''
      ZSH_DISABLE_COMPFIX=true
    '';
  };
}
