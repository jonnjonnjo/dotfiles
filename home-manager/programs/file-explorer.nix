{ ... }:
{
  programs.ranger = {
    enable = true;
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
    };
  };
  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
  };
}
