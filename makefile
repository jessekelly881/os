iso: os.nix
	nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=os.nix

default: iso
