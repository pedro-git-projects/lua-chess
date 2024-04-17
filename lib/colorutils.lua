local ColorUtils = {}

--- Normalize RGB(A) colors from 0-255 range to 0-1 range.
--- @param r number: The red component (0-255).
--- @param g number: The green component (0-255).
--- @param b number: The blue component (0-255).
--- @param a number: The alpha component (0-255). Optional, defaults to 255.
--- @return table: Returns a table with normalized r, g, b, and a values.
function ColorUtils.normalize_rgba(r, g, b, a)
  a = a or 1
  return { r / 255, g / 255, b / 255, a }
end

return ColorUtils
