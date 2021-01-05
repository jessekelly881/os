{ config, pkgs, system, ... }:

{
  imports = [ # Needed to build iso
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmpOnTmpfs = true;
  programs.bash.enableCompletion = true;
  networking.wireless.enable = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users = {
    jesse = {
      isNormalUser = true;
      home = "/home/jesse";
      description = "Jesse Kelly";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  services = {
    gnome3.gnome-keyring.enable = true;
    fstrim.enable = true;
    openssh.enable = true;
    printing.enable = true;
    blueman.enable = true;
    upower.enable = true;
    dbus = {
      enable = true;
      packages = [ pkgs.gnome3.dconf ];
    };
    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 25;
      layout = "us";
      displayManager.defaultSession = "none+xmonad";
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "jesse";
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
    compton = {
      enable = true;
      shadow = true;
      inactiveOpacity = 0.8;
    };
  };

}
