$ ->
  window.renderGlass
    slice: false

  $('form').on 'submit', (e) ->
    e.preventDefault()
    search = $('#search-bar').val()
    $.get "/drinks/#{encodeURIComponent(search)}", (drink) ->
      $('svg').remove()
      window.renderGlass
        slice: true
        components: drink.components
      renderDescription drink

  $(window).on 'resize', ->
    renderTitle()
    $('svg').remove()
    window.renderGlass
      slice: false

renderTitle = ->
  if $(window).width() < 700
    $('#logo').css 'font-size', '100px'
  else
    $('#logo').css 'font-size', '140px'

renderDescription = (drink) ->
  $('#drink-name').text drink.name
  $('#glass-image').attr('src', drink.glass) if drink.glass
  $('#instructions').text 'blah blah blah'
