# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config
, lib
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "sg" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.nat.externalInterface = "wlp170s0";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/18694165-78d3-4b43-8866-17026ed0ffa4";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/18694165-78d3-4b43-8866-17026ed0ffa4";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/18694165-78d3-4b43-8866-17026ed0ffa4";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/12CE-A600";
    fsType = "vfat";
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/18694165-78d3-4b43-8866-17026ed0ffa4";
    options = [ "subvol=swap" "noatime" "nodatacow" "nospace_cache" ];
    fsType = "btrfs";
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
