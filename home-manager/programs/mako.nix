{ ... }:
{
  services.mako = {
    enable = true;
    anchor = "top-right";
    defaultTimeout = 5000;
    maxVisible = 5;
    borderRadius = 8;
    borderColor = "#e6b91e";
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    width = 350;
    padding = "12";
    groupBy = "summary";
    sort = "-time";
    font = "Sans 11";
  };
}
