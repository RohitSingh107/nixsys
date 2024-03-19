{ pkgs, ...}: {

    programs.tmux = {
    enable = true;
    extraConfig = "
        
	# Set Fish as default shell
	set -g default-command fish

	# switch panes using Alt-arrow without prefix
	bind -n M-Left select-pane -L
	bind -n M-Right select-pane -R
	bind -n M-Up select-pane -U
	bind -n M-Down select-pane -D


	# Enable mouse control (clickable windows, panes, resizable panes)
	set -g mouse on


	#  modes
	setw -g clock-mode-colour colour5
	setw -g mode-style 'fg=colour1 bg=colour18 bold'

	# panes
	set -g pane-border-style 'fg=colour19 bg=colour0'
	set -g pane-active-border-style 'bg=colour0 fg=colour9'

	# statusbar
	set -g status-position bottom
	set -g status-justify left
	# set -g status-style 'bg=colour18 fg=colour137 dim'
	set -g status-left ''
	# set -g status-right '#[fg=colour233,bg=colour19] %d/%m #[fg=colour233,bg=colour8] %H:%M:%S '
	set -g status-right-length 50
	set -g status-left-length 20

    ";
  };

}
