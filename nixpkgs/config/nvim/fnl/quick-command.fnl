(global quick_command_set
        (fn []
          (set vim.g.quick-command (vim.fn.input "Command: "))))

(global quick_command_execute
        (fn []
          (-?> vim.g.quick-command
               ((fn [cmd]
                  (.. ":SlimeSend1 " cmd)))
               vim.fn.execute)))
