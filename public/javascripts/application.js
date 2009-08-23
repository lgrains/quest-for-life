$(function() {
  $("form:not(.filter) :input:visible:enabled:first").focus();
  $("p.start-survey-prompt a").click(function(e) {
    $(this).closest('form').trigger('submit');
    e.preventDefault();
  });
});

DD_roundies.addRule('p.start-survey-prompt', '12px');
DD_roundies.addRule('p.twitter a', '6px');
//DD_roundies.addRule('#header #main-nav dl.equation', '10px');
//DD_roundies.addRule('div#form', '12px');
//DD_roundies.addRule('#parameter-symbol', '12px');


