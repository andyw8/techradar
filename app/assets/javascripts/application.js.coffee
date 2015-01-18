# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative pat
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require select2
#= require_tree .

$(document).ready ->
  $(".select2").select2()
  $("circle").on("mouseover", (e) ->
    $("a#" + e.target.id).toggleClass("highlight")
  )
  $("circle").on("mouseout", (e) ->
    $("a#" + e.target.id).toggleClass("highlight")
  )
  $("a.blip").on("mouseover", (e) ->
    $("circle#" + e.target.id).attr("style", "fill:yellow;")
  )
  $("a.blip").on("mouseout", (e) ->
    $("circle#" + e.target.id).attr("style", "fill:black;")
  )
