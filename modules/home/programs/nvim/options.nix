{ ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };

    opts = {
      number = true;
    };
  };
}
