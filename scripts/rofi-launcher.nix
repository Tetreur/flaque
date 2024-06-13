{pkgs}:
pkgs.writeShellScriptBin "rofi-launcher" ''
  if pgrep -x "rofi" > /dev/null; then
  	# Rofi is running, KILL IT
  	pkill -x rofi
  	exit 0
  fi
  rofi -show drun
''
