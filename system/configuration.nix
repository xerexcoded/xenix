# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "xenix"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.wifi.powersave = true;
  # Set your time zone.
  time.timeZone = "Asia/Calcutta";


  #power
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = true;
  services.ntp.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["modsetting"];
  services.xserver.useGlamor = true;
  services.xserver.deviceSection = ''Option
    "TearFree"
    "DRI"
    "2"
    "true"'';
  programs.light.enable = true;

  services.gnome.gnome-keyring.enable = true; 
  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  sound.mediaKeys.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput= {
   	enable = true;
	touchpad.tapping = true;
	touchpad.naturalScrolling = true;
 	touchpad.accelSpeed = "0.5";
	touchpad.middleEmulation = true;
	touchpad.tappingDragLock = false;
  };
 
 
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xeera = {
     isNormalUser = true;
     initialPassword = "123";
     shell = pkgs.fish;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
 


  #NUR
  nixpkgs.config.packageOverrides = pkgs: {
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
     inherit pkgs;

   };
  };
  services.emacs.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim nano # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget curl
     firefox 
     networkmanager
     curl
     pciutils usbutils
     git 
     feh
     sxiv
     emacs 
     bspwm
     sxhkd
     nur.repos.reedrw.picom-next-ibhagwan
     alacritty
     polybar rofi
     pavucontrol
     maim
     killall
     lxappearance
     unzip
     xclip
     ranger
     pcmanfm 
     brightnessctl

   ];

  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  boot.extraModulePackages = [config.boot.kernelPackages.broadcom_sta];
  nixpkgs.config.allowUnfree = true;
  boot.kernelModules = ["wl"];
  boot.initrd.kernelModules = ["kvm-intel" "wl"];
   

  #fonts 
  fonts.fonts = with pkgs; [
 	(nerdfonts.override {fonts = ["FiraCode" "Terminus" "Hack"];})
        noto-fonts
  	noto-fonts-cjk
	noto-fonts-emoji	
	

  ];
  
  #nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
	experimental-features = nix-command flakes
  '';


  # List services that you want to enable:
  
  

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

