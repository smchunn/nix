status is-interactive || return
# Commands to run in interactive sessions can go here
set fish_greeting

set -x VAULT "$HOME/Documents/vault/"

function ls
  command eza $argv
end

function la
  command eza -la $argv
end

function ll
  command eza -l $argv
end

function lg
  command eza -l --git $argv
end

function cfg
  command nvim -c "cd $HOME/dev/nix"
function tvim
  command nvim -c "cd $HOME/Development/nix" -u "$HOME/.config/nvim/test/init.lua"
end

function dev
  command cd "$HOME/Development/"
end

function on
  command nvim -c "cd $VAULT" -c "autocmd User DashboardLoaded ObsidianNew $argv[1]"
end

function oo
  command nvim -c "cd $VAULT" -c "autocmd User DashboardLoaded ObsidianQuickSwitch"
end

pyenv init - | source

if not test -f ~/.zshrc
    command touch ~/.zshrc
end
set fish_path (string join ":" $PATH)
if grep -q "export PATH=" ~/.zshrc
    sed -i '' "s|export PATH=.*|export PATH=\"$fish_path\"|" ~/.zshrc
else
    echo "export PATH=\"$fish_path\"" >> ~/.zshrc
end
