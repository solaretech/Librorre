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
//= require turbolinks
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery-ui
//= require cocoon
//= require tag-it
//= require bootstrap-sprockets
//= require_tree .


$(function(){
  $('#user-menu').hover(function(){
    $('#user-menu-topics').slideDown()
  },function(){
    $('#user-menu-topics').slideUp()
  });

  $('#sub-content-show').click(function(){
    $('#main-content').fadeOut(500);
    $(this).fadeOut();
    $('#sub-content').delay(500).fadeIn(500);
    $('#sub-content-hide').delay(500).fadeIn(500);
  });

  $('#sub-content-hide').click(function(){
    $('#sub-content').fadeOut(500);
    $(this).fadeOut();
    $('#main-content').delay(500).fadeIn(500);
    $('#sub-content-show').delay(500).fadeIn(500);
  });

});
