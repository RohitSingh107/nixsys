# Reference https://nixos.wiki/wiki/Laptop
{pkgs, ...}: {
  services.thermald.enable = false; # Works only on intel cpu

  powerManagement = {
    enable = true;
    powertop.enable = true; # This can make your input devices such as the keyboard unresponsive for some time
  };

  # services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = false; # conflicts with services.power-profiles-daemon.enable = true (provided by gnome)
    # settings = {
    #   CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #   CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    #
    #   CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    #   CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    #
    #   CPU_MIN_PERF_ON_AC = 0;
    #   CPU_MAX_PERF_ON_AC = 100;
    #   CPU_MIN_PERF_ON_BAT = 0;
    #   CPU_MAX_PERF_ON_BAT = 20;
    #
    #   #Optional helps save long term battery health
    #   START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
    #   STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    # };
  };
}
