$(function(){
  $('#add_contributor').on('click', Form.addContributor);
  $('#remove_contributor').on('click', Form.removeContributor);
})

var Form = {
  addContributor: function(e){
    e.preventDefault();
    e.stopPropagation();
    var $inputField = $('#contributors input').first().clone().val("");
    $('#contributors').append($inputField);
  },
  removeContributor: function(e){
    e.preventDefault();
    e.stopPropagation();
    $('#contributors input').last().remove();
  }
  // linkManager: function(){
  //   if($('#contributors input').length  > 1){
  //     $('#remove_contributor').removeClass("disabled");
  //   }
  // }
}

