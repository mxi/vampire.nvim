function clamp(v, lo, hi)
  return math.min(math.max(v, lo), hi)
end

function lerp(a, b, frac)
  return a * (1 - frac) + b * frac
end

function get_rgba_from_hex(hex)
  local r = tonumber(string.sub(hex, 2, 3), 16) / 255
  local g = tonumber(string.sub(hex, 4, 5), 16) / 255
  local b = tonumber(string.sub(hex, 6, 7), 16) / 255
  local a = nil
  if #hex >= 9 then
    a = tonumber(string.sub(hex, 8, 9), 16) / 255
  end
  return r, g, b, a
end

function get_hex_from_rgba(r, g, b, a)
  r = r * 255
  g = g * 255
  b = b * 255
  if a ~= nil then
    return string.format("#%02x%02x%02x%02x", r, g, b, a)
  end
  return string.format("#%02x%02x%02x", r, g, b)
end

function distribute_rgb(r, g, b)
  -- https://stackoverflow.com/a/141943
  local threshold = 1.0
  local m = math.max(r, g, b)
  if m <= threshold then
    return r, g, b
  end
  local total = r + g + b
  if total >= 3 * threshold then
    return 1.0, 1.0, 1.0
  end
  local x = (3 * threshold - total) / (3 * m - total)
  gray = threshold - x * m
  return (gray + x*r), (gray + x*g), (gray + x*b)
end

function lighten_color(hex, scale)
  local r, g, b, a = get_rgba_from_hex(hex)
  r = r * scale
  g = g * scale
  b = b * scale
  r, g, b = distribute_rgb(r, g, b)
  return get_hex_from_rgba(r, g, b, a)
end

function lerp_colors(hex1, hex2, frac)
  frac = clamp(frac, 0.0, 1.0)
  local r1, g1, b1, a1 = get_rgba_from_hex(hex1)
  local r2, g2, b2, a2 = get_rgba_from_hex(hex2)
  local r = lerp(r1, r2, frac)
  local g = lerp(g1, g2, frac)
  local b = lerp(b1, b2, frac)
  local a = nil
  if a1 ~= nil or a2 ~= nil then
    a = lerp(a1 or 1.0, a2 or 1.0, frac)
  end
  return get_hex_from_rgba(r, g, b, a)
end
