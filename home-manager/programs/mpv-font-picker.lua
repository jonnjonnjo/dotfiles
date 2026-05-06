local utils = require('mp.utils')
local script_name = mp.get_script_name()

local function get_system_fonts()
  local result = mp.command_native({
    name = 'subprocess',
    args = { 'fc-list', '--format', '%{family[0]}\n' },
    capture_stdout = true,
    playback_only = false,
  })

  if not result or result.status ~= 0 then
    mp.osd_message('font-picker: failed to list fonts')
    return {}
  end

  local seen = {}
  local fonts = {}
  for line in result.stdout:gmatch('[^\n]+') do
    local font = line:match('^%s*(.-)%s*$')
    if font ~= '' and not seen[font] then
      seen[font] = true
      fonts[#fonts + 1] = font
    end
  end
  table.sort(fonts)
  return fonts
end

local const_fonts = get_system_fonts()

local function randomized_font()
  local fonts = const_fonts;
  math.randomseed(os.time())
  local font = fonts[math.random(#fonts)]
  mp.set_property("sub-font", font)
  mp.osd_message("Subtitle font: " .. font)
  print("Set subtitle font to: " .. font)
end

local function print_hello()
  print("hello world, HOPEFULLY WORKS")
  mp.osd_message("FROM OSD")
end

local function open_font_menu()
  mp.osd_message('font-picker: loading fonts...', 3)
  local fonts = const_fonts
  if #fonts == 0 then
    mp.osd_message('font-picker: no fonts found', 3)
    return
  end

  local current = mp.get_property('sub-font', '')
  mp.osd_message("Current font: " .. current, 5)
  local items = {}
  for _, font in ipairs(fonts) do
    items[#items + 1] = {
      title = font,
      value = { 'script-message-to', script_name, 'apply-font', font },
      active = (font == current) and 1 or nil,
    }
  end

  mp.commandv('script-message-to', 'uosc', 'open-menu', utils.format_json({
    type = 'font_picker',
    title = 'Subtitle Font',
    search_style = 'on_demand',
    items = items,
  }))
end

mp.register_script_message('apply-font', function(font)
  mp.set_property('sub-font', font)
  mp.osd_message('Subtitle font: ' .. font, 2)
end)

mp.add_key_binding(nil, "print-hello", print_hello)
mp.add_key_binding(nil, "randomized-font", randomized_font)
mp.add_key_binding(nil, "select-font", open_font_menu)
