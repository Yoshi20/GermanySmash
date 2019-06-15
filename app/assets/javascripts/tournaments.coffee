# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->

  # hide the game stations submit button in tournament#show
  $('.game-stations-button').hide()

  # a click on a game stations number field sends an AJAX request in tournament#show
  $('.game-stations-number-field').bind('change', ->
    $t = $(this)
    $form = $t.closest('form')[0]
    data =
      'registration':
        game_stations: $t[0].value
    $.ajax
      method: 'patch'
      url: $form.action
      data: data
      dataType: 'json'
      error: ->
        console.log("error: update game_stations ajax request")
      success: (response) ->
        # console.log(response)
  )

  # hide the paid fee submit button in tournament#show
  $('.paid-fee-button').hide()

  # a click on a paid fee checkbox sends an AJAX request in tournament#show
  $('.paid-fee-checkbox').bind('change', ->
    $t = $(this)
    $form = $t.closest('form')[0]
    data =
      'registration':
        paid_fee: if $t[0].checked then $t[0].value else 0
    $.ajax
      method: 'patch'
      url: $form.action
      data: data
      dataType: 'json'
      error: ->
        console.log("error: update paid_fee ajax request")
      success: (response) ->
        # console.log(response)
  )

  # styling bugfix when field_with_errors class was added to a form-group-inline class
  $('.form-group-inline').each (i, fgi) =>
    if fgi.childNodes[1].className == 'field_with_errors'
      fgi.style.display = 'block'
