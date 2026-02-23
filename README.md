# smchunn's dotfiles

Configuration for macOS. Managed by nix-darwin (system config) and homebrew (packages).

xcode cli tools:
`xcode-select --install`

nix install:
`sh <(curl -L https://nixos.org/nix/install)`

nix-darwin install:
`nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dev/nix#mini`

nix-darwin apply:
`darwin-rebuild switch --flake ~/dev/nix#mini`

## License

MIT / BSD
