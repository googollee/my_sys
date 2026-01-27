return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function(lp, opts)
      require("codecompanion").setup({
        adapters = {
          my_gemini_cli = function()
            return {
              name = "my_gemini_cli",
              roles = {
                llm = true, -- 声明这是一个大模型适配器
              },
              features = {
                text = true,
                tokens = false,
              },
              -- 核心：重写 chat 函数，完全绕过 http/init.lua
              chat = function(self, payload, callback)
                -- 获取最后一条消息
                local last_message = payload.messages[#payload.messages].content
                
                -- 执行系统命令
                -- 使用 vim.fn.system 同步获取结果
                local cmd = string.format("echo %s | gemini", vim.fn.shellescape(last_message))
                local output = vim.fn.system(cmd)

                -- 手动调用回调函数，返回插件需要的格式
                callback({
                  status = "success",
                  output = output,
                })
              end,
              -- inline 策略也需要类似的逻辑
              inline = function(self, payload, callback)
                self.chat(self, payload, callback)
              end,
            }
          end,
        },
        strategies = {
          chat = { adapter = "my_gemini_cli" },
          inline = { adapter = "my_gemini_cli" },
        },
      })
    end,
  }
}
