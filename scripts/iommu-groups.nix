{pkgs}:
pkgs.writeShellScriptBin "iommu-groups" ''
  for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
  	echo "IOMMU"
  	echo "IOMMU Group ''${g##*x/}:"
  	for d in $g/devices/*; do
  		echo -e "\t$(lspci -nns ''${d##*/})"
  	done;
  done;
''
