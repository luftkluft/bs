$(document).ready(function () {
  $("#plus_book").click(function (e) {
    e.preventDefault()
    var el=document.getElementById("book_count");
    if (el.value <= 14) {
      el.value = Number(el.value) + 1;
    };
    return false
  })
  $("#minus_book").click(function (e) {
    e.preventDefault()
    var el=document.getElementById("book_count");
    if (el.value >= 2) {
      el.value = Number(el.value) - 1;
    };
    return false
  })

  $("#plus_score").click(function (e) {
    e.preventDefault()
    var el=document.getElementById("score_count");
    if (el.value <= 4) {
      el.value = Number(el.value) + 1;
    };
    return false
  })
  $("#minus_score").click(function (e) {
    e.preventDefault()
    var el=document.getElementById("score_count");
    if (el.value >= 1) {
      el.value = Number(el.value) - 1;
    };
    return false
  })
});