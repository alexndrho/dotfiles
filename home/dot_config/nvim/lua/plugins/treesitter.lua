return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    commit = vim.fn.has 'nvim-0.12' == 0 and '7caec274fd19c12b55902a5b795100d21531391f' or nil,
    config = function()
      local parsers = {
        'query',
        'bash',
        'c',
        'diff',
        'python',

        'vim',
        'vimdoc',
        'lua',
        'luadoc',

        'markdown',
        'markdown_inline',

        'html',
        'css',
        'javascript',
        'jsdoc',
        'json',
        'jsx',
        'typescript',
        'tsx',
        'php',
        'phpdoc',
        'yaml',
      }
      require('nvim-treesitter').install(parsers)

      local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then return end

        vim.treesitter.start(buf, language)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end

      local available_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

          if vim.tbl_contains(installed_parsers, language) then
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available_parsers, language) then
            require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
          else
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          -- Prefer not to automatically jump to the nearest textobject.
          lookahead = false,
        },
        move = {
          set_jumps = true,
        },
      }

      -- select
      local select = require 'nvim-treesitter-textobjects.select'
      local function textobject(lhs, query, query_group, desc)
        vim.keymap.set({ 'x', 'o' }, lhs, function() select.select_textobject(query, query_group) end, { desc = desc })
      end

      textobject('as', '@local.scope', 'locals', 'Around scope')
      textobject('af', '@function.outer', 'textobjects', 'Around function')
      textobject('if', '@function.inner', 'textobjects', 'Inside function')
      textobject('ac', '@class.outer', 'textobjects', 'Around class')
      textobject('ic', '@class.inner', 'textobjects', 'Inside class')

      -- move
      local move = require 'nvim-treesitter-textobjects.move'
      local function movement(lhs, move_fn, query, query_group, desc)
        vim.keymap.set({ 'n', 'x', 'o' }, lhs, function() move_fn(query, query_group) end, { desc = desc })
      end

      movement(']s', move.goto_next_start, '@local.scope', 'locals', 'Jump to next scope start')
      movement(']S', move.goto_next_end, '@local.scope', 'locals', 'Jump to next scope end')
      movement('[s', move.goto_previous_start, '@local.scope', 'locals', 'Jump to previous scope start')
      movement('[S', move.goto_previous_end, '@local.scope', 'locals', 'Jump to previous scope end')

      movement(']f', move.goto_next_start, '@function.outer', 'textobjects', 'Jump to next function start')
      movement(']F', move.goto_next_end, '@function.outer', 'textobjects', 'Jump to next function end')
      movement('[f', move.goto_previous_start, '@function.outer', 'textobjects', 'Jump to previous function start')
      movement('[F', move.goto_previous_end, '@function.outer', 'textobjects', 'Jump to previous function end')

      movement(']c', move.goto_next_start, '@class.outer', 'textobjects', 'Jump to next class start')
      movement(']C', move.goto_next_end, '@class.outer', 'textobjects', 'Jump to next class end')
      movement('[c', move.goto_previous_start, '@class.outer', 'textobjects', 'Jump to previous class start')
      movement('[C', move.goto_previous_end, '@class.outer', 'textobjects', 'Jump to previous class end')
    end,
  },
}
