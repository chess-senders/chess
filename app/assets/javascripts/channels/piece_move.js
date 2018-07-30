App.state = App.cable.subscriptions.create('StateChannel', {
  connected: function(data) {
    console.log('socket connected!')
  },

  received: function(data) {
    console.log('recieved!!!!!!!!', data)
    return $('#game_state').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return "<p>" + data.game_state + "</p>";
  }
});
