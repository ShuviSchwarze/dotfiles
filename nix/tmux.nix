{ pkgs, ... }:
let
  # tmux-yank = pkgs.tmuxPlugins.mkTmuxPlugin {
  #   pluginName = "tmux-yank";
  #   version = "2.3.0";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "tmux-plugins";
  #     repo = "tmux-yank";
  #     rev = "acfd36e4fcba99f8310a7dfb432111c242fe7392";
  #     sha256 = "";
  #   };
  # };
  catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "2.1.2";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "2c4cb5a07a3e133ce6d5382db1ab541a0216ddc7";
      hash = "sha256-vBYBvZrMGLpMU059a+Z4SEekWdQD0GrDqBQyqfkEHPg=";
    };
    postInstall = ''
      sed -i -e 's|''${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme|''${TMUX_TMPDIR}/catppuccin-selected-theme.tmuxtheme|g' $target/catppuccin.tmux
    '';
  };
in {
  programs.tmux = {
    enable = true;
    historyLimit = 1024;
    keyMode = "vi";
    # address vim mode switching delay
    # https://superuser.com/a/252717/65504
    escapeTime = 0;
    plugins = with pkgs;
      [
        # {
          # plugin = catppuccin;
          # extraConfig = ''
          # '';
        # }
      ];
    extraConfig = ''
      # set-option -g /home/shuvi/.nix-profile/bin/fish
      set-option -sa terminal-override ",xterm*:Tc"
      set -g mouse on
      
      # Allows Copy Paste over Mosh ssh session
      set -g set-clipboard on
      set-option -ag terminal-overrides ",xterm-256color:Ms=\\E]52;c;%p2%s\\7"
      
      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on
      
      # Set prefix
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix
      
      # Shift + Alt [H or L] to switch windows
      bind -n M-H previous-window
      bind -n M-L previous-window
      
      # set vi-mode
      set-window-option -g mode-keys vi
      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      set -gq @catppuccin_flavour 'mocha'
      set -ogq @catppuccin_window_status_style 'slanted'

      set -g @catppuccin_window_left_separator "█"
      set -g @catppuccin_window_right_separator "█"
      set -g @catppuccin_window_number_position "left"
      set -g @catppuccin_window_middle_separator "█ "

      set -g @catppuccin_status_modules_right "host date_time"
      set -g @catppuccin_status_left_separator  ""
      set -g @catppuccin_status_right_separator " "
      set -g @catppuccin_status_right_separator_inverse "yes"
      set -g @catppuccin_status_fill "all"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_date_time_text "%H:%M:%S"

      # ~/.tmux.conf
      # set -agF status-right "#[fg=#{@thm_crust},bg=#{@thm_teal}] ##H "

      run-shell ${pkgs.tmuxPlugins.catppuccin }/share/tmux-plugins/catppuccin/catppuccin.tmux
      
      # run '~/.config/tmux/plugins/tpm/tpm'
    '';
  };
}


