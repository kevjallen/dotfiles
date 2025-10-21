########################
# Oh My Zsh! config
########################
export ZSH="${HOME}/.oh-my-zsh"

# ----- aliases -----
alias docker="podman"
alias lg="lazygit"
alias vim="nvim"

# ----- style -----
ZSH_THEME="agnoster"
DEFAULT_USER="kevin"

# ----- plugins -----
plugins=(asdf brew fzf git podman ssh-agent)

source "${ZSH}/oh-my-zsh.sh"

# ----- fzf -----
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers {}'"

# ----- golang -----
export GOPATH="${HOME}/Workspace/go"
