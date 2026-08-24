#!/usr/bin/env bash
set -oue pipefail

# negativo17 steam repo (same ecosystem as the base's fedora-multimedia repo)
curl --retry 3 --retry-delay 5 -Lo /etc/yum.repos.d/negativo17-fedora-steam.repo https://negativo17.org/repos/fedora-steam.repo

# 1Password official repo + signing key
rpm --import https://downloads.1password.com/linux/keys/1password.asc
cat > /etc/yum.repos.d/1password.repo <<'EOF'
[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.1password.com/linux/keys/1password.asc
EOF
# Brave official repo + signing key
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
cat > /etc/yum.repos.d/brave-browser.repo <<'EOF'
[brave-browser]
name=Brave Browser
enabled=1
gpgcheck=1
gpgkey=https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
baseurl=https://brave-browser-rpm-release.s3.brave.com/$basearch
EOF
