
{ pkgs, lib, ... }: {

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;




    settings = {
      sudo = {
        disabled = false;
      };
      git_status = {
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        deleted = "x";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        style = "white";
      };
      username = {

        format = " [╭─$user]($style)@";
        show_always = true;
        style_root = "bold red";
        style_user = "bold red";
      };

      hostname = {

        disabled = false;
        format = "[$hostname]($style) in ";
        ssh_only = false;
        style = "bold dimmed red";
        trim_at = "-";
      };

      directory = {
        style = "purple";
        truncate_to_repo = true;
        truncation_length = 0;
        truncation_symbol = "repo: ";
      };

      cmd_duration = {
        disabled = false;
        format = "took [$duration]($style)";
        min_time = 1;
      };

      time = {
        disabled = true;
        format = " 🕙 $time($style)\n";
        style = "bright-white";
        time_format = "%T";
      };

      character = {
        error_symbol = " [×](bold red)";
        success_symbol = " [╰─λ](bold red)";
      };

      status = {
        disabled = false;
        format = "[ \[ $symbol$status_common_meaning$status_signal_name$status_maybe_int \] ] ($style)";
        map_symbol = true;
        pipestatus = true;
        symbol = "🔴";
      };

      python.symbol = " ";
      nix_shell.symbol = " ";


      # battery = {
      #   charging_symbol = "";
      #   disabled = true;
      #   discharging_symbol = "";
      #   full_symbol = "";
      #
      #   display = {
      #     disabled = false;
      #     style = "bold red";
      #     threshold = 15;
      #   };
      #   display = {
      #     disabled = true;
      #     style = "bold yellow";
      #     threshold = 50;
      #   };
      #   display = {
      #     disabled = true;
      #     style = "bold green";
      #     threshold = 80;
      #   };
      # };



    };
  };

}
