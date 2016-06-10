function proc {
  ps wwwaux | egrep --color=always "($1|%CPU)" | grep -v grep
}

function fn {
  ls **/*$1*
}

function list-top-fsize {
  test -e ${1:-.} && ls -1RhsQ ${1:-.}/* \
    | sed -e "s/^ *//" \
    | grep "^[0-9]" \
    | sort -rh \
    | head -${2-10} \
    | sed 's/[^ ]*/\o033[36;1m\0\o033[0m/' \
    | xargs printf "%20s │ %s\n"
}

function srot-framebuffer {
  colorer 1 ; colorer 2
  colorer 3 ; colorer 4
  colorer 5 ; fbgrab -s 2 $HOME/framebuffer.png
}

function zsh-colors {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f";
  done
}

# function xvnc-serve {
#   $LOCAL_ETC/xorg/xvnc
#   $LOCAL_ETC/bspwm/bspwmrc
#   [[ -s $HOME/.fehbg ]] && $HOME/.fehbg
# }

function mkinitcpio-rebuild {
  sudo mkinitcpio -g /boot/initramfs-$(uname -r).img "$@"
}
compdef _mkinitcpio mkinitcpio-rebuild="mkinitcpio"

function lsinitcpio-latest {
  lsinitcpio /boot/initramfs-$(uname -r).img "$@"
}
compdef _mkinitcpio lsinitcpio-latest="lsinitcpio"

function lsinitcpio-analyze-latest {
  lsinitcpio-latest -a
}
compdef _mkinitcpio lsinitcpio-analyze-latest="lsinitcpio"

function ggpush {
  git push origin $(git-branch-current)
}

function gwip {
  git add -A
  git rm $(git ls-files --deleted) 2> /dev/null
  git commit -m "--wip--"
}

function gunwip {
  git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1
}