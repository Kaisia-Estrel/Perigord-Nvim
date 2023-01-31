![image](https://user-images.githubusercontent.com/90542764/213342938-2b62f300-eb58-42e9-9249-3328b8e2ec26.png)

<!--toc:start-->

- [Dependencies](#dependencies)
  - [Required](#required)
  - [Optional](#optional)
    - [Haskell](#haskell)
    - [Rust](#rust)
    - [C++](#c)
    - [Fennel](#fennel)
    - [Lua](#lua)
    - [Nix](#nix)
    - [Python](#python)
    - [Markdown](#markdown)
    - [Shell](#shell)
    - [Misc](#misc)
- [Keymap](#keymap)
  - [Normal](#normal)
- [Modules](#modules)
<!--toc:end-->

## Dependencies

### Required

- Neovim >=0.8
- [npm](https://www.npmjs.com/)
- [fennel](https://fennel-lang.org/)
- [git](https://git-scm.com/)
- [gcc](https://gcc.gnu.org/)

### Optional

#### General usage
- [huggingface-hub](https://huggingface.co/welcome) (_store token in 'secrets.json' as "huggingface-token"_)
- [fontconfig](https://www.freedesktop.org/wiki/Software/fontconfig/)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [wakatime](https://wakatime.com)
- [btop](https://github.com/aristocratos/btop)

#### Haskell

- [haskell-language-server](https://github.com/haskell/haskell-language-server)
- [brittany](https://hackage.haskell.org/package/brittany)
- [cabal-fmt](https://hackage.haskell.org/package/cabal-fmt)

#### Rust

- [rust-analyzer](https://rust-analyzer.github.io/)
- [clippy](https://github.com/rust-lang/rust-clippy)
- [nextest](https://github.com/nextest-rs/nextest)
- [evcxr](https://github.com/google/evcxr)

#### C++

- [cmake-format](https://github.com/cheshirekow/cmake_format)
- [cppcheck](https://cppcheck.sourceforge.io/)
- [ccls](https://github.com/MaskRay/ccls)

#### Fennel

- [fennel-ls](https://sr.ht/~xerool/fennel-ls/)
- [fnlfmt](https://git.sr.ht/~technomancy/fnlfmt)

#### Lua

- [sumneko_lua](https://github.com/sumneko/lua-language-server/wiki)
- [stylua](https://github.com/johnnymorganz/stylua)

#### Nix

- [nixfmt](https://hackage.haskell.org/package/nixfmt)
- [statix](https://github.com/nerdypepper/statix)
- [deadnix](https://github.com/astro/deadnix)
- [nil](https://github.com/oxalica/nil)

#### Python

- [pylint](https://pylint.pycqa.org/en/latest/)
- [black](https://github.com/psf/black)
- [pytest](https://docs.pytest.org/en/7.2.x/)

#### Markdown

- [marksman](https://github.com/artempyanykh/marksman) - Markdown language server
- [prettier](https://prettier.io/) - Markdown Formatter

#### Shell

- [shellcheck](https://hackage.haskell.org/package/ShellCheck)
- [beautysh](https://github.com/lovesegfault/beautysh)

#### Misc

- [cspell](https://github.com/streetsidesoftware/cspell) - Spellchecker
- [jq](https://github.com/stedolan/jq) - Json processor

## Keymap

### Normal

| Key | Desc             |
| --- | ---------------- |
| s   | Motion Forward   |
| S   | Motion Backwards |

## Modules

- Utils
