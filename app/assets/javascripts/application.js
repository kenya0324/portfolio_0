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
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require data-confirm-modal
//= require turbolinks
//= require_tree .

/* レスポンシブ時のハンバーガーメニューの動きを指示しています */
$(document).on("turbolinks:load", function() {
  $('.menu_trigger').on('click', function() {
    $(this).toggleClass('active');
    $('#sp_menu').fadeToggle();
    return false;
  });
});


/* レスポンシブ時のpage_topの動きを指示しています */
$(function(){
  $(".page_top").hide();
    $(window).scroll(function(){
      if ($(this).scrollTop() > 60){
        $(".page_top").fadeIn();
      }else{
        $('.page_top').fadeOut();
      }
    });
    $('.page_top a').click(function() {
        $('html, body').animate({
            scrollTop:0
        }, 800);
        return false;
    });
});

/* about_barの動きを指示しています */
$(function(){
  $(".user_notlogin_about_all").hide();
    $(window).scroll(function(){
      if ($(this).scrollTop() > 60){
        $(".user_notlogin_about_all").fadeIn();
      }else{
        $('.user_notlogin_about_all').fadeOut();
      }
    });
});

/* レスポンシブ時のfooter_bottomの動きを指示しています */

$(function(){
  $(window).on("scroll touchmove", function(){
      $(".responsive_footer_bottom").css('display', 'none').delay(300).fadeIn('fast');
  });
});

