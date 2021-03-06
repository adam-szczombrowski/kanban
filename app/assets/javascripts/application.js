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
//= require jquery-ui
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(function() {
  initPage();
});

$(window).bind('page:change', function() {
  initPage();
});

function initPage() {
  $(".task").draggable({
    containment: ".tab",
    revert: "invalid",
    helper:"clone"
  });

  $(".drag").droppable({
    accept: ".task",
    tolerance: "pointer",
    drop: function(event,ui){
      var task_id = ui.draggable.attr('id');
      var new_cat = $(this).attr('id');
      var send_url = '/tasks/' + task_id + '/change';
      console.log(new_cat);
      ui.draggable.detach().appendTo($(this));
      $.ajax({
        method: 'put',
        url: send_url,
        data: { category: new_cat }
      });
    }
  });
}
