{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Neovim editor
    neovim

    # Neovim dependencies
    gcc              # C compiler for treesitter parsers
    tree-sitter      # Treesitter CLI for parser management
    ripgrep          # Fast search tool (rg)
    imagemagick      # Image format conversion
    ghostscript      # PDF rendering
  ];
}
