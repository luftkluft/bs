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
});
