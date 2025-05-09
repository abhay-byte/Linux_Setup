Okay, here's a simplified `README.md` focusing on `curl`-based installation for each script, while retaining some of the visual appeal.

```markdown
<p align="center">
  <img src="https://raw.githubusercontent.com/saadeghi/saadeghi/master/static/linux.svg" alt="Linux Logo" width="120" />
</p>
<h1 align="center">🐧 Linux Setup Scripts 🐧</h1>

<p align="center">
  <em>Quickly set up your Linux environments using simple `curl` commands!</em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/saadeghi/saadeghi/master/static/typing.svg" alt="Typing SVG Animation" width="500" />
</p>

## 🚀 Overview

This repository provides shell scripts to automate the setup for:
*   Arch Linux with the Hyprland compositor.
*   XFCE desktop environment on Arch Linux within a Termux `proot-distro`.
*   Your base Termux environment on Android.

## 📜 Available Scripts & Installation via `curl`

**Important Notes Before You Start:**

1.  **Replace Placeholder:** In the `curl` commands below, replace `YOUR_USERNAME/YOUR_REPONAME` with the actual GitHub path to this repository (e.g., `yourgithubusername/linux-setup-scripts`).
2.  **Sudo Privileges:** Some scripts require `sudo` privileges and may prompt for your password.
3.  **Wallpapers:** The scripts attempt to copy wallpapers from a local `./Wallpaper/` directory.
    *   If using the `curl | bash` method, this step might be skipped or fail unless you `cd` into a directory where you've manually created a `Wallpaper` folder *before* running the command.
    *   Alternatively, clone the full repository if you want the bundled wallpapers to be copied automatically.
4.  **Review Scripts:** It's always a good practice to review scripts from the internet before executing them. You can view the script content by opening the URL in your browser.

---

### 1. 🖥️ `setup_arch.sh` - Arch Linux Hyprland Desktop

Sets up a modern Arch Linux desktop environment powered by the Hyprland Wayland compositor. Includes essential apps, `yay`, Oh My Zsh, and an optional Hyprland configuration from JaKooLit.

**To install and run (on a base Arch Linux system):**
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPONAME/main/setup_arch.sh)"
```
*(Ensure `git` is installed: `sudo pacman -Syu git --noconfirm` if it's a very minimal install)*

---

### 2. 📱 `setup_arch_prootdistro.sh` - Arch Linux (XFCE) in Termux

Automates setting up an Arch Linux desktop with XFCE *inside* a Termux `proot-distro` environment. Installs XFCE, essential apps, `yay`, and Oh My Zsh.

**To install and run (from *within* your Termux Arch Linux `proot-distro` shell):**
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPONAME/main/setup_arch_prootdistro.sh)"
```
*(Inside the proot-distro, ensure `curl` and `git` are installed first: `sudo pacman -Syu curl git --noconfirm`)*

---

### 3. 🚀 `setup_termux.sh` - Termux Enhancement Script

Enhances your base Termux environment with essential packages (including `proot-distro`, `x11-repo`), Oh My Zsh, and useful Zsh plugins.

**To install and run (directly in Termux):**
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPONAME/main/setup_termux.sh)"
```

---

## 🤝 Contributing

Found a bug or have a suggestion? Feel free to open an issue or submit a pull request!

## 📜 License

These scripts are provided in the spirit of open source. Use, modify, and share as you see fit!

---

<p align="center">Happy Scripting! ✨</p>
```

**To use this:**

1.  Replace `YOUR_USERNAME/YOUR_REPONAME` in the `curl` commands with the actual path to where these scripts will be hosted on GitHub (e.g., if your username is `coder123` and your repo is `my-setups`, it would be `coder123/my-setups`).
2.  Ensure the scripts are in the `main` branch (or adjust the branch name in the URL if different).