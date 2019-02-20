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
//= require turbolinks
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery-ui
//= require cocoon
//= require tag-it
//= require bootstrap-sprockets
//= require_tree .

// ユーザーメニューのプルダウン

$(document).on('turbolinks:load', function() {
  $('#user-menu').hover(function(){
  $('#user-menu-topics').slideDown()
  },function(){
  $('#user-menu-topics').slideUp()
  });
});

// サブコンテンツの表示・非表示

$(document).on('turbolinks:load', function() {
  $('#sub-content-show').click(function(){
  $('#main-content').fadeOut(500);
  $(this).fadeOut();
  $('#sub-content').delay(500).fadeIn(500);
  $('#sub-content-hide').delay(500).fadeIn(500);
  });
});

$(document).on('turbolinks:load', function() {
  $('#sub-content-hide').click(function(){
  $('#sub-content').fadeOut(500);
  $(this).fadeOut();
  $('#main-content').delay(500).fadeIn(500);
  $('#sub-content-show').delay(500).fadeIn(500);});
});

// コンテンツの高さ調整
$(document).on('turbolinks:load', function() {
  function elementSet(idName){
    box = $('#content-'+idName).find('.content-box');
    head = $('#content-'+idName).find('.content-box-head');
    foot = $('#content-'+idName).find('.content-box-foot');
    body = $('#content-'+idName).find('.content-box-body');

    boxSize = $(box).outerHeight();
    headSize = $(head).outerHeight();
    footSize = $(foot).outerHeight();
    bodySize = boxSize - headSize - footSize;
    $(body).css("height", bodySize + "px");
  }

  $(document).ready(function () {
    elementSet('left');
    elementSet('right');
  });
  $(window).resize(function () {
    elementSet('left');
    elementSet('right');
  });
});

// フラッシュメッセージ

$(function(){
  setTimeout(function(){
  $('#flash').fadeOut()}, 5000)
});