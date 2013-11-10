$ ->
  window.renderGlass
    slice: false

  $('form').on 'submit', (e) ->
    e.preventDefault()
    search = $('#search-bar').val()
    $.get "/drinks/#{encodeURIComponent(search)}", (data) ->
      $('svg').remove()
      window.renderGlass
        slice: true
        components: data.components
        drinkName: data.name

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
