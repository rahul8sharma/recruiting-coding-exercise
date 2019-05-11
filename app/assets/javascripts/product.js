$(document).ready(function() {
  var productIds = $('.currency-tag').map(function (index, element) {
    return $(element).data('id') + ""
  }).get().join();
  $('#currency_type').data('params',("product_ids=" + productIds))
});