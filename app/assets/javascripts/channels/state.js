App.game = App.cable.subscriptions.create('GameChannel', {
  received: function(data) {
    return this.shakamelaka(data)
  },

  shakamelaka: function(data){
    $('#game_board').html(data.html);
  }
});
