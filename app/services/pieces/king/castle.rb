module Pieces
  module King
    class Castle < ApplicationService
      attr_reader :king, :direction

      def initialize(king, direction)
        @king = king
        @direction = direction
      end

      def call
        return if king.moved

      end

      private

      def get_rook
        king.gameif direction = 'kingside'
      end
    end
  end
end
