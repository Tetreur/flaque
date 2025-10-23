{...}: {
  programs.fish = {
    loginShellInit = true;
  };

  /*
    * .
    * ├── completions
    * ├── conf.d
    * │   ├── myabbrs.fish
    * │   └── fnm.fish
    * ├── config.fish
    * ├── fish_variables
    * └── functions
    *     ├── cat.fish
    *     └── fish_prompt.fish
  */

  # Main config.fish
  home.file.".config/fish/config.fish" = {
    source = ./config.fish;
    enable = true;
  };

  # Custom abbrevations
  home.file.".config/fish/conf.d/myabbrs.fish" = {
    source = ./myabbrs.fish;
    enable = true;
  };

  # Prompt
  home.file.".config/fish/functions/fish_prompt.fish" = {
    source = ./fish_prompt.fish;
    enable = true;
  };
}
