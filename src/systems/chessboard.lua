local colorutils = require("lib.colorutils")

ChessBoard = {
  light_square_color = colorutils.normalize_rgba(255, 255, 255, 1),
  dark_square_color = colorutils.normalize_rgba(118, 150, 86, 1),
  tile_size = 1,
  margin = 50,
  border_size = 40,
  label_space = 20,
  max_board_size = 1200,
  min_board_size = 400,
  frame_width = 4,
  bord_size = 0,
  pieces = {}
}


function ChessBoard:init_pieces()
  for i = 1, 8 do
    self.pieces[i] = {}
    for j = 1, 8 do
      self.pieces[i][j] = nil
    end
  end
  -- TODO: actually init pieces
end

function ChessBoard:new(t)
  t = t or {}

  t.light_square_color = t.light_square_color or self.light_square_color
  t.dark_square_color = t.dark_square_color or self.dark_square_color
  t.margin = t.margin or self.margin
  t.max_board_size = t.max_board_size or self.max_board_size
  t.min_board_size = t.min_board_size or self.min_board_size

  setmetatable(t, self)
  self.__index = self

  t:init_pieces()
  t:update_size(love.graphics.getWidth(), love.graphics.getHeight())
  return t
end

function ChessBoard:update_size(w, h)
  local size_with_margin = math.min(w, h) - 2 * self.margin
  local adjusted_size = math.max(math.min(size_with_margin, self.max_board_size), self.min_board_size)
  self.board_size = adjusted_size
  self.tile_size = adjusted_size / 8
end

function ChessBoard:render_labels(start_x, start_y)
  love.graphics.setColor(self.dark_square_color)
  local font = love.graphics.newFont(16)
  love.graphics.setFont(font)

  for i = 1, 8 do
    love.graphics.print(string.char(96 + i), start_x + (i - 1) * self.tile_size + self.tile_size / 2,
      start_y + self.board_size + self.frame_width)

    love.graphics.print(tostring(9 - i), start_x - self.label_space,
      start_y + (8 - i) * self.tile_size + self.tile_size / 2)
  end
end

function ChessBoard:render_borders(start_x, start_y)
  love.graphics.setColor(self.light_square_color)
  love.graphics.rectangle("fill", start_x - self.border_size, start_y - self.border_size,
    self.board_size + 2 * self.border_size, self.board_size + 2 * self.border_size)
end

function ChessBoard:render_frame(start_x, start_y)
  love.graphics.setColor(self.dark_square_color)
  love.graphics.rectangle("fill", start_x - self.frame_width, start_y - self.frame_width,
    self.board_size + 2 * self.frame_width, self.board_size + 2 * self.frame_width)
end

function ChessBoard:render_squares(start_x, start_y)
  for i = 1, 8 do
    for j = 1, 8 do
      local color = (i + j) % 2 == 0 and self.dark_square_color or self.light_square_color
      love.graphics.setColor(color)
      love.graphics.rectangle("fill", start_x + (j - 1) * self.tile_size, start_y + (8 - i) * self.tile_size,
        self.tile_size, self.tile_size)
    end
  end
end

function ChessBoard:draw()
  local window_width, window_height = love.graphics.getDimensions()
  local total_width = self.board_size + 2 * (self.border_size + self.frame_width + self.label_space)
  local start_x = (window_width - total_width) / 2 + self.border_size + self.frame_width + self.label_space
  local start_y = (window_height - total_width) / 2 + self.border_size + self.frame_width + self.label_space
  self:render_borders(start_x, start_y)
  self:render_frame(start_x, start_y)
  self:render_squares(start_x, start_y)
  self:render_labels(start_x, start_y)
end

return ChessBoard
