{ ... }:
{
  programs.nixvim.plugins.no-neck-pain = {
    enable = true;
    settings = {
      autocmds = {
        enableOnVimEnter = true;
      };
      width = 120;
    };
  };
}
