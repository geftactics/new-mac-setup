#!/bin/bash

sudo -v

echo "Installing brew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended


echo "Installing powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


echo "Copying powerlevel10k config..."
[ -f ~/.p10k.zsh ] && cp ~/.p10k.zsh ~/.p10k.zsh.$(date +"%Y%m%d%H%M%S").bak
cp .p10k.zsh ~/.p10k.zsh
line='[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh'
grep -Fxq "$line" ~/.zshrc || echo "$line" >> ~/.zshrc
sed -i '' 's/^ZSH_THEME.*/ZSH_THEME=powerlevel10k\/powerlevel10k/g' ~/.zshrc
sed -i '' 's/^plugins=(.*/plugins=(git dotenv history-substring-search)/g' ~/.zshrc


echo "Sourcing zsh plugins..."
line='source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
grep -Fxq "$line" ~/.zshrc || echo "$line" >> ~/.zshrc


echo "Installing packages from Brewfile..."
brew bundle install --force


echo "Copying iTerm2 profile..."
[ -f ~/Library/Preferences/com.googlecode.iterm2.plist ] && cp ~/Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist.$(date +"%Y%m%d%H%M%S").bak
cp com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist


echo "Removing Dock items..."
remove_list=("Safari" "Mail" "Maps" "Photos" "FaceTime" "Messages" "Calendar" "Contacts" "Freeform" "TV" "Music" "News" "Keynote" "Numbers" "Pages")
for item in "${remove_list[@]}"
do
   dockutil -r "$item" --no-restart
done


echo "Adding Dock items..."
add_list=("/Applications/zoom.us.app" "/Applications/Visual Studio Code.app" "/Applications/iTerm.app" "/Applications/Slack.app" "/Applications/Microsoft Outlook.app" "/Applications/Google Chrome.app")
for item in "${add_list[@]}"
do
   dockutil -a "$item" -p 2 --no-restart
done
dockutil -a /Applications --view grid --display folder --sort name --before Downloads


echo "Default browser prompt..."
defaultbrowser chrome


echo "Launching iTerm2..."
open /Applications/iTerm.app


echo "Finished!"
echo "----------------------------------------------"
echo "     Please close this terminal window!"
echo "  You can now use iTerm for terminal access."
echo "----------------------------------------------"
