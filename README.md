# Nvim + Me

"Nvim + Me" is my nvim config that I use in my system. I originally make this config based on [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch) and [Ultimate Neovim Setup Guide](https://dev.to/slydragonn/ultimate-neovim-setup-guide-lazynvim-plugin-manager-23b7) but I've changed a lot of them to meet my needs. I use nvim 0.10.1 downloaded from official github repo and I will change the config to work with the latest stable release of nvim, so if you want to use my config, ensure you're using the latest stable version of nvim.

## Tryout

If you want to take a fresh start, first remove or rename the old neovim files:

```
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

Then clone the repo in your neovim config path:

```
git clone https://github.com/LunarVim/Neovim-from-scratch.git ~/.config/nvim
```

## System Packages

These system packages are needed for using this config:

- Showing fortunes on startup screen (Alpha):

```
sudo apt install fortune-mod
```

- Supports for system-wide clipboard on wayland:

```
sudo apt install wl-clipboard
```

- packages needed for Telescope (Optional):

```
sudo apt install ripgrep fd-find
```

- Neovim node support:

```
npm i -g neovim
```
