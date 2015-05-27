$(function() {
    $("#sortable").sortable();
    $("#sortable").disableSelection();
    $("#sortForm").on("submit", photoSorter.submit)
});

var photoSorter = {
  submit: function(e){
    $("#orderSubmit").val($("#sortable").sortable("toArray"))
  }
}