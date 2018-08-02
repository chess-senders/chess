App.game = App.cable.subscriptions.create('GameChannel', {
  received: function(data) {
    console.log(data)
    return this.shakamelaka(data)

    $('.draggable .piece').draggable({
      drag: (e) =>{
        console.log('dragggggggging on!')
        droppable($(e.target).data('url'));
      }
    });
  },

  shakamelaka: function(data){
    $('#game_board').html(data.html);
  },

  droppable: function(url){
    $( ".droppable" ).droppable({
      drop: (e)=>{
        $.ajax({
          type: 'PUT',
          url: url,
          data: { row: $(e.target).data('row'), column: $(e.target).data('column') }
        });
      }
    });
  }
});
