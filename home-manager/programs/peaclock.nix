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
      timer-exec 'notify-send -a peaclock "time is up!"'
    '';
  };
}
