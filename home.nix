{ config, pkgs, ... }:

let
  username = "shuvi";
  homeDirectory = "/home/${username}";
  dotfilesPath = "${homeDirectory}/.dotfiles";
  configsPath = "${dotfilesPath}/.config";
in
{
  imports = [
    ./nix/hyprland.nix
    ./nix/tmux.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
  
  home = {
    inherit username homeDirectory;
    stateVersion = "24.11";
  };

  # programs.kitty.enable = true; # required for the default Hyprland config
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   settings = {
  #   };
  # };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git

    neovim-unwrapped

    # Terminal
    ghostty
    fish
    direnv
    tmux
    starship

    # Env
    devenv

    # Some impure stuffs
    flatpak
    bun
    pnpm
    gnome-software

    # Apps
    google-chrome
    legcord
    discord

    # Language tools + LSP
    gcc
    zig
    lua-language-server
    nodenv
    nixd
    alejandra

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "Cascadia Code" ]; })
    cascadia-code

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  services.flatpak = {
    enableModule = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
    packages = [
      "flathub:app/app.zen_browser.zen//stable"
      # "flathub:app/org.kde.index//stable"
    ];
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.configFile = {
    "fish" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/fish";
      recursive = true;
    };
    "nix" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/nix";
      recursive = true;
    };
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/nvim";
      recursive = true;
    };
    "ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${configsPath}/ghostty";
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shuvi/etc/profile.d/hm-session-vars.sh

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
