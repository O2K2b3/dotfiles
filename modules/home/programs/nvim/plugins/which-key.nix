{ ... }:
{
  programs.nixvim.plugins.which-key = {
    enable = true;
    
    settings = {
      preset = "helix";
      
      spec = [
        {
          __unkeyed-1 = {
            mode = [ "n" "x" ];
            __unkeyed-1 = { __unkeyed-1 = "<leader><tab>"; group = "tabs"; };
            __unkeyed-2 = { __unkeyed-1 = "<leader>c"; group = "code"; };
            __unkeyed-3 = { __unkeyed-1 = "<leader>d"; group = "debug"; };
            __unkeyed-4 = { __unkeyed-1 = "<leader>dp"; group = "profiler"; };
            __unkeyed-5 = { __unkeyed-1 = "<leader>f"; group = "file/find"; };
            __unkeyed-6 = { __unkeyed-1 = "<leader>g"; group = "git"; };
            __unkeyed-7 = { __unkeyed-1 = "<leader>gh"; group = "hunks"; };
            __unkeyed-8 = { __unkeyed-1 = "<leader>q"; group = "quit/session"; };
            __unkeyed-9 = { __unkeyed-1 = "<leader>s"; group = "search"; };
            __unkeyed-10 = { __unkeyed-1 = "<leader>u"; group = "ui"; };
            __unkeyed-11 = { __unkeyed-1 = "<leader>x"; group = "diagnostics/quickfix"; };
            __unkeyed-12 = { __unkeyed-1 = "["; group = "prev"; };
            __unkeyed-13 = { __unkeyed-1 = "]"; group = "next"; };
            __unkeyed-14 = { __unkeyed-1 = "g"; group = "goto"; };
            __unkeyed-15 = { __unkeyed-1 = "gs"; group = "surround"; };
            __unkeyed-16 = { __unkeyed-1 = "z"; group = "fold"; };
            __unkeyed-17 = {
              __unkeyed-1 = "<leader>b";
              group = "buffer";
              expand.__raw = ''
                function()
                  return require("which-key.extras").expand.buf()
                end
              '';
            };
            __unkeyed-18 = {
              __unkeyed-1 = "<leader>w";
              group = "windows";
              proxy = "<c-w>";
              expand.__raw = ''
                function()
                  return require("which-key.extras").expand.win()
                end
              '';
            };
            __unkeyed-19 = { __unkeyed-1 = "gx"; desc = "Open with system app"; };
          };
        }
      ];
    };
  };

  programs.nixvim.keymaps = [
    # Buffer Keymaps (which-key)
    {
      mode = "n";
      key = "<leader>?";
      action = "<cmd>lua require('which-key').show({ global = false })<cr>";
      options = {
        desc = "Buffer Keymaps (which-key)";
        silent = true;
      };
    }
    
    # Window Hydra Mode (which-key)
    {
      mode = "n";
      key = "<c-w><space>";
      action = "<cmd>lua require('which-key').show({ keys = '<c-w>', loop = true })<cr>";
      options = {
        desc = "Window Hydra Mode (which-key)";
        silent = true;
      };
    }
  ];

  # Additional Lua configuration for which-key setup
  programs.nixvim.extraConfigLua = ''
    -- which-key additional setup
    local wk = require("which-key")
    -- The setup is already done by nixvim, but we can add custom logic here if needed
  '';
}