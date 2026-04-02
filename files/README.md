# Configuration Files

## dev script
Quick launch script for tmux with nvim + AI assistant.

**Install:**
```bash
cp dev ~/.local/bin/dev
chmod +x ~/.local/bin/dev
```

**Usage:**
```bash
dev                           # Current dir, gh copilot
dev ~/projects/myapp          # Specific dir, gh copilot
dev --gemini                  # Current dir, gemini
dev --gemini ~/path           # Specific dir, gemini
```

**Keys:**
- `Ctrl-a g` - Toggle AI panel + auto-focus
- `Ctrl-a q` - Quick exit session
- `Ctrl-a d` - Detach session

## tmux.conf
Vim-friendly tmux configuration.

**Install:**
```bash
cp tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
```

**Features:**
- Prefix: `Ctrl-a` (not `Ctrl-b`)
- Vim navigation: `Ctrl-a h/j/k/l`
- Vim copy mode: `v` to select, `y` to copy
- Image passthrough enabled
- 75/25 split ratio
