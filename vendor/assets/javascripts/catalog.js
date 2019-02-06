$(document).ready(function () {
  $('#catalogcat_all').on('click', function () {
    window.location.href = '/catalog';
  });

  $('#catalogWebdesign').on('click', function () {
    window.location.href = '/catalog?category_type_of=Web design';
  });

  $('#catalogMobiledevelopment').on('click', function () {
    window.location.href = '/catalog?category_type_of=Mobile development';
  });

  $('#catalogDatabases').on('click', function () {
    window.location.href = '/catalog?category_type_of=Databases';
  });

  $('#catalogWebdevelopment').on('click', function () {
    window.location.href = '/catalog?category_type_of=Web development';
  });

  $('#newest-first').on('click', function () {
    window.location.href = '/catalog?books_sorting=Newest first';
  });

  $('#popular-first').on('click', function () {
    window.location.href = '/catalog?books_sorting=Popular first';
  });

  $('#low-to-hight').on('click', function () {
    window.location.href = '/catalog?books_sorting=Low to hight';
  });

  $('#hight-to-low').on('click', function () {
    window.location.href = '/catalog?books_sorting=Hight to low';
  });
});
