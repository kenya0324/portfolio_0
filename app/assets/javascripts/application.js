// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require data-confirm-modal

/* レスポンシブ時のハンバーガーメニューの動きを指示しています */
$(document).on("turbolinks:load", function() {
  $('.menu-trigger').on('click', function() {
    $(this).toggleClass('active');
    $('#sp-menu').fadeToggle();
    return false;
  });
 });

$(“#page_top”).hide();
  $(window).scroll(function(){
    $(‘#pos’).text($(this).scrollTop());
    if ($(this).scrollTop() > 60){
      $(“#back-to-top”).fadeIn();
    }else{
      $(‘#back-to-top’).fadeOut();
    }
  });
  $(‘#page_top a’).click(function() {
      $(‘html, body’).animate({
          scrollTop:0
      }, 800);
      return false;
  });
