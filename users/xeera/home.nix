{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "xeera";
  home.homeDirectory = "/home/xeera";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";


  programs.gpg = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
  home.packages = with pkgs; [
    kitty
    redshift
    dust
    fish
    fzf
    pinentry_qt
    bpytop
    ripgrep
    fd
    neofetch
    lsd
    gcc
    pcmanfm
    zathura
    mpv
    emacs
    git-crypt
    gnupg
    bat
  ];

  nixpkgs.overlays = [
  (import (builtins.fetchTarball {
    url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  }))
  ];

 programs.neovim = {
  enable = true;
  package = pkgs.neovim-nightly;
 };

}
