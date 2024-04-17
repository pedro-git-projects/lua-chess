local ChessBoard = require("src.systems.chessboard")

function love.load()
  love.window.setTitle("Simple Chess")
  love.window.setMode(960, 720, { resizable = true })
  Board = ChessBoard:new()
end

function love.update(dt)
end

function love.resize(w, h)
  Board:update_size(w, h)
end

function love.draw()
  Board:draw()
end
