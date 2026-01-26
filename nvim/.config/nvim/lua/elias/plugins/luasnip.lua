return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Pre-made snippets for many languages
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local fmt = require("luasnip.extras.fmt").fmt

    -- Load friendly-snippets (VSCode-style snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    -- LuaSnip configuration
    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = false,  -- Disabled to prevent auto-triggering
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "●", "GruvboxOrange" } },
          },
        },
      },
    })

    -- React/JSX Snippets
    ls.add_snippets("javascriptreact", {
      -- React functional component
      s("rfc", fmt([[
        import React from 'react';

        export default function {}({}) {{
          return (
            <div>
              {}
            </div>
          );
        }}
      ]], {
        i(1, "ComponentName"),
        i(2, "props"),
        i(0)
      })),

      -- React functional component with arrow function
      s("rafce", fmt([[
        import React from 'react';

        const {} = ({}) => {{
          return (
            <div>
              {}
            </div>
          );
        }};

        export default {};
      ]], {
        i(1, "ComponentName"),
        i(2, "props"),
        i(0),
        f(function(args) return args[1][1] end, {1})
      })),

      -- useState hook
      s("us", fmt([[
        const [{}, set{}] = useState({});
      ]], {
        i(1, "state"),
        f(function(args)
          local state = args[1][1]
          return state:sub(1,1):upper() .. state:sub(2)
        end, {1}),
        i(2, "initialValue")
      })),

      -- useEffect hook
      s("ue", fmt([[
        useEffect(() => {{
          {}
        }}, [{}]);
      ]], {
        i(1, "// effect"),
        i(2)
      })),

      -- useContext hook
      s("uc", fmt([[
        const {} = useContext({});
      ]], {
        i(1, "context"),
        i(2, "ContextName")
      })),

      -- useRef hook
      s("ur", fmt([[
        const {} = useRef({});
      ]], {
        i(1, "ref"),
        i(2, "null")
      })),

      -- useMemo hook
      s("um", fmt([[
        const {} = useMemo(() => {}, [{}]);
      ]], {
        i(1, "memoizedValue"),
        i(2, "// computation"),
        i(3)
      })),

      -- useCallback hook
      s("ucb", fmt([[
        const {} = useCallback(() => {{
          {}
        }}, [{}]);
      ]], {
        i(1, "callback"),
        i(2, "// callback body"),
        i(3)
      })),

      -- Import React
      s("imr", t("import React from 'react';")),

      -- Import useState
      s("imus", t("import { useState } from 'react';")),

      -- Import useEffect
      s("imue", t("import { useEffect } from 'react';")),

      -- Props destructuring
      s("props", fmt([[
        const {{ {} }} = props;
      ]], {
        i(1, "prop1, prop2")
      })),
    })

    -- TypeScript React Snippets
    ls.add_snippets("typescriptreact", {
      -- React functional component with TypeScript
      s("rfc", fmt([[
        import React from 'react';

        interface {}Props {{
          {}
        }}

        export default function {}({{ {} }}: {}Props) {{
          return (
            <div>
              {}
            </div>
          );
        }}
      ]], {
        i(1, "Component"),
        i(2, "// props"),
        f(function(args) return args[1][1] end, {1}),
        i(3, "props"),
        f(function(args) return args[1][1] end, {1}),
        i(0)
      })),

      -- React functional component with arrow function and TypeScript
      s("rafce", fmt([[
        import React from 'react';

        interface {}Props {{
          {}
        }}

        const {}: React.FC<{}Props> = ({{ {} }}) => {{
          return (
            <div>
              {}
            </div>
          );
        }};

        export default {};
      ]], {
        i(1, "Component"),
        i(2, "// props"),
        f(function(args) return args[1][1] end, {1}),
        f(function(args) return args[1][1] end, {1}),
        i(3, "props"),
        i(0),
        f(function(args) return args[1][1] end, {1})
      })),

      -- useState with TypeScript
      s("us", fmt([[
        const [{}, set{}] = useState<{}>({});
      ]], {
        i(1, "state"),
        f(function(args)
          local state = args[1][1]
          return state:sub(1,1):upper() .. state:sub(2)
        end, {1}),
        i(2, "type"),
        i(3, "initialValue")
      })),

      -- useEffect
      s("ue", fmt([[
        useEffect(() => {{
          {}
        }}, [{}]);
      ]], {
        i(1, "// effect"),
        i(2)
      })),

      -- Interface
      s("int", fmt([[
        interface {} {{
          {}
        }}
      ]], {
        i(1, "InterfaceName"),
        i(0)
      })),

      -- Type
      s("type", fmt([[
        type {} = {{
          {}
        }};
      ]], {
        i(1, "TypeName"),
        i(0)
      })),
    })

    -- JavaScript/TypeScript common snippets
    local js_snippets = {
      -- Console log
      s("cl", fmt([[
        console.log({});
      ]], { i(1) })),

      -- Console log with message
      s("clm", fmt([[
        console.log('{}:', {});
      ]], { i(1, "message"), i(2, "value") })),

      -- Arrow function
      s("af", fmt([[
        const {} = ({}) => {{
          {}
        }};
      ]], {
        i(1, "functionName"),
        i(2, "params"),
        i(0)
      })),

      -- Async arrow function
      s("aaf", fmt([[
        const {} = async ({}) => {{
          {}
        }};
      ]], {
        i(1, "functionName"),
        i(2, "params"),
        i(0)
      })),

      -- Try-catch
      s("tc", fmt([[
        try {{
          {}
        }} catch (error) {{
          console.error(error);
          {}
        }}
      ]], {
        i(1, "// try block"),
        i(0)
      })),

      -- Promise
      s("prom", fmt([[
        new Promise((resolve, reject) => {{
          {}
        }});
      ]], { i(0) })),

      -- Async/await
      s("aw", fmt([[
        const {} = await {};
      ]], {
        i(1, "result"),
        i(2, "promise")
      })),

      -- Import statement
      s("imp", fmt([[
        import {} from '{}';
      ]], {
        i(1, "module"),
        i(2, "path")
      })),

      -- Import destructured
      s("imd", fmt([[
        import {{ {} }} from '{}';
      ]], {
        i(1, "module"),
        i(2, "path")
      })),

      -- Export default
      s("exp", fmt([[
        export default {};
      ]], { i(1) })),

      -- Export named
      s("exn", fmt([[
        export {{ {} }};
      ]], { i(1) })),
    }

    ls.add_snippets("javascript", js_snippets)
    ls.add_snippets("typescript", js_snippets)
    ls.add_snippets("javascriptreact", js_snippets)
    ls.add_snippets("typescriptreact", js_snippets)

    -- Keymaps for snippet navigation
    vim.keymap.set({"i", "s"}, "<C-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { desc = "LuaSnip: Next choice" })

    vim.keymap.set({"i", "s"}, "<C-h>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, { desc = "LuaSnip: Previous choice" })
  end,
}
