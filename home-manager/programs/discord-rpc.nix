{pkgs, ...}: let
  # Create a Discord application at https://discord.com/developers/applications
  # Name it whatever you want (e.g. "Steam Games"), then paste the Application ID here.
  clientId = "YOUR_DISCORD_APP_CLIENT_ID";

  pythonEnv = pkgs.python3.withPackages (ps: [ps.pypresence]);

  script = pkgs.writeText "game-rpc.py" ''
    import os
    import time
    import sys
    from pypresence import Presence, InvalidID, PipeClosed

    CLIENT_ID = "${clientId}"

    # process comm name (first 15 chars of binary name) → display name
    GAMES = {
        "stellaris":      "Stellaris",
        "Civ6":           "Civilization VI",
        "defcon.bin.x86": "DEFCON",
    }

    def running_comms():
        comms = set()
        for pid in os.listdir("/proc"):
            if not pid.isdigit():
                continue
            try:
                with open(f"/proc/{pid}/comm") as f:
                    comms.add(f.read().strip())
            except OSError:
                pass
        return comms

    def make_rpc():
        rpc = Presence(CLIENT_ID)
        rpc.connect()
        return rpc

    rpc = None
    current = None

    while True:
        comms = running_comms()
        detected = next(
            (name for proc, name in GAMES.items() if proc in comms),
            None
        )

        if detected != current:
            if rpc:
                try:
                    rpc.clear()
                    rpc.close()
                except Exception:
                    pass
                rpc = None

            current = detected

            if detected:
                try:
                    rpc = make_rpc()
                    rpc.update(details=detected, start=int(time.time()))
                    print(f"[game-rpc] Now playing: {detected}", flush=True)
                except Exception as e:
                    print(f"[game-rpc] Error: {e}", flush=True)
                    rpc = None
            else:
                print("[game-rpc] No game detected", flush=True)

        time.sleep(10)
  '';

  gameRpc = pkgs.writeShellScriptBin "game-rpc" ''
    exec ${pythonEnv}/bin/python3 ${script}
  '';
in {
  home.packages = [gameRpc];

  systemd.user.services.game-rpc = {
    Unit = {
      Description = "Discord game presence monitor";
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${gameRpc}/bin/game-rpc";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
