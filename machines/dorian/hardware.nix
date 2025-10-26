{ 
  config, 
  lib, 
  pkgs, 
  modulesPath, 
  ... 
}:
{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "nct6775" ];
  boot.extraModulePackages = [ ];
  
 # boot.kernelPatches = [
 #   {
 #     name = "NCT6775 driver";
 #     patch = null; # no patch needed if zen-kernel is enabled
 #     structuredExtraConfig = with lib.kernel; {
 #       I2C_NCT6775 = lib.mkForce yes;
 #     };
 #   }
 # ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f77bcd1e-8763-45c0-a9bb-dc755b0ea54e";
    fsType = "ext4";
  };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-uuid/CCC5-6FB1";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
