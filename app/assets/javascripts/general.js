$(window).load(function() {
  openSite();
});

//---------------------------------------
// SITE LOADED FUNCTIONS
//---------------------------------------
function openSite() {
  pushmenu();
  header();
  scroll();
  containerGridMasonry();
  photoSorter();
  shortCodeElements();
  addCopyListener();
}

//---------------------------------------
// SIDEBAR MENU SCRIPT
//---------------------------------------
function pushmenu() {
  $('.toggle-menu').jPushMenu();
};

//---------------------------------------
// HEADER SCRIPT
//---------------------------------------
function header() {
  var $home = $('.home')

  headerColor($home,'#fff');

  $(window).scroll(function () {
    if ($(this).scrollTop() > 1) {
      $('.header').addClass("sticky");
      $('.inner-intro').css('z-index', '-1');
      $('#menu-button li').addClass("header-menu-button");
      headerColor($home,'#323232');
    }
  else {
      $('.header').removeClass("sticky");
      $('.inner-intro').css('z-index', 'auto');
      $('#menu-button li').removeClass("header-menu-button");
      headerColor($home,'#fff');
    }
  });

  function headerColor($element, color){
    if ($element[0]) {
      $('header h3, header i').css('color', color);
    }
  }
}

//---------------------------------------
// ANIMATED SCROLL SCRIPT
//---------------------------------------
function scroll() {
    // Scroll Down Elements
  $('.scroll-down[href^="#"], .scroll-to-target[href^="#"]').on('click', function (e) {
    e.preventDefault();
    var target = this.hash;
    var $target = $(target);

    $('html, body').stop().animate({
        'scrollTop': $target.offset().top
    }, 900, 'swing');
  });
};

//---------------------------------------
// MASONRY SCRIPT
//---------------------------------------
function containerGridMasonry() {
  // Grid Element
  if ($(this).length > 0) {
    // ISOTOPE MASONRY ELEMENT  ||--------------
    var $container = $('.container-masonry').isotope({
      itemSelector: '.nf-item',
      layoutMode: 'masonry',
      masonry: {
        columnWidth: 0,
        gutter: 0
      },
    });

    $container.imagesLoaded( function() {
      $container.isotope('layout');
    });

    // bind filter button click
    $('.container-filter').on('click', '.categories', function () {
      var filterValue = $(this).attr('data-filter');
      $container.isotope({ filter: filterValue });
    });

    // ISOTOPE GRID ELEMENT  ||--------------
    var $container2 = $('.container-grid').isotope({
      itemSelector: '.nf-item',
      layoutMode: 'fitRows'
    });
    $container2.imagesLoaded( function() {
      $container2.isotope('layout');
    });

    // bind filter categories click
    $('.container-filter').on('click', '.categories', function () {
        var filterValue = $(this).attr('data-filter');
        $container2.isotope({ filter: filterValue });
    });

      // change active class on categories
    $('.categories-filter').each(function (i, buttonGroup) {
      var $buttonGroup = $(buttonGroup);
      $buttonGroup.on('click', '.categories', function () {
        $buttonGroup.find('.active').removeClass('active');
        $(this).addClass('active');
      });
    });
  };

  // Masonry Element
  if ($(this).length > 0) {
    var container = $('.masonry');
    container.masonry({
      // columnWidth: 0,
      itemSelector: '.nf-item'
    });
  };
};

//---------------------------------------
// SORTABLE PHOTO SCRIPT
//---------------------------------------

function photoSorter() {
  $("#sortable").sortable({
    start: function (event, ui) {
      $(this).data("startingScrollTop",window.pageYOffset);
    },
    drag: function(event,ui){
       var st = parseInt($(this).data("startingScrollTop"));
       ui.position.top -= st;
    },
    scroll: true
  });
  $("#sortable").disableSelection();
  $("#editForm").on("submit", function(e){
    $("#orderSubmit").val($("#sortable").sortable("toArray"))
  });
}

//---------------------------------------
// jqueryUI SCRPIT
//---------------------------------------
jqueryUi();
function jqueryUi() {
  $(function () {
    if($(".tabs")[0]){
      $(".tabs").tabs();
    }
  });
}

//---------------------------------------
// shortCode Script
//---------------------------------------
shortCodeElements();
function shortCodeElements(){
    lightbox();
    function lightbox() {
        $(".cbox-gallery1").colorbox({
            rel: 'gallary',
            maxWidth: "95%",
            maxHeight: "95%"

        });
        $(".cbox-iframe").colorbox({
            iframe: true,
            maxWidth: "95%",
            maxHeight: "95%",
            innerWidth: 640,
            innerHeight: 390
        });
    };
}

//---------------------------------------
// Copy to Clipboard
//---------------------------------------

function addCopyListener(){
  var client = new ZeroClipboard($("#copy"))
  client.on("copy", copyToClipboard)
}

function copyToClipboard(event) {
  var clipboard = event.clipboardData;
  var text = $("#public-url").text();
  clipboard.setData("text/plain", text)
  showFeedback();
}

function showFeedback(){
  $('#feedback').removeClass('not-visible');
  setTimeout(function(){
    $('#feedback').addClass('not-visible');
  }, 1000)
}