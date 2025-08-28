if status is-interactive
    # Commands to run in interactive sessions can go here
    bunbun
end

abbr --add c 'clear && bunbun'
abbr --add n 'nvim'
abbr --add l 'ls'
abbr --add b 'bun'
abbr --add p 'pwd'
abbr --add h 'history'
abbr --add z 'zeditor'
abbr --add  p 'pragma'

alias cat 'bat'

set -gx PRISMA_QUERY_ENGINE_LIBRARY "$HOME/Projects/prisma_engines/libquery_engine.so.node.gz"
set -gx PRISMA_SCHEMA_ENGINE_BINARY "$HOME/Projects/prisma_engines/schema-engine.gz"
set -gx PRISMA_QUERY_ENGINE_BINARY "$HOME/Projects/prisma_engines/query-engine.gz"
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if test -d "$PNPM_HOME"
    fish_add_path $PNPM_HOME
end
