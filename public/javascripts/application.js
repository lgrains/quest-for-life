$(function() {
  $("form:not(.filter) :input:visible:enabled:first").focus();
  $("p.start-survey-prompt a").click(function(e) {
    $(this).closest('form').trigger('submit');
    e.preventDefault();
  });
});

//DD_roundies.addRule('p.start-survey-prompt', '12px');
DD_roundies.addRule('p.twitter a', '6px');


