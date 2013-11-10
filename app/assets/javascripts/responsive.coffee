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
    ).fail ->
      $('svg').remove()
      $('#svg-container').html '<br><br><p>No drinks found.</p>'

  $(window).on 'resize', ->
    renderTitle()
    $('svg').remove()
    $('#ingredient-list').remove()
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

renderIngredients = (ingredients) ->
  list = '<ul id="ingredient-list"><h2>Ingredients</h2>'
  for liquor in ingredients
    list += "<li>#{liquor.ingredient.name} #{liquor.quantity_in_ounces} oz</li>"
  list += '</ul>'
  $('#ingredients-container').html list
  if $(window).width() > 700
    $('#ingredients-container').css
      left: "#{$(window).width() * 0.70}px"
      position: 'absolute'
      bottom: '200px'
