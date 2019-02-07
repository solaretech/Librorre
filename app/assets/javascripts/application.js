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
//= require cocoon
//= require jquery
//= require bootstrap-sprockets
//= require jquery-ui
//= require tag-it
//= require_tree .


$(function(){
  $('#user-edit').click(function(){
    $('.user-history').fadeOut(500);
    $(this).fadeOut();
    $('.user-info').animate({opacity: 0.2}, 500);
    $('.user-edit').delay(500).fadeIn(500);
    $('#user-edit-cancel').delay(500).fadeIn(500);
  });

  $('#user-edit-cancel').click(function(){
    $('.user-edit').fadeOut(500);
    $(this).fadeOut();
    $('.user-info').animate({opacity: 1}, 500);
    $('.user-history').delay(500).fadeIn(500);
    $('#user-edit').delay(500).fadeIn(500);
  });
});