$(document).ready(function () {
  $('#catalog-cat-all').on('click', function () {
    window.location.href = '/catalog';
  });

  $('#catalog-Webdesign').on('click', function () {
    window.location.href = '/catalog?category_category_type=Web design';
  });

  $('#catalog-Mobiledevelopment').on('click', function () {
    window.location.href = '/catalog?category_category_type=Mobile development';
  });

  $('#catalog-Databases').on('click', function () {
    window.location.href = '/catalog?category_category_type=Databases';
  });

  $('#catalog-Webdevelopment').on('click', function () {
    window.location.href = '/catalog?category_category_type=Web development';
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
  // sm
  $('#sm-catalog-cat-all').on('click', function () {
    window.location.href = '/catalog';
  });

  $('#sm-catalog-Webdesign').on('click', function () {
    window.location.href = '/catalog?category_category_type=Web design';
  });

  $('#sm-catalog-Mobiledevelopment').on('click', function () {
    window.location.href = '/catalog?category_category_type=Mobile development';
  });

  $('#sm-catalog-Databases').on('click', function () {
    window.location.href = '/catalog?category_category_type=Databases';
  });

  $('#sm-catalog-Webdevelopment').on('click', function () {
    window.location.href = '/catalog?category_category_type=Web development';
  });

  $('#sm-newest-first').on('click', function () {
    window.location.href = '/catalog?books_sorting=Newest first';
  });

  $('#sm-popular-first').on('click', function () {
    window.location.href = '/catalog?books_sorting=Popular first';
  });

  $('#sm-low-to-hight').on('click', function () {
    window.location.href = '/catalog?books_sorting=Low to hight';
  });

  $('#sm-hight-to-low').on('click', function () {
    window.location.href = '/catalog?books_sorting=Hight to low';
  });
});
