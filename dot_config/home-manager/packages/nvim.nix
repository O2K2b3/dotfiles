{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Neovim editor (config is managed by chezmoi under ~/.config/nvim)
    neovim

    # Neovim dependencies
    gcc              # C compiler for treesitter parsers
    tree-sitter      # Treesitter CLI for parser management
    ripgrep          # Fast search tool (rg)
    imagemagick      # Image format conversion
    ghostscript      # PDF rendering
  ];
}
