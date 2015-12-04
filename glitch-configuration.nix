{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # boot loader
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # network
  networking.hostName = "glitch";
  networking.wireless.enable = true;
  systemd.network.enable = true;

  systemd.network.networks.wireless = {
    name = "wl*";
    DHCP = "v4";
  };

  systemd.network.networks.wired = {
    name = "en*";
    DHCP = "v4";
  };

  # internationalisation
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_AU.UTF-8";
  };

  # time zone
  time.timeZone = "Australia/Sydney";

  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
     i3 i3status dmenu chromium termite inconsolata
     htop lsof tmux tree rsync git strace wget
     python python3
  ];

  # X11
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.windowManager.i3.enable = true;

  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;

  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # user
  users.extraUsers.mike = {
     isNormalUser = true;
     uid = 1000;
  };

  # nixos version
  system.stateVersion = "15.09";

}
