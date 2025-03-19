# home.nix
{
  config,
  pkgs,
  user,
  host,
  ...
}: {
  # Define your user
  home.username = user;
  home.homeDirectory = "/Users/${user}";

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    bat
  ];

  home.file = {
    # "." = {
    #   source = ./dots;
    #   target = "~";
    #   recursive = true;
    # };

    # ".gitignore".text = ''
    #   *.log
    #   *.bak
    # '';
  };
}
