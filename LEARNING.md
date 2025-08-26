# Learning

In this file, I'm gonna list useful commands and keybinds I stumble across
throughout my NeoVim journey. Useful for looking up fancy commands or
simply refreshing what I have learned.

# Keybinds
- `~` toggles upper- and lowercase and moves one forward (can also be used in visual mode)

## Marks
- `ma` set a buffer-local mark labeled `a` at current position
- `mA` set a global mark labeled `A` at current position
- `'a` go to mark labeled `a`

## Diff
- `]c` jump to next diff
- `[d` jump to previous diff

# Commands

- `vnew` opens an empty buffer on the left
- `vsplit` opens the current buffer again to the right

## Diff
- `vert diffsplit <file>` opens diff with file to the left
- `diffthis` adds current buffer to diff comparizon
- `diffoff` deactivates diff
