(module Lang.CodeRunner
  {autoload {code-runner code_runner}})
(code-runner.setup
  {:mode :toggle
   :project
    {"~/.local/src/sandbox/haskell"
      {:name "Haskell Cabal Project"
       :description "Prooject using Cabal"
       :command "cabal run"}}
   :filetype
    {:haskell "cd $dir && ghc $fileName && ./$fileNameWithoutExt"
     :rust "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
     :python "python3 -u"
     :apl "dyalog -script DYALOG_LINEEDITOR_MODE=1"
     :cpp "cd $dir && c++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt"
     :c "cd $dir && cc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt"}})
