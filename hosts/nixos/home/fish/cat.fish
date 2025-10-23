function cat --wraps=/run/current-system/sw/bin/bat --description 'alias cat=($which bat)'
    /run/current-system/sw/bin/bat $argv
end
