{pkgs, ...}: {

  programs.thunderbird = {
    enable = true;
    profiles = {
      "Rohit Singh" = {
        isDefault = true;
      };
      "rohithack" = {
        isDefault= false;
      };
    };
  };

  # programs.neomutt = {
  #   enable = true;
  # };

  accounts.email.accounts = {
    "Rohit Sigh" = {

      realName = "Rohit Singh";
      address = "rohitsingh.mait@gmail.com";
      primary = true;
      flavor = "gmail.com";

      passwordCommand = "secret-tool lookup password gmail";

      neomutt = {
        enable = true;
      };

      thunderbird = {
        enable = true;
      };

      imapnotify = {
        enable = true;
        boxes = [ "Inbox" ];
      };

    };

    "rohithack" = {


      realName = "Rohit Singh";
      address = "rohithack@outlook.com";

      userName = "rohithack@outlook.com";

      imap = {
        host = "imap-mail.outlook.com";
        port = 993;
      };

      smtp = {
        host = "smtp-mail.outlook.com";
        port = 587;
        tls = {
          enable = true;
        };
      };
      passwordCommand = "${pkgs.libsecret}/bin/secret-tool lookup password rohithack";
      thunderbird = {
        enable = true;
      };
    };
  };
}
