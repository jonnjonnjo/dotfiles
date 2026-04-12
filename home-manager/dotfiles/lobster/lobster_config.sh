download_dir=~/Videos

download_video() {
  yt-dlp "$1" \
    --external-downloader aria2c \
    --external-downloader-args "aria2c:-x 16 -s 16 -k 1M" \
    --merge-output-format mp4 \
    --remux-video mp4 \
    -o "$3/$2.%(ext)s"
}

