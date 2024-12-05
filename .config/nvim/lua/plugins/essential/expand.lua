return {
    "Sam-programs/expand.nvim",
    dependencies = { 'Sam-Programs/indent.nvim' },
    -- event = 'InsertEnter',
    -- ft = {"python", "lua", "sh", "bash", "zsh", "c", "cpp"},
    keys = { { "<A-space>", mode={"i"}}, },
    config = function()
      local sh_rules = {
        { 'elif',  { ' ;then', '' },   { lua_pattern = true, endpair_new_line = false } },
        { 'if',    { ' ;then', 'fi' }, { lua_pattern = true } },
        { 'case',  { '', 'esac' },     { lua_pattern = true } },
        { 'while', { ' do', 'done' },  { lua_pattern = true } },
        { 'for',   { ' do', 'done' },  { lua_pattern = true } },
        { '',      { '{', '}' } },
      }
      local config = {
        filetypes = {
          python = {
            { '', { ':', '' }, { endpair_new_line = false } },
          },
          lua = {
            -- regex for a lua variable
            { '%s*%w*%s*[a-zA-z.]+%s*=%s*$', { '{', '}' },       { lua_pattern = true } },
            { 'if',                           { ' then', 'end' }, { lua_pattern = true } },
            -- if we are expanding on an unnamed function might as well add the pairs
            { 'function[^(]*$',               { '()', 'end' },    { lua_pattern = true, go_to_end = false } },
            { 'function',                     { '', 'end' },      { lua_pattern = true } },
            { 'loops',                        { ' do', 'end' },   { lua_pattern = true } },
          },
          sh = sh_rules,
          bash = sh_rules,
          zsh = sh_rules,
          c = {
            { '.*(.*)',            { '{', '}' },  { lua_pattern = false } },
            { 'else',              { '{', '}' },  { lua_pattern = true } },
            -- an empty line is likely in an array
            { '^%s*$',             { '{', '},' }, { lua_pattern = true } },
            { '^%s*\\.%w+%s*=%s*', { '{', '},' }, { lua_pattern = true } },
            { 'struct',            { '{', '};' } },
          },
          cpp = {
            { '.*(.*)',            { '{', '}' },  { lua_pattern = false } },
            { 'namespace',         { '{', '}' },  { lua_pattern = true } },
            { 'else',              { '{', '}' },  { lua_pattern = true } },
            -- an empty line is likely in an array
            { '^%s*$',             { '{', '},' }, { lua_pattern = true } },
            { '^%s*\\.%w+%s*=%s*', { '{', '},' }, { lua_pattern = true } },
            { 'class',             { '{', '};' }, },
          },
        },
        default_rule = 
        { '', { '{', '}' } },
        default_options = {
          lua_pattern = false
        },
        hotkey = '<A-space>',
      }
      require('expand').setup(config)
    end,
  } 
  
