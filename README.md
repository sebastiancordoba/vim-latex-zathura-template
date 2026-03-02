# LaTeX Math Template (Vimtex + Zathura + LuaSnip)

This repository is a fully configured, out-of-the-box template for writing gorgeous LaTeX documents incredibly fast, specifically designed for Neovim on macOS.

It features:
- **Vimtex**: Best-in-class LaTeX compiling and viewer integration.
- **Zathura**: A lightweight, Vim-like PDF viewer, configured with inverse search (SyncTeX).
- **LuaSnip & Autosnippets**: Gilles Castel's famous, lightning-fast math snippets.
- **SeniorMars' Typography**: A beautiful template with custom theorem boxes, fonts, and dark mode support.

## Prerequisites

1. **Neovim** (`brew install neovim`)
2. **MacTeX** (`brew install --cask mactex-no-gui` or just `basictex` + `latexmk`)
3. **Zathura** & the **mupdf plugin**:
   ```bash
   brew tap zegervdv/zathura
   brew install zathura --with-synctex
   brew install zathura-pdf-mupdf
   ```
   *(Note: Because of local macOS linking, you might just need `brew install zathura zathura-pdf-mupdf` and `mkdir -p $(brew --prefix)/lib/zathura && ln -s $(brew --prefix zathura-pdf-mupdf)/libpdf-mupdf.dylib $(brew --prefix)/lib/zathura/libpdf-mupdf.dylib` depending on your Homebrew setup).*

4. **nvr (Neovim Remote)** for Inverse Search (clicking PDF -> jumps to Neovim):
   ```bash
   pip3 install neovim-remote
   ```

## Setup Instructions

1. **Copy the Configuration**
   Move the contents of the `.config` folder in this repository to your user's `~/.config` folder:
   ```bash
   cp -r .config/nvim ~/.config/
   cp -r .config/zathura ~/.config/
   ```

2. **Start Editing**
   Open the included `main.tex` template with Neovim:
   ```bash
   nvim main.tex
   ```
   *The first time you launch Neovim, it will automatically download the Lazy plugin manager and install Vimtex and LuaSnip.*

## Daily Workflow & Shortcuts

### Compiling and Viewing (Vimtex)
- `<space>ll` : **Compile** the document. It compiles in the background and continuously watches for changes.
- `<space>lv` : **View** the PDF in Zathura.
- `<space>lc` : **Clean** the auxiliary build files (clears the `build/` directory).

### SyncTeX
- **Forward Search (Neovim \(\rightarrow\) PDF)**: Type `\ls` inside Neovim while over a line. Zathura will highlight the corresponding line.
- **Inverse Search (PDF \(\rightarrow\) Neovim)**: Hold `Cmd` and `Left-Click` on a word in Zathura. Neovim will jump exactly to that line of code. *(Make sure Neovim is running with `nvr` or within a terminal that supports nested RPC if needed, though `nvr` handles this via the `zathurarc` config).*

### Writing Math Fast (LuaSnip Autosnippets)
Autosnippets expand *instantly* without needing to press Tab. Here are the most essential ones from the Gilles Castel port (`luasnip-latex-snippets`):

| Type this | Gets you this | Description |
|---|---|---|
| `mk` | `$ ... $` | Inline math |
| `dm` | `\[ ... \]` | Display math block |
| `//` | `\frac{...}{...}` | Fraction |
| `==` | `&= ... \\` | Align equals |
| `!=` | `\neq` | Not equals |
| `<=` | `\le` | Less than or equal |
| `>=` | `\ge` | Greater than or equal |
| `sr` | `^2` | Squared |
| `cb` | `^3` | Cubed |
| `td` | `^{...}` | Superscript (to the... power) |
| `rd` | `^{...}` | Same as td |
| `__` | `_{...}` | Subscript |
| `=>` | `\implies` | Implies arrow |
| `=<` | `\impliedby` | Implied by arrow |
| `iff` | `\iff` | If and only if |
| `sq` | `\sqrt{...}` | Square root |

> **Pro Tip**: Use `<Tab>` to jump to the next `{...}` placeholder inside a snippet, and `<Shift-Tab>` to jump backwards!

## Directory Structure
- `preamble.tex`: Margins, packages, colors, and beautiful theorem environments (`\thm`, `\dfn`, `\ex`, etc.).
- `macros.tex`: Math macros (e.g., `\abs{}`, `\norm{}`).
- `letterfonts.tex`: Math alphabet setups for calligraphic text.
- `.latexmkrc`: Tells `latexmk` to build the PDF into a `build/` folder to keep your root directory extremely clean.
