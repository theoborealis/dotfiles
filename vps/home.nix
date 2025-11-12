{ inputs, username, homeDirectory, config, lib, pkgs, ... }:

{
  imports = [ ../dev/home.nix ];
  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  targets.genericLinux.enable = true;

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.05";

  nixpkgs.config = { users.defaultUserShell = pkgs.zsh; };

  programs.zsh.shellAliases = {
    hmu =
      "nix flake update --flake ~/.config/home-manager && NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake ~/.config/home-manager#${username}@vps";
  };

  gtk.enable = false;
  qt.enable = false;
}
