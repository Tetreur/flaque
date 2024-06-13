{
  config,
  lib,
  pkgs,
  host,
  ...
}: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;

    shellAliases = {
      c = "clear";
      n = "nvim";
      sn = "sudo nvim";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#default";
    };

    initExtra = ''
      # ZINIT_HOME="$HOME/.local/share/zinit/zinit.git";

      # Download Zinit, if it's not there yet
      # if
      #	[ ! -d "$ZINIT_HOM" ]; then
      #	mkdir -p "$(dirname $ZINIT_HOME)"
      #	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      # fi

      # Source/Load zinit
      # source "$ZINIT_HOME/zinit.zsh"
    '';
  };
}
