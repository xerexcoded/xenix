if status is-interactive
# Commands to run in interactive sessions can go here
end

set fish_greeting ""

alias v "nvim"
alias ls "lsd"
alias cat "bat"





set PATH $HOME/.emacs.d/bin $PATH

  starship init fish | source
