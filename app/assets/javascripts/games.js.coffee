# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # Perform search if the user hits return on the title field
  $('#game_title').keypress (e) ->
    if (e.keyCode == 13)
      e.preventDefault()
      $('#perform-search').click()
