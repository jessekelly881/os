{ config, pkgs, system, lib, ... }:

{
  # Whitelist for non "free" software.
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "android-studio-stable"
  ];

  imports = [ # Needed to build iso
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmpOnTmpfs = true;
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  location.provider = "geoclue2";

  networking = {
    hostName = "deepblue";
    wireless.enable = true;
  };

  programs = {
    bash.enableCompletion = true;
    tmux = {
        enable = true;
        newSession = true;
    };
  };

  users.users.jesse = {
      isNormalUser = true;
      home = "/home/jesse";
      description = "Jesse Kelly";
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };

  hardware = {
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # core tools
    nodejs
    git
    vim
    emacs
    android-studio

    # user tools
    qutebrowser
    firefox
    mpv-with-scripts # https://nixos.wiki/wiki/MPV

  ];

  services = {
    gnome3.gnome-keyring.enable = true;
    thinkfan.enable = true;
    locate.enable = true;
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
      xkbOptions = "caps:swapescape";
      layout = "us";
      displayManager = {
        defaultSession = "none+i3";
        autoLogin.enable = true;
        autoLogin.user = "jesse";
        lightdm.enable = true;
      };
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
    compton = {
      enable = true;
      shadow = true;
      inactiveOpacity = 0.8;
    };
    redshift = {
      enable = true;
      temperature.day = 6500;
      temperature.night = 2700;
    };
  };

  programs.zsh.enable = true;

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      dejavu_fonts
      freefont_ttf
      google-fonts
      inconsolata
      liberation_ttf
      powerline-fonts
      source-code-pro
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
    ];
  };

}
