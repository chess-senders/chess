App.messages = App.cable.subscriptions.create('MessagesChannel', {
  connected: function(data) {
    console.log('socket connected!')
  },

  received: function(data) {
    console.log('recieved!!!!!!!!', data)
    return $('#messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return "<p>" + data.message + "</p>";
  }
});
