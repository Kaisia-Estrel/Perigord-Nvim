(local hydra (require :hydra))
(local {: cmd} (require :hydra.keymap-util))

(hydra {:name :Buffer
        :mode :n
        :config {:invoke_on_body true}
        :body :<leader>b
        :heads [[:j (cmd :BufferLineCyclePrev) {:desc "Previous Buffer"}]
                [:k (cmd :BufferLineCycleNext) {:desc "Next Buffer"}]
                [:h (cmd :BufferLineMovePrev) {:desc "Move Buffer Left"}]
                [:l (cmd :BufferLineMoveNext) {:desc "Move Buffer Right"}]
                [:x (cmd "bdelete! %") {:desc "Close Buffer"}]]})

(vim.keymap.set :n :<A-h> (cmd :BufferLineCyclePrev)
                {:noremap true :silent true :desc "Previous Buffer"})
(vim.keymap.set :n :<A-l> (cmd :BufferLineCycleNext)
                {:noremap true :silent true :desc "Next Buffer"})
(vim.keymap.set :n :<A-H> (cmd :BufferLineMovePrev)
                {:noremap true :silent true :desc "Move Buffer Left"})
(vim.keymap.set :n :<A-L> (cmd :BufferLineMoveNext)
                {:noremap true :silent true :desc "Move Buffer Right"})
(vim.keymap.set :n :<A-1> (cmd "BufferLineGoToBuffer 1")
                {:noremap true :silent true :desc "Move to Buffer 1"})
(vim.keymap.set :n :<A-2> (cmd "BufferLineGoToBuffer 2")
                {:noremap true :silent true :desc "Move to Buffer 2"})
(vim.keymap.set :n :<A-3> (cmd "BufferLineGoToBuffer 3")
                {:noremap true :silent true :desc "Move to Buffer 3"})
(vim.keymap.set :n :<A-4> (cmd "BufferLineGoToBuffer 4")
                {:noremap true :silent true :desc "Move to Buffer 4"})
(vim.keymap.set :n :<A-5> (cmd "BufferLineGoToBuffer 5")
                {:noremap true :silent true :desc "Move to Buffer 5"})
(vim.keymap.set :n :<A-6> (cmd "BufferLineGoToBuffer 6")
                {:noremap true :silent true :desc "Move to Buffer 6"})
(vim.keymap.set :n :<A-7> (cmd "BufferLineGoToBuffer 7")
                {:noremap true :silent true :desc "Move to Buffer 7"})
(vim.keymap.set :n :<A-8> (cmd "BufferLineGoToBuffer 8")
                {:noremap true :silent true :desc "Move to Buffer 8"})
(vim.keymap.set :n :<A-9> (cmd "BufferLineGoToBuffer 9")
                {:noremap true :silent true :desc "Move to Buffer 9"})
(vim.keymap.set :n :<A-0> (cmd "BufferLineGoToBuffer 0")
                {:noremap true :silent true :desc "Move to Buffer 0"})
(vim.keymap.set :n :<A-p> (cmd :BufferLineTogglePin)
                {:noremap true :silent true :desc "Pin Buffer"})
(vim.keymap.set :n :<A-x> (cmd "bdelete! %")
                {:noremap true :silent true :desc "Close Buffer"})
