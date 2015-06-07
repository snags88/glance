$(function() {
    $("#sortable").sortable();
    $("#sortable").disableSelection();
    $("#editForm").on("submit", photoSorter.submit)
});

var photoSorter = {
  submit: function(e){
    $("#orderSubmit").val($("#sortable").sortable("toArray"))
  }
}