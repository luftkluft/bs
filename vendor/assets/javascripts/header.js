$(document).ready(function () {
  $('#cat_all').on('click', function () {
    window.location.href = '/catalog';
  });

  $('#Webdesign').on('click', function () {
    window.location.href = '/catalog?category_type_of=Web design';
  });

  $('#Mobiledevelopment').on('click', function () {
    window.location.href = '/catalog?category_type_of=Mobile development';
  });

  $('#Databases').on('click', function () {
    window.location.href = '/catalog?category_type_of=Databases';
  });

  $('#Webdevelopment').on('click', function () {
    window.location.href = '/catalog?category_type_of=Web development';
  });
});
