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
//= require jquery
//= require rails-ujs
//= require popper
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .

var scope = 'Global';

$(document).on('turbolinks:load', function(){
  let path = location.pathname;
  if(path.match(/favorites$/)){
    $('.nav-fav').css({'border-bottom': '2px solid #1DA1F2'});
  }else if(path.match(/following$/)){
    $('.nav-following').css({'border-bottom': '2px solid #1DA1F2'});
  }else if(path.match(/followers$/)){
    $('.nav-followers').css({'border-bottom': '2px solid #1DA1F2'});
  }else if(path.match(/^\/users\/.+/)){
    $('.nav-tweet').css({'border-bottom': '2px solid #1DA1F2'});
  }else if(path.match(/\//)){
    $('.nav-home').css({'border-bottom': '2px solid #1DA1F2'});
  }

  $('.nav-item').on('click', function(e){
    console.log(e.target.className);
  });

  function getValue(){
    console.log(scope);
    var scope =　'Local';
  }

  getValue();

});
