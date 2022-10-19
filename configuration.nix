# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		  ./hardware-configuration.nix
		  #./vim.nix
		];

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

	networking.hostName = "nixos"; # Define your hostname.
	#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Europe/Berlin";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.utf8";

	i18n.extraLocaleSettings = 
	{
		LC_ADDRESS = "de_DE.utf8";
		LC_IDENTIFICATION = "de_DE.utf8";
		LC_MEASUREMENT = "de_DE.utf8";
		LC_MONETARY = "de_DE.utf8";
		LC_NAME = "de_DE.utf8";
		LC_NUMERIC = "de_DE.utf8";
		LC_PAPER = "de_DE.utf8";
		LC_TELEPHONE = "de_DE.utf8";
		LC_TIME = "de_DE.utf8";
	};

	# Configure console keymap
	console.keyMap = "de";

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.user = 
	{
		isNormalUser = true;
		description = "user";
		#add user to audiogroup for pulseaudio support:
		extraGroups = [ "networkmanager" "wheel"];
		packages = with pkgs; [];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		#WINDOW MANAGER:
			i3blocks
			
		#PROGRAMMING:
			#python:
				python3 #python 3.9
				python39Packages.ipython
				python39Packages.pip

			ghc #Glasgow Haskell Compiler

			cmake
			gnumake
			gcc

		#LaTeX:
			texlive.combined.scheme-full

		#VERSION CONTROL:
			git 

		#EDITORS:
			#vim_configurable

		#TERMINAL EMULATORS:
			alacritty

		#SHELL UTILITIES:
			wget 
			acpi
			udevil
			upower
			htop
			unzip
		
		#DYNAMIC MENUS:
			rofi
			dmenu

		#FILE MANAGER:
			vifm
		
		#PDF READER:
			zathura
		
		#SYSTEM MANAGEMENT:
			gparted

		#INTERNET:
			networkmanager	

		#BROWSER:
			firefox
			#tor-browser-bundle-bin
			chromium
		
		#MAIL:
			thunderbird
			element-desktop

		#SECURITY:
			keepassxc
			gnupg

		#AUDIO:
			alsa-utils
			pavucontrol
			lsof

		#BLUETOOTH:
			bluez

		#FUN:
			freetube
	];


	#Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	services.upower.enable = true;

	############# X SERVER ###############
	services.xserver.enable = true;
	services.xserver.libinput.enable = true; #enable touchpad
	services.xserver.windowManager.i3.package = pkgs.i3-gaps; #use i3 as i3-gaps
	services.xserver.windowManager.i3.enable = true; #use i3wm
	services.xserver.displayManager.lightdm.enable = true; #use lightdm
	services.xserver.autorun = true; #autostart xserver when booting

	######################################


	############## SOUND #################
	
	xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
	xdg.portal.enable = true;
	security.rtkit.enable = true;
	services.pipewire =
	{
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
		jack.enable = true;
	};
	#hardware.pulseaudio.enable = true;
	#hardware.pulseaudio.support32Bit = true;
	
	######################################

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
	system.stateVersion = "22.05"; # Did you read the comment?

}
