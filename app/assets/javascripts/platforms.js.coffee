# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.fn.outerHTML = () ->
  $(this).clone().wrap('<p>').parent().html()

$ ->
  $('a[disabled]').click (e) ->
    e.preventDefault()
