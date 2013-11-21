$ ->
  if $('#search-bar').length > 0
    renderTitle()
    window.renderGlass
      slice: true

    $('form').on 'submit', (e) ->
      e.preventDefault()
      $('body').load '/'
      search = $('#search-bar').val()
      $.get("/drinks/#{encodeURIComponent(search)}", (drink) ->
        $('#svg-container').load '/ #svg-container', ->
          $('svg').remove()
          window.renderGlass
            slice: true
            components: drink.components
          renderDescription drink
          renderIngredients drink.components.reverse()
          renderServingGlass drink.glass if drink.glass
      ).fail ->
        $('svg').remove()
        $('#ingredient-list').remove()
        $('#instructions').text ''
        $('#drink-name').text ''
        $('.remove').text ''
        $('#svg-container').html '<br><br><p>No drinks found.</p>'

    $(window).on 'resize', ->
      renderTitle()
      $('svg').remove()
      $('#ingredient-list').remove()
      $('#instructions').text ''
      $('#drink-name').text ''
      $('.remove').text ''
      window.renderGlass
        slice: false

renderTitle = ->
  if $(window).width() < 700
    $('#logo').css 'font-size', '100px'
  else
    $('#logo').css 'font-size', '140px'

renderDescription = (drink) ->
  $('#drink-name').text drink.name
  if $('#tipjar').length > 0
    $('#instructions').html drink.preparation +
      '<br><br><a href="/payments/new">Thanks, bartendr!</a>'
  else
    $('#instructions').html drink.preparation

renderIngredients = (ingredients) ->
  list = '<h2 class="remove">Ingredients</h2><ul id="ingredient-list">'
  for liquor in ingredients
    list += "<li><div id='swatch' style='background-color:##{liquor.ingredient.color.hex_code}'></div> <a href='#{liquor.ingredient.purchase_url}' target='_blank'>#{liquor.ingredient.name}</a> #{liquor.quantity_in_ounces} oz</li>"
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
  $('#glass-link').attr 'target', '_blank'
  $('#glass-container').hide()
  $glass = $('#glass-container').clone()
  $('#ingredient-list').prepend $glass.show()
