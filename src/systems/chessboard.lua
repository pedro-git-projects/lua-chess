local colorutils = require("lib.colorutils")

ChessBoard = {
  light_square_color = colorutils.normalize_rgba(118, 150, 86, 1),
  dark_square_color = colorutils.normalize_rgba(255, 255, 255, 1),
  tile_size = 1,
  margin = 50,
  max_board_size = 1200,
  min_board_size = 400,
  bord_size = 0
}

function ChessBoard:new(t)
  t = t or {}

  t.light_square_color = t.light_square_color or self.light_square_color
  t.dark_square_color = t.dark_square_color or self.dark_square_color
  t.margin = t.margin or self.margin
  t.max_board_size = t.max_board_size or self.max_board_size
  t.min_board_size = t.min_board_size or self.min_board_size

  setmetatable(t, self)
  self.__index = self

  t:update_size(love.graphics.getWidth(), love.graphics.getHeight())
  return t
end

function ChessBoard:update_size(w, h)
  local size_with_margin = math.min(w, h) - 2 * self.margin
  local adjusted_size = math.max(math.min(size_with_margin, self.max_board_size), self.min_board_size)
  self.board_size = adjusted_size
  self.tile_size = adjusted_size / 8
end

function ChessBoard:draw()
  local window_width, window_height = love.graphics.getDimensions()
  local start_x = (window_width - self.board_size) / 2
  local start_y = (window_height - self.board_size) / 2

  for i = 1, 8 do
    for j = 1, 8 do
      local color = (i + j) % 2 == 0 and self.dark_square_color or self.light_square_color
      love.graphics.setColor(color)
      love.graphics.rectangle("fill", start_x + (i - 1) * self.tile_size, start_y + (j - 1) * self.tile_size,
        self.tile_size, self.tile_size)
    end
  end
end

return ChessBoard
