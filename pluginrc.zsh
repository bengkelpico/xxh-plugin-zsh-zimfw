CURR_DIR="$(cd "$(dirname "$0")" && pwd)"
plugin_name='xxh-plugin-zsh-zimfw'
path=("$HOME/.local/bin" "$HOME/.bin" "$HOME/.config/composer/vendor/bin" "$HOME/.yarn/bin" "$path[@]")

export PATH
export ZIM_HOME="$CURR_DIR/zimfw"

if [ ! -x "$(command -v git)" ]; then
  zstyle ':zim:zmodule' use 'degit'
fi

if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

export ZDOTDIR="$CURR_DIR"

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
  echo "Please run `update_for all` to complete setup"
fi

source ${ZIM_HOME}/init.zsh
