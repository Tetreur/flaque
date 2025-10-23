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

# Set manpager to use `bat`
set -gx MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | 'bat' -p -lman'"
set -gx MANROFFOPT -c

# Colorize help messages
abbr -a --position anywhere -- --help '--help | 'bat' -plhelp'
abbr -a --position anywhere -- -h '-h | 'bat' -plhelp'

# Git prompt
set -g __fish_git_prompt_show_informative_status    1       # ahead, behing, deverged
set -g __fish_git_prompt_showdirtystate             1       # has uncommitted changes
set -g __fish_git_prompt_showuntrackedfiles         1       # Show untracked files
set -g __fish_git_prompt_showupstream               auto    # Summarize diff between HEAD & upstream
set -g __fish_git_prompt_showstashstate             1       # Stash status display
set -g __fish_git_prompt_showcolorhint              1


# prisma_engines
set -gx PRISMA_QUERY_ENGINE_LIBRARY "$HOME/Projects/prisma_engines/libquery_engine.so.node.gz"
set -gx PRISMA_SCHEMA_ENGINE_BINARY "$HOME/Projects/prisma_engines/schema-engine.gz"
set -gx PRISMA_QUERY_ENGINE_BINARY "$HOME/Projects/prisma_engines/query-engine.gz"
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if test -d "$PNPM_HOME"
    fish_add_path $PNPM_HOME
end
