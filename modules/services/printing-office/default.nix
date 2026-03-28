{ ... }: {
  flake.modules.nixos.printing-office = { ... }: {
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
