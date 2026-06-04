{ ... }:
{
  xdg.configFile."peaclock/config" = {
    force = true;
    text = ''
      mode clock
      view digital
      set seconds on
      set hour-24 on
      set date on
      set auto-size off
      block 4 5
      padding 0 0
      margin 0 0
      date-padding 1
      style active-fg 51
      style inactive-fg 240
      style colon-fg 51
      style date 51
      timer-exec 'notify-send -a peaclock "⏰ Timer Finished" "Your peaclock timer is up!" && ffmpeg -f lavfi -i "sine=f=523:d=0.1,sine=f=659:d=0.1,sine=f=784:d=0.25" -ac 1 -f wav - | paplay'
    '';
  };
}
