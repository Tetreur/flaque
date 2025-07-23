{
  inputs,
  pkgs,
  ...
}:
{
  programs.fish = {
    loginShellInit = true;
  };

  /*
  * .
  * ├── completions
  * ├── conf.d
  * │   └── myabbrs.fish
  * ├── config.fish
  * ├── fish_variables
  * └── functions
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

  # PromptS
  home.file.".config/fish/functions/fish_prompt.fish" = {
    source = ./fish_prompt.fish;
    enable = true;
  };
}
