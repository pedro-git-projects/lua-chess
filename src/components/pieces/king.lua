King = {}
King.__index = King

function King.new(color, position)
  local self = setmetatable({}, King)
  self.color = color
  self.position = position
  self.can_castle = true
  self.legal_moves = {}
  return self
end

function King:calculateLegalMoves(board)
  local directions = {
    { 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 },
    { 1, 1 }, { 1, -1 }, { -1, 1 }, { -1, -1 },
  }

  for _, dir in ipairs(directions) do
    local nextRow = self.position.rank + dir[1]
    local nextCol = self.position.file + dir[2]

    if board:isWithinBounds(nextRow, nextCol) and (board:isEmpty(nextRow, nextCol) or board:isEnemy(nextRow, nextCol, self.color)) then
      table.insert(self.legal_moves, { row = nextRow, col = nextCol })
    end
  end

  if self.can_castle then
    self:addCastlingMoves(board)
  end
end

function King:addCastlingMoves(board)
  -- TODO
end

function King:moveTo(newPosition)
  -- Update position
  self.position = newPosition
  -- Reset castle rights if moved
  self.can_castle = false
end

return King
