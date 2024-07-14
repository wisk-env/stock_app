$(function() {
  $('#baskets').on('click', function() {
    $('.checkbox').prop('checked', $(this).prop("checked"));
  });
});
