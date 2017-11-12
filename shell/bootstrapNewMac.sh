#!/usr/bin/env bash

# This bootstraps installing ssh-keys to github

# set colors
if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    ORANGE="$(tput setaf 172)"
  else
    ORANGE="$(tput setaf 4)"
  fi
  RESET="$(tput sgr0)"
else
  ORANGE="\033[1;33m"
  RESET="\033[m"
fi


function notice() {
  echo "${ORANGE}[ notice ] : ${1}${RESET}"
}

script="${HOME}/bootstrap.sh"

cat >"$script" <<EOL
#\$usr/bin/env bash

# set colors
if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ \$(tput colors) -ge 256 ]] 2>/dev/null; then
    ORANGE="\$(tput setaf 172)"
  else
    ORANGE="\$(tput setaf 4)"
  fi
  RESET="\$(tput sgr0)"
else
  ORANGE="\033[1;33m"
  RESET="\033[m"
fi

function notice() { echo "\${ORANGE}[ notice ] : \${1}\${RESET}" ; }

function checkForGit() {
  notice "Confirming we have developer tools..."

  if ! xcode-select --print-path &> /dev/null; then

    xcode-select --install &> /dev/null

    until xcode-select --print-path &> /dev/null; do
      sleep 5
    done

    notice 'XCode Command Line Tools Installed'

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    notice 'Making xcode-select developer directory point to Xcode'

    sudo xcodebuild -license
    notice 'Agree with the XCode Command Line Tools licence'

  else
    notice "Command Line Tools installed"
  fi
}
checkForGit

function seek_confirmation() {
  notice "\$@"
  while true; do
    read -p " (y/n) " yn
    case \$yn in
      [Yy]* ) return 0 ;;
      [Nn]* ) return 1 ;;
      * ) input "Please answer yes or no." ;;
    esac
  done
}

function createKey() {
  notice "Checking for SSH key in ~/.ssh/id_rsa.pub, generating one if it doesn't exist"
  if ! [ -f "\${HOME}/.ssh/id_rsa.pub" ]; then
    ssh-keygen -t rsa
  fi

  notice "Copying public key to clipboard..."
  if [ -f "\${HOME}/.ssh/id_rsa.pub" ]; then
    pbcopy < "\${HOME}/.ssh/id_rsa.pub"
  fi
}
createKey

function testKey() {
  ready=false
  while [ "\$ready" != true ]; do
    if seek_confirmation "Ready to paste SSH key to Github?"; then
      ready=true
      open https://github.com/account/ssh
    fi
  done

  ready=false
  while [ "\$ready" != true ]; do
    if seek_confirmation "Ready to test they key?"; then ready=true; fi
  done


  notice "Confirming the SSH key works..."
  ready=false
  while [ "\$ready" != true ]; do
    ssh -T git@github.com
    # ssh returns a status of '1' when the command works and a status
    # of '255' when it doesn't. So, we check for a status of less then 2
    if [ \$? -lt 2 ]; then
      ready=true
      notice "Congrats. You can now SSH to Github"
    else
      if seek_confirmation "\$?: Key didn't work. Test again?"; then
        continue
      else
        notice "can't continue without github working. Exiting."
        exit 1
      fi
    fi
  done
}
testKey

function cloneRepo() {
  notice "Cloning dotfiles repo..."
  cd "\$HOME"
  if ! git clone git@github.com:natelandau/dotfiles.git; then
    notice "Uh oh. Seems we had problems..."
    notice "Try running this script again once resolved"
    exit 1
  else
    notice "Repo successfully cloned"
    notice "Please run '~/dotfiles/install.sh' to bootstrap your computer"
  fi
}
cloneRepo

exit 0

EOL

chmod a+x "$script"

notice "SUCCESS! '$script' created."
notice "To bootstrap your new computer follow these steps"
notice "1. Run '$script' to clone the dotfiles repo"
notice "2. Delete '$script'. Once it's run you no longer need it."
notice "3. Run the 'install.sh' to bootstrap your computer"
notice "Have fun..."
exit 0
