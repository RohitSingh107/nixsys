{ pkgs, ... }: {


  # programs.thunderbird = {
  #   enable = true;
  #   profiles = {
  #     "Rohit Sigh" = {
  #       isDefault = true;
  #       name = "Rohit Sigh Gmail";
  #     };
  #   };
  # };
  # programs.neomutt = {
  #   enable = true;
  # };
  accounts.email.accounts = {
    "Rohit Sigh" = {
      address = "rohitsingh.mait@gmail.com";
      # address = "RohitSinghEmail@protonmail.com";
      # aliases = [
      #   "rohitsingh.mait@gmail.com"
      # ];
      primary = true;
      flavor = "gmail.com";
      name = "Rohit Singh Gmail";
      neomutt = {
        enable = true;
      };
      thunderbird = {
        enable = true;
      };
    };


  };


}
