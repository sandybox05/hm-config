{
  config,
  lib,
  pkgs,
  ...
}:
let
  theme = (import ./theme);
in
rec {
  programs.home-manager.enable = true;
  home.username = "sandybox";
  home.homeDirectory = "/home/sandybox";

  imports = [
    ./apps/ghostty
    ./apps/helix
    ./apps/zed
    ./apps/hyprland
    ./apps/hyprlock
    ./apps/hypridle
    ./apps/waybar
    ./apps/keybase
    ./apps/podman
    ./apps/vscode
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.local/share/pnpm"
  ];

  home.shellAliases = {
    helix = "hx";
  };

  home.sessionVariables = {
    GTK_IM_MODULE = lib.mkForce "";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    ELECTRON_ENABLE_WAYLAND = 0;
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    dex
    file
    jq
    nfs-utils
    pdfgrep
    poppler-utils
    unzip
    ffmpeg

    discord
    evince
    nautilus
    glib
    seahorse
    google-chrome
    pavucontrol
    _1password-gui
    insomnia
    jetbrains.datagrip
    slack

    cargo-make
    cbc
    glpk
    julia_110-bin
    keybase
    quarto
    R
    rustup
    typst
    gh
    uv
    pkg-config
    devpod
    devpod-desktop
    mise
    terraform
    libsecret # for secret-tool

    nixd
    nixfmt-rfc-style # for nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.volantes-cursors;
    name = "volantes_cursors";
    size = 24;
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "Noto Sans Mono CJK JP" ];
    defaultFonts.sansSerif = [ "Noto Sans CJK JP" ];
    defaultFonts.serif = [ "Noto Serif CJK JP" ];
  };

  gtk = {
    enable = true;
    font.name = theme.font.console;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Dark";
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-nord-dark";
    };
    cursorTheme = {
      package = pkgs.volantes-cursors;
      name = "volantes_cursors";
    };
    gtk2.extraConfig = ''
      gtk-im-module = fcitx
    '';
    gtk3.extraConfig.gtk-im-module = "fcitx";
    gtk4.extraConfig.gtk-im-module = "fcitx";
  };

  editorconfig = {
    enable = true;
    settings."*" = {
      charset = "utf-8";
      trim_trailing_whitespace = true;
      indent_style = "space";
      indent_size = 4;
      insert_final_newline = true;
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "sandybox";
      user.email = "sandybox05@gmail.com";
      core = {
        editor = "hx";
        quotepath = false;
      };
      commit.gpgsign = true;
      github.user = "sandybox";
      init.defaultBranch = "main";
      merge.ff = false;
      push.default = "simple";
      pull.rebase = true;
      credential.helper = "cache --timeout=3600";
    };
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
    settings.stripLeadingSymbols = false;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.nushell.enable = true;

  programs.starship.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      # obs-webkitgtk
      advanced-scene-switcher
    ];
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${home.homeDirectory}/Desktop";
    documents = "${home.homeDirectory}/Documents";
    download = "${home.homeDirectory}/Downloads";
    music = "${home.homeDirectory}/Music";
    pictures = "${home.homeDirectory}/Pictures";
    publicShare = "${home.homeDirectory}/Public";
    templates = "${home.homeDirectory}/Templates";
    videos = "${home.homeDirectory}/Videos";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "text/mml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
    };
  };

  xdg.autostart = {
    enable = true;
    entries = [
      "${pkgs.networkmanagerapplet}/share/applications/nm-applet.desktop"
    ];
  };

  home.stateVersion = "25.05";
}
