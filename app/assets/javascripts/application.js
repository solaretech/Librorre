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
  $('#user-menu-topics').show()
  },function(){
  $('#user-menu-topics').hide()
  });
});

// サブコンテンツの表示・非表示
$(document).on('turbolinks:load', function() {
  $('#sub-content-show').click(function(){
    $('#main-content').fadeOut(500);
    $('#sub-content').delay(500).fadeIn(500);
  });
});

$(document).on('turbolinks:load', function() {
  $('#sub-content-hide').click(function(){
    $('#sub-content').fadeOut(500);
    $('#main-content').delay(500).fadeIn(500);
  });
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

// レスポンシブ表示時のスイッチング
$(document).on('turbolinks:load', function() {
  // 左右それぞれのcontent-boxにあるヘッダーテキストを取得
  var leftText = $('#content-left').find('.content-box-head').text();
  var rightText = $('#content-right').find('.content-box-head').text();
  // 左右それぞれにコンテンツがあるか確認。
  if(rightText != null){
    // 左右それぞれのフッター部分に要素追加。まずは要素自体を取得。
    var leftBox = $('#content-left');
    var rightBox = $('#content-right');
    // 続いて、要素の終端にHTML要素を追加

    leftBox.append('<div id="switch-right"></div>');
    rightBox.append('<div id="switch-left"></div>');
    //挿入したHTML要素にテキストを表示
    $('#switch-right').html(rightText + '<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>');
    $('#switch-left').html('<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>' + leftText);

    //左右切り替えスイッチ
    $('#switch-right').click(function(){
      $('#content-left').hide();
      $('#content-right').show();
    });
    $('#switch-left').click(function(){
      $('#content-right').hide();
      $('#content-left').show();
    });
  }

});

// フラッシュメッセージ

$(function(){
  setTimeout(function(){
  $('#flash').fadeOut()}, 5000)
});
