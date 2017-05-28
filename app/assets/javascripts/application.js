//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require select2
//= require_tree .

$(document).ready(function() {
   $(".select2").select2();
  $("circle").on("mouseover", function(e) {
    return $("a#" + e.target.id).toggleClass("highlight");
  });
  $("circle").on("mouseout", function(e) {
    return $("a#" + e.target.id).toggleClass("highlight");
  });
  $("a.blip").on("mouseover", function(e) {
    return $("circle#" + e.target.id).attr("style", "fill:yellow;");
  });
  return $("a.blip").on("mouseout", function(e) {
    return $("circle#" + e.target.id).attr("style", "fill:black;");
  });
});
