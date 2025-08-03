git add 
monster-fly.sh#!/data/data/com.termux/files/usr/bin/bash 
git commit -m "remove token"
git push -f origin master# ====== 🔧 CONFIG SECTION ======
USERNAME="Maytu84"
REPO_NAME="kali-fly-1754182888"
APP_NAME="kali-fly-1754182888"
EMAIL="your@email.com"  # CHANGE THIS to your real email for Fly.io
# ==============================

# 🧼 Clean start
pkg update -y && pkg upgrade -y
pkg install -y curl git wget unzip

# 🛠 Install Fly.io CLI
curl -L https://fly.io/install.sh | sh
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# ♻️ Add flyctl to .bashrc for next time
grep -qxF 'export FLYCTL_INSTALL="$HOME/.fly"' ~/.bashrc || echo 'export FLYCTL_INSTALL="$HOME/.fly"' >> ~/.bashrc
grep -qxF 'export PATH="$FLYCTL_INSTALL/bin:$PATH"' ~/.bashrc || echo 'export PATH="$FLYCTL_INSTALL/bin:$PATH"' >> ~/.bashrc

# 🔐 Log in to Fly.io (interactive browser-based login)
echo -e "\n⚠️  When prompted, tap the link to log in via your browser"
flyctl auth login

# 📁 Go to project directory
cd ~/kali-fly || {
  echo "❌ Folder ~/kali-fly not found!"
  exit 1
}

# 🧠 Initialize Git
git init
git remote remove origin 2>/dev/null
git remote add origin https://$USERNAME:$TOKEN@github.com/$USERNAME/$REPO_NAME.git
git add .
git commit -m "Initial Kali Fly.io commit"

# 📤 Push to GitHub
git push -u origin master

# 🚀 Create Fly.io app (skip if already created)
flyctl apps create $APP_NAME || echo "⚠️ App may already exist."

# 🧬 Launch Fly.io with Dockerfile (or fly.toml if it exists)
if [ -f fly.toml ]; then
  flyctl deploy
else
  flyctl launch --name $APP_NAME --no-deploy --region ord --now
fi

echo -e "\n🎉 ALL DONE!"
echo "🔗 GitHub Repo: https://github.com/$USERNAME/$REPO_NAME"
echo "🔗 Fly.io Dashboard: https://fly.io/apps/$APP_NAME"
