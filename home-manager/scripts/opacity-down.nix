{pkgs}:
pkgs.writeShellApplication {
  name = "opacity-down";
  runtimeInputs = [ pkgs.hyprland pkgs.jq pkgs.bc ];
  text = ''
    current=$(hyprctl activewindow -j | jq '.opacity')
    new=$(echo "$current - 0.1" | bc)
    new=$(echo "if ($new < 0.1) 0.1 else $new" | bc)
    hyprctl setprop address "$(hyprctl activewindow -j | jq -r '.address')" alpha "$new"
  '';
}
