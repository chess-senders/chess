require 'rails_helper'

RSpec.describe King, type: :model do
  player = FactoryBot.create(:player, playername: 'Wayne')
  game = FactoryBot.create(:game, white_player: player)
  king = FactoryBot.create(:king, game: game, player: player)

  describe 'tries to move' do
    it 'will not move more than 1 row' do
      king.move_to!({ row: 5, column: 3})
      expect(king.row).to eq(3)
      expect(king.column).to eq(3)
    end

    it 'will not move more than 1 column' do
      king.move_to!({ row: 3, column: 5})
      expect(king.row).to eq(3)
      expect(king.column).to eq(3)
    end

    it 'will not move more than 1 row and column' do
      king.move_to!({ row: 5, column: 5})
      expect(king.row).to eq(3)
      expect(king.column).to eq(3)
    end

    it 'is able to move up 1 row' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move_to!({ row: 2, column: 3})
      expect(king.row).to eq(2)
      expect(king.column).to eq(3)
    end

    it 'is able to move down 1 row' do
      king = FactoryBot.build(:king, game: game, player: player)
      king.move_to!({ row: 4, column: 3})
      expect(king.row).to eq(4)
      expect(king.column).to eq(3)
    end

    it 'is able to move right 1 column' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move_to!({ row: 3, column: 4})
      expect(king.row).to eq(3)
      expect(king.column).to eq(4)
    end

    it 'is able to move left 1 column' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move_to!({ row: 3, column: 2})
      expect(king.row).to eq(3)
      expect(king.column).to eq(2)
    end

    it 'is able to move diagnolly' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move_to!({ row: 2, column: 4})
      expect(king.row).to eq(2)
      expect(king.column).to eq(4)
    end

    it 'is able to move down_left' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move_to!({ row: 4, column: 4})
      expect(king.row).to eq(4)
      expect(king.column).to eq(4)
    end

    it 'is able to move down_right' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move_to!({ row: 4, column: 3})
      expect(king.row).to eq(4)
      expect(king.column).to eq(3)
    end

    it 'is able to move up_left' do
      king = FactoryBot.create(:king, game: game, player: player)
      king.move_to!({ row: 2, column: 2})
      expect(king.row).to eq(2)
      expect(king.column).to eq(2)
    end
  end

  describe 'tries to make special move' do

    it 'castles with kingside rook' do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      black_player = FactoryBot.create(:player, playername: 'Ricky')
      game = FactoryBot.create(:game, white_player: white_player, black_player: black_player)
      king = FactoryBot.create(:king, game: game, player: white_player, row: 0, column: 4)
      rook_kingside = FactoryBot.create(:rook, game: game, player: white_player, row: 0, column: 7)
      rook_queenside = FactoryBot.create(:rook, game: game, player: white_player, row: 0, column: 0)

      king.castle!('kingside')
      king.reload
      rook_kingside.reload

      expect(king.row).to eq(0)
      expect(king.column).to eq(6)
      expect(rook_kingside.row).to eq(0)
      expect(rook_kingside.column).to eq(5)
      expect(rook_queenside.row).to eq(0)
      expect(rook_queenside.column).to eq(0)
    end

    it 'castles queenside' do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      black_player = FactoryBot.create(:player, playername: 'Ricky')
      game = FactoryBot.create(:game, white_player: white_player, black_player: black_player)
      king = FactoryBot.create(:king, game: game, player: white_player, row: 0, column: 4)
      rook_kingside = FactoryBot.create(:rook, game: game, player: white_player, row: 0, column: 7)
      rook_queenside = FactoryBot.create(:rook, game: game, player: white_player, row: 0, column: 0)

      king.castle!('queenside')
      king.reload
      rook_queenside.reload

      expect(king.row).to eq(0)
      expect(king.column).to eq(1)
      expect(rook_queenside.row).to eq(0)
      expect(rook_queenside.column).to eq(2)
      expect(rook_kingside.row).to eq(0)
      expect(rook_kingside.column).to eq(7)
    end

    it 'will not castle if king has already been moved' do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      black_player = FactoryBot.create(:player, playername: 'Ricky')
      game = FactoryBot.create(:game, white_player: white_player, black_player: black_player)
      king = FactoryBot.create(:king, game: game, player: white_player, row: 0, column: 4)
      rook = FactoryBot.create(:rook, game: game, player: white_player, row: 0, column: 7)

      king.move_to!({ row: 0, column: 3 })
      king.reload
      king.castle!('kingside')
      expect(king.row).to eq(0)
      expect(king.column).to eq(3)
      expect(rook.row).to eq(0)
      expect(rook.column).to eq(7)
    end

    it 'will not castle if rook has already been moved' do
      white_player = FactoryBot.create(:player, playername: 'Wayne')
      black_player = FactoryBot.create(:player, playername: 'Ricky')
      game = FactoryBot.create(:game, white_player: white_player, black_player: black_player)
      king = FactoryBot.create(:king, game: game, player: white_player, row: 0, column: 4)
      rook = FactoryBot.create(:rook, game: game, player: white_player, row: 0, column: 0)

      rook.move_to!({ row: 0, column: 3 })
      rook.reload
      king.castle!('queenside')
      expect(king.row).to eq(0)
      expect(king.column).to eq(4)
      expect(rook.row).to eq(0)
      expect(rook.column).to eq(3)
    end
  end

end
