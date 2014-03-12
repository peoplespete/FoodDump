// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require jquery.turbolinks
//= require_tree .
$(document).ready(init);
function init(){
  choose_recommendation_button()
  $('input#rating_scale').on('change', rating_scale_change);
  document.styleSheets[0].addRule("input[type='range'][name='rating[scale]']::-webkit-slider-thumb", 'background-image: url("smiley.png")');
}

function choose_recommendation_button(){
  var adjusted_rating = $("input[type='range'][name='points']").val();
  var image = "";
  if(adjusted_rating > 66){
    image = "smiley.png";
  }else if( adjusted_rating > 33){
    image = "unsure.png";
  }else{
    image = "sad.png";
  }
  document.styleSheets[0].addRule("input[type='range'][name='points']::-webkit-slider-thumb", 'background-image: url(' + image + ')');
}

function rating_scale_change(){
  var rating = $("input[type='range'][name='rating[scale]'").val();
  var image = "";
  console.log(rating);
  if(rating > 66){
    image = "constipated.png";
  }else if(rating > 33){
    image = "smiley.png";
  }else{
    image = "unsure.png";
  }
  document.styleSheets[0].addRule("input[type='range'][name='rating[scale]']::-webkit-slider-thumb", 'background-image: url(' + image + ')');
}
$(function(){ $(document).foundation(); });
