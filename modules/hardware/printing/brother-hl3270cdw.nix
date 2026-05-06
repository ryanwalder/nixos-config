{inputs, ...}: {
  flake.modules.nixos.hardware_brother-hl3270cdw = {...}: {
    imports = with inputs.self.modules.nixos; [
      program_cups
    ];

    hardware.printers.ensurePrinters = [
      {
        name = "Brother_HL-L3270CDW";
        location = "office";
        deviceUri = "ipp://192.168.1.249/ipp";
        model = "everywhere";
        ppdOptions.pageSize = "A4";
      }
    ];
  };
}
