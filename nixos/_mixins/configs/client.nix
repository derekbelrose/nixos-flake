{ lib
, hostname
, pkgs
, ...
}: 
let 
	isInstall =
		if (builtins.substring 0 4 hostname != "iso-")
		then true
		else false;
in
{
  services.flatpak = lib.mkIf (isInstall) {
	enable = true;
  };

  systemd.services = {
     configure-flathub-repo = lib.mkIf (isInstall) {
       wantedBy = ["multi-user.target"];
       after = [ "network-online.target" ];
       wants = [ "network-online.target" ];
       path = [ pkgs.flatpak ];
       script = ''
         sleep 10 && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
       '';
     };
  };
} 
