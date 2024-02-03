sudo apt update
sudo apt upgrade

ssh-keygen -t ed25519 -C "eumisdev@proton.me" -f ~/.ssh/github
ssh-add ~/.ssh/github

echo 'Host github.com' >> ~/.ssh/config
echo '    AddKeysToAgent yes' >> ~/.ssh/config
echo '    IdentityFile ~/.ssh/github' >> ~/.ssh/config

cat ~/.ssh/github.pub

echo 'eval "$(ssh-agent)"' >> ~/.bashrc
