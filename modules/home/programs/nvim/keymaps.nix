{ ... }:
{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      action = "<cmd>Oil<cr>";
      options.desc = "Open Oil file explorer";
    }
  ];
}
