return {
  "windwp/nvim-autopairs",
  lazy = true,
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")
    npairs.setup({
      map_cr = false,
      check_ts = true,
      ts_config = {
        lua = { "string" }, -- it will not add a pair on that treesitter node
        javascript = { "template_string" },
        java = false, -- don't check treesitter on java
      },
    })
    local ts_conds = require("nvim-autopairs.ts-conds")

    -- press % => %% only while inside a comment or string
    npairs.add_rules({
      Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
      Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
    })

    -- change default fast_wrap
    npairs.setup({
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', '"' },
        pattern = [=[[%"%"%>%]%)%}%,]]=],
        end_key = "$",
        before_key = "h",
        after_key = "l",
        cursor_pos_before = true,
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })

    function Rule2(a1, ins, a2, lang)
      npairs.add_rule(Rule(ins, ins, lang)
        :with_pair(function(opts)
          return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          return a1 .. ins .. ins .. a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
        end))
    end

    Rule2("(", "*", ")", "ocaml")
    Rule2("(*", " ", "*)", "ocaml")
    Rule2("(", " ", ")")
    Rule2("{", "*", "}")
    Rule2("{{", " ", "}}", "vue")
    Rule2("({", " ", "})", "vue")
    Rule2("{", " ", "}")
    --}}}
  end,
}
