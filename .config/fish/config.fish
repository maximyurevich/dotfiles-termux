set -U fish_greeting ""

fish_vi_key_bindings

set -Ux VISUAL vim
set -Ux PYDEVD_WARN_SLOW_RESOLVE_TIMEOUT 0
set -Ux PYTHONWARNINGS ignore
set -Ux GOPATH $HOME/go/bin
set -Ux TMUX_FZF_OPTIONS "-p -w 60% -h 50% -m"
set -Ux PAGER "less -R"
set -Ux YAMLFIX_EXPLICIT_START false

fish_add_path $HOME/.local/share/nvim/mason/bin
set sponge_successful_exit_codes 0 127
set sponge_allow_previously_successful false
