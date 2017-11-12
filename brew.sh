#!/usr/bin/env bash

# from https://github.com/aziz/dotfiles/blob/master/bash/completion/brew.completion.bash

if which brew >/dev/null 2>&1; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

  if [ -f `brew --prefix`/Library/Contributions/brew_bash_completion.sh ]; then
    . `brew --prefix`/Library/Contributions/brew_bash_completion.sh
  fi
fi

echo "Install all AppStore Apps at first!"
# no solution to automate AppStore installs

echo "Install command line tools"
xcode-select --install

read -p "Press any key to continue... " -n1 -s
echo  '\n'

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don't forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion2

echo "Switching to using brew-installed bash as default shell"

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Wait a bit before moving on...
sleep 1

echo "Installing nvm and speedtest-cli with wget."

# Install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

# Install speedtest-cli
wget -O speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
chmod +x speedtest-cli

echo "Installing a bunch of other useful and necessary brew packages."

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen
brew install homebrew/php/php56 --with-gmp

echo "Installing font tools"
# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2
brew install fontforge
brew install optipng

echo "Installing some CTF tools"
# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

echo "Other useful binaries"
# Install other useful binaries.
brew install ack
#brew install exiv2
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install zopfli
brew install thefuck
brew install trash

# Install additional development stuff that can be useful
echo "Useful languages and tools."
brew install make
brew install python
brew install perl
brew install phantomjs
brew install rsync
brew install tree
brew install autojump

# Install video and image tools
echo "Installing useful video and images tools."
brew install youtube-dl
brew install ffmpeg
brew install graphicsmagick
brew install jpeg

# Install Node and Yarn
echo "Installing node and yarn packages"
brew install node
brew install yarn --without-node
brew install yo

# hold for a sec then install some global npm packages
sleep 1


echo "Installing cask"
# Install cask
brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions

echo "Installing Aerials screensaver."
# Install Aerial screensaver and other cask packages
brew cask install aerial

# Development
echo "Install Dev Apps"
brew cask install --appdir="/Applications" github
brew cask install --appdir="/Applications" visual-studio-code
brew cask install --appdir="/Applications" sublime-text
brew cask install --appdir="/Applications" cakebrew

# Google
echo "I <3 Google"
brew cask install --appdir="/Applications" chromecast
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" chrome-devtools
brew cask install --appdir="/Applications" google-drive
brew cask install --appdir="/Applications" google-music-manager
brew install caskroom/cask/google-photos-backup-and-sync

echo "Installing some nice to have apps if I need them"
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" spectacle
brew cask install --appdir="/Applications" cleanmymac
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" spotify
brew cask install --appdir="/Applications" the-unarchiver

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook qlvideo

# ...and then.
echo "Success! Additional Brew applications are installed."

# Wait a bit before moving on...
sleep 1

echo "Installing Mackup and backing up Application settings."

# Install Mackup
brew install mackup
# Launch it and back up your files
mackup backup

# Remove outdated versions from the cellar.
brew cleanup

echo "Cleanup outdated versions from Brew cellar."

# Sanity check
brew doctor
