$(function(){
  Form.linkManager();
  $('#add_contributor').on('click', Form.addContributor);
})

var Form = {
  addContributor: function(e){
    stopAction(e);
    var $inputField = $('#contributors input').first().clone().val("");
    $('#contributors').append($inputField);
    Form.linkManager();
  },
  removeContributor: function(e){
    stopAction(e);
    $('#contributors input').last().remove();
    Form.linkManager();
  },
  linkManager: function(){
    if($('#contributors input').size()  === 2 && $(".disabled")[0]){
      $('#remove_contributor').removeClass("disabled");
      replaceClickEvent('#remove_contributor', Form.removeContributor)
    }
    if($('#contributors input').size()  === 1) {
      $('#remove_contributor').addClass("disabled");
      replaceClickEvent('#remove_contributor', stopAction)
    }
  }
}

var stopAction = function(e) {
  e.preventDefault();
  e.stopPropagation();
}

var replaceClickEvent = function(element, handler) {
  $(element).off();
  $(element).on('click', handler);
}