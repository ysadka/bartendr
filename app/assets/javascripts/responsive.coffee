$ ->
  window.renderGlass
    slice: false

  $('form').on 'submit', (e) ->
    e.preventDefault()
    search = $('#search-bar').val()
    $.get("/drinks/#{encodeURIComponent(search)}", (drink) ->
      $('svg').remove()
      window.renderGlass
        slice: true
        components: drink.components
      renderDescription drink
      renderIngredients drink.components
      renderServingGlass drink.glass if drink.glass
    ).fail ->
      $('svg').remove()
      $('#svg-container').html '<br><br><p>No drinks found.</p>'

  $(window).on 'resize', ->
    renderTitle()
    $('svg').remove()
    $('#ingredient-list').remove()
    $('#instructions').text ''
    $('#drink-name').text ''
    window.renderGlass
      slice: false

renderTitle = ->
  if $(window).width() < 700
    $('#logo').css 'font-size', '100px'
  else
    $('#logo').css 'font-size', '140px'

renderDescription = (drink) ->
  $('#drink-name').text drink.name
  $('#instructions').text drink.preparation

renderIngredients = (ingredients) ->
  list = '<ul id="ingredient-list"><h2>Ingredients</h2>'
  for liquor in ingredients
    list += "<li><a href='#{liquor.ingredient.purchase_url}'>#{liquor.ingredient.name}</a> #{liquor.quantity_in_ounces} oz</li>"
  list += '</ul>'
  $('#ingredients-container').html list
  if $(window).width() > 900
    $('#ingredients-container').css
      left: "#{($(window).width() / 2) + 200}px"
      position: 'absolute'
      top: '400px'
    $('#instructions-container').css
      position: 'absolute'
      left: "#{($(window).width() / 2) - 400}px"
      top: '400px'

renderServingGlass = (glass) ->
  $('#glass-image').attr 'src', glass.img_url
  $('#glass-image').attr 'alt', glass.name
  $('#glass-image').css
    height: 20
    width: 20
  $('#glass-name').text glass.name
  $('#glass-link').attr 'href', glass.purchase_url
  $('#glass-container').hide()
  $glass = $('#glass-container').clone()
  $('#ingredient-list :nth-child(2)').prepend $glass.show()
