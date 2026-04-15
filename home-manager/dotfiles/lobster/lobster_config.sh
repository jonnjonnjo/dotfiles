download_dir=~/Videos

download_video() {
  # Arguments: $1=url, $2=title, $3=dir, $4=json_data
  local title="$(echo "$2" | tr -d ':/')"
  local save_dir="$3"
  local raw_json="$4"
  local final_file="${save_dir}/${title}.mkv"
  local temp_vid="${save_dir}/${title}_vid_tmp.mkv"
  local temp_sub="${save_dir}/${title}_tmp.vtt"

  # --- 1. HANDLE VIDEO ---
  if [ ! -f "$final_file" ]; then
    echo "Video missing. Downloading highest quality..."
    # Quality Fix: Added -f "bestvideo+bestaudio/best"
    yt-dlp "$1" -f "bestvideo+bestaudio/best" --no-skip-unavailable-fragments --fragment-retries infinite -N 16 -o "$temp_vid"
  else
    echo "Video exists. Overriding and cleaning subtitle track..."
    # We rename to temp so we can read from it and write a fresh 'clean' version
    mv "$final_file" "$temp_vid"
  fi

  # --- 2. EXTRACT SUBTITLE URL ---
  local sub_url=$(echo "$raw_json" | grep -oP '"file":"\K[^"]+\.vtt(?=","label":"English")' | head -n 1)
  [ -z "$sub_url" ] && sub_url=$(echo "$raw_json" | grep -oP '"file":"\K[^"]+\.vtt' | head -n 1)

  # --- 3. DOWNLOAD & TRANSCODE MUX ---
  if [ -n "$sub_url" ]; then
    echo "Found Subtitle URL. Fetching..."
    curl -s -L -f "$sub_url" -o "$temp_sub"

    if [ -s "$temp_sub" ]; then
      echo "Stripping old subs and muxing fresh SRT..."
      # -sn: Strips any existing (potentially broken/gibberish) subtitles
      # -c:s srt: Transcodes VTT to clean SRT
      ffmpeg -loglevel error -i "$temp_vid" -i "$temp_sub" \
        -map 0:v:0 -map 0:a:0 -map 1:s:0 \
        -sn -c:v copy -c:a copy -c:s srt \
        -metadata:s:s:0 language=eng \
        -metadata:s:s:0 title="English" "${final_file}_fixed.mkv"

      if [ -f "${final_file}_fixed.mkv" ]; then
        mv "${final_file}_fixed.mkv" "$final_file"
        rm -f "$temp_vid" "$temp_sub"
        echo "Success: $final_file is now high quality with clean subs."
        return 0
      fi
    fi
  fi

  # Fallback: Restore file if sub process failed
  echo "Subtitle process failed. Restoring video."
  [ ! -f "$final_file" ] && mv "$temp_vid" "$final_file"
  rm -f "$temp_vid" "$temp_sub"
}
