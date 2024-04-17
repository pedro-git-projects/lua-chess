local chess_board = require("src.systems.chessboard")

function love.load()
  love.window.setTitle("Simple Chess")
  love.window.setMode(960, 720, { resizable = true })
  ChessBoard = chess_board:new()
end

function love.update(dt)
end

function love.resize(w, h)
  ChessBoard:update_size(w, h)
end

function love.draw()
  ChessBoard:draw()
end
