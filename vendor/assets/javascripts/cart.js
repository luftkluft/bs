$(document).ready(function () {
  $('#cart-btn-coupon').on('click', function () {
    code = document.getElementById("cart-input-coupon-code").value;
    // alert(code);
    window.location.href = '/coupon?code=' + code;
    return true;
  });
});