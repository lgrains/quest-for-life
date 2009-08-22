$(function() {
  $("form:not(.filter) :input:visible:enabled:first").focus();
  $("p.start-survey-prompt a").click(function(e) {
    $(this).closest('form').trigger('submit');
    e.preventDefault();
  });
});

