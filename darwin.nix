# darwin.nix
{
  config,
  pkgs,
  self,
  user,
  host,
  platform,
  ...
}: {
  # nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.hostPlatform = platform;

  nix.settings.experimental-features = "nix-command flakes";

  system.stateVersion = 5;
  system.configurationRevision = self.rev or self.dirtyRev or null;

  programs.fish.enable = true;
  environment.shells = [pkgs.fish];
  environment.pathsToLink = ["/share"];

  users.users.smchunn = {
    name = user;
    home = "/Users/${user}";
    shell = pkgs.fish;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    fish
    stow
    fd
    fzf
    tmux
    htop
    btop
    curl
    git
    alejandra
    zathura
    docker
    docker-compose
    qemu
    spice-gtk
  ];
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    onActivation.cleanup = "zap";

    taps = [
      "koekeishiya/formulae"
      "smchunn/tap"
    ];
    brews = [
      "koekeishiya/formulae/yabai"
      "koekeishiya/formulae/skhd"
      "neovim"
      "pyenv"
      "lazygit"
      "eza"
      "gh"
      "ripgrep"
      "nodejs"
      "rustup"
      "prettierd"
      "black"
      "colima"
      "postgresql"
      "cmake"
      "wget"
      "ninja"
      "aria2"
      "fontconfig"
    ];
    casks = [
      "firefox"
      "alfred"
      "1password"
      "1password-cli"
      "obsidian"
      "steermouse"
      "microsoft-outlook"
      "microsoft-excel"
      "microsoft-word"
      "microsoft-teams"
      "jump"
      "jump-desktop-connect"
      "dropbox"
      "betterdisplay"
      "prismlauncher"
      "cloudmounter"
      "kicad"
      "element"
      "basictex"
      "cleanshot"
      "chatgpt"
      "prusaslicer"
      "karabiner-elements"
      "google-chrome"
      "claude"
      "kitty"
      "smchunn/tap/font-iosevka-sc"
    ];
    # masApps = {
    #   "1Password for Safari" = 1569813296;
    #   "Things 3" = 904280696;
    #   "WireGuard" = 1451685025;
    # };
  };

  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 34;
      expose-animation-duration = 0.15;
      show-recents = false;
      persistent-apps = [
        "/System/Applications/Apps.app/"
        "/System/Cryptexes/App/System/Applications/Safari.app"
        "/System/Applications/System Settings.app/"
        "/System/Applications/App Store.app/"
        "/System/Applications/Mail.app/"
        "/Applications/Microsoft Outlook.app"
        "/Applications/Microsoft Excel.app"
        "/Applications/Microsoft Word.app"
        "/System/Applications/Preview.app/"
        "/Applications/Obsidian.app"
        "/Applications/kitty.app"
        "/Applications/ChatGPT.app"
        "/Applications/Claude.app"
        "/Applications/1password.app"
      ];
    };
    NSGlobalDomain = {
      NSNavPanelExpandedStateForSaveMode = true;
      PMPrintingExpandedStateForPrint = true;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      InitialKeyRepeat = 20;
      KeyRepeat = 1;
      NSAutomaticSpellingCorrectionEnabled = false;
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
      "com.apple.springing.enabled" = true;
      "com.apple.springing.delay" = 0.1;
    };
    trackpad = {
      FirstClickThreshold = 0;
      ActuationStrength = 0;
    };
    finder = {
      NewWindowTarget = "Home";
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = false;
      FXDefaultSearchScope = "SCcf";
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
      # QLEnableTextSelection = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
    };
    screencapture = {
      location = "~/Downloads";
      type = "png";
      disable-shadow = true;
    };
    # universalaccess.reduceTransparency = true;
  };
}
