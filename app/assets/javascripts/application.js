// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

var hide_spinner = function(){
  $('#spinner').hide();
}

var show_spinner = function(){
  $('#spinner').show();
}


$(document).ready(function() {

  $('#toggle-alternatives').click(function(){
    $('#alternatives-body').slideToggle("fast");
    $('#toggle-alternatives-label').html(function(i, text){
      return text === "Collapse" ? "Expand" : "Collapse";
    });
  });
  
  $('#toggle-proposals').click(function(){
    $('#proposals-body').slideToggle("fast");
    $('#toggle-proposals-label').html(function(i, text){
      return text === "Hide" ? "Show" : "Hide";
    });
  });
  
});