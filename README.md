
![Linux Logo](https://raw.githubusercontent.com/saadeghi/saadeghi/master/static/linux.svg)

# 🐧 Linux Setup Scripts 🐧

*Quickly set up your Linux environments using simple `curl` commands!*

![Typing SVG Animation](https://raw.githubusercontent.com/saadeghi/saadeghi/master/static/typing.svg)

## 🚀 Overview

This repository provides shell scripts to automate the setup for:
- Arch Linux with the Hyprland compositor.
- XFCE desktop environment on Arch Linux within a Termux `proot-distro`.
- Your base Termux environment on Android.

## 📜 Available Scripts & Installation via `curl`

**Important Notes Before You Start:**

1. **Sudo Privileges:** Some scripts require `sudo` privileges and may prompt for your password.
2. **Wallpapers:** The scripts attempt to copy wallpapers from a local `./Wallpaper/` directory.
   - If using the `curl | bash` method, this step might be skipped or fail unless you `cd` into a directory where you've manually created a `Wallpaper` folder *before* running the command.
   - Alternatively, clone the full repository (`git clone https://github.com/abhay-byte/Linux_Setup.git`) if you want the bundled wallpapers to be copied automatically.
3. **Review Scripts:** It's always a good practice to review scripts from the internet before executing them. You can view the script content by opening the URL in your browser.

---

### 1. 🖥️ `setup_arch.sh` - Arch Linux Hyprland Desktop

Sets up a modern Arch Linux desktop environment powered by the Hyprland Wayland compositor. Includes essential apps, `yay`, Oh My Zsh, and an optional Hyprland configuration from JaKooLit.

**To install and run (on a base Arch Linux system):**

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/abhay-byte/Linux_Setup/main/setup_arch.sh)"
```

*(Ensure `git` is installed: `sudo pacman -Syu git --noconfirm` if it's a very minimal install)*

---

### 2. 📱 `setup_arch_prootdistro.sh` - Arch Linux (XFCE) in Termux

Automates setting up an Arch Linux desktop with XFCE *inside* a Termux `proot-distro` environment. Installs XFCE, essential apps, `yay`, and Oh My Zsh.

**To install and run (from *within* your Termux Arch Linux `proot-distro` shell):**

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/abhay-byte/Linux_Setup/main/setup_arch_prootdistro.sh)"
```

*(Inside the proot-distro, ensure `curl` and `git` are installed first: `sudo pacman -Syu curl git --noconfirm`)*

---

### 3. 🚀 `setup_termux.sh` - Termux Enhancement Script

Enhances your base Termux environment with essential packages (including `proot-distro`, `x11-repo`), Oh My Zsh, and useful Zsh plugins.

**To install and run (directly in Termux):**

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/abhay-byte/Linux_Setup/main/setup_termux.sh)"
```

---

## 🤝 Contributing

Found a bug or have a suggestion? Feel free to open an issue or submit a pull request to [https://github.com/abhay-byte/Linux_Setup](https://github.com/abhay-byte/Linux_Setup)!

## 📜 License

These scripts are provided in the spirit of open source. Use, modify, and share as you see fit!

---

**Happy Scripting! ✨**
