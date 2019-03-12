// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//# require turbolinks
//= require header
//= require book
//= require catalog
//= require home
//= require cart
//= require_tree .

function delete_item(item_id) {
  if (confirm("Are you sure?")) {
    window.location.href = '/delete_item?delete_item=' + item_id;
    return true;
  }
  else {
    return false;
  }
}

function change_quantity(click_id, item_id) {
  var el = document.getElementById('cart-input-item-' + item_id);
  if (click_id.includes('plus')) {
    if (el.value <= 14) {
      el.value = Number(el.value) + 1;
      $.ajax({
        type: "GET",
        url: '/increment',
        data: { increment: item_id }
      })
    };
  }

  if (click_id.includes('minus')) {
    if (el.value >= 1) {
      el.value = Number(el.value) - 1;
      $.ajax({
        type: "GET",
        url: '/decrement',
        data: { decrement: item_id }
      })
    };
  }
  return true;
}