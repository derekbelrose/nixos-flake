{ pkgs }:

pkgs.writeScriptBin "build-host" ''
#!${pkgs.stdenv.shell}

if [ -e $HOME/nix-config ]; then
  all_cores=$(nproc)
  build_cores=$(printf "%.0f" $(echo "$all_cores * 0.75" | bc))
  echo "Building NixOS with $build_cores cores"
  nh os switch --ask ~/nix-config/ -- --cores $build_cores
else
  ${pkgs.coreutils-full}/bin/echo "ERROR! No nix-config found in $HOME/nix-config"
fi
''
