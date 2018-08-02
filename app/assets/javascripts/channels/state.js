App.game = App.cable.subscriptions.create('GameChannel', {
  received: function(data) {
    return this.render_chessboard(data)
  },

  render_chessboard: function(data){
    $('#game_board').html(data.html);
  }
});
