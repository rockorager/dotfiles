# Old habits
abbr vi nvim
abbr vim nvim

# ls shortcuts
abbr ls lsr
abbr ll 'lsr --almost-all --long'
abbr lt 'lsr --tree'

# prompt colors
set -g hydro_color_prompt magenta
set -g hydro_color_pwd blue
set -g hydro_color_git yellow
set -g hydro_color_duration white
set -g hydro_symbol_prompt " "

# disable greeting
set fish_greeting

set fish_pager_color_progress brblack '--background=cyan'

# add 1password completions
op completion fish | source

# activate mise
mise activate fish | source
