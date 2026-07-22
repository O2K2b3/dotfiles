{ ... }:
{
  programs.nixvim.plugins.flash = {
    enable = true;
    
    settings = {
      # Flash configuration options
      modes = {
        search = {
          enabled = true;
        };
        char = {
          enabled = true;
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    # Flash jump
    {
      mode = [ "n" "x" "o" ];
      key = "s";
      action = "<cmd>lua require('flash').jump()<cr>";
      options = {
        desc = "Flash";
        silent = true;
      };
    }
    
    # Flash Treesitter
    {
      mode = [ "n" "o" "x" ];
      key = "S";
      action = "<cmd>lua require('flash').treesitter()<cr>";
      options = {
        desc = "Flash Treesitter";
        silent = true;
      };
    }
    
    # Remote Flash
    {
      mode = "o";
      key = "r";
      action = "<cmd>lua require('flash').remote()<cr>";
      options = {
        desc = "Remote Flash";
        silent = true;
      };
    }
    
    # Treesitter Search
    {
      mode = [ "o" "x" ];
      key = "R";
      action = "<cmd>lua require('flash').treesitter_search()<cr>";
      options = {
        desc = "Treesitter Search";
        silent = true;
      };
    }
    
    # Toggle Flash Search
    {
      mode = "c";
      key = "<c-s>";
      action = "<cmd>lua require('flash').toggle()<cr>";
      options = {
        desc = "Toggle Flash Search";
        silent = true;
      };
    }
    
    # Treesitter Incremental Selection
    {
      mode = [ "n" "o" "x" ];
      key = "<c-space>";
      action = "<cmd>lua require('flash').treesitter({ actions = { ['<c-space>'] = 'next', ['<BS>'] = 'prev' } })<cr>";
      options = {
        desc = "Treesitter Incremental Selection";
        silent = true;
      };
    }
  ];
}