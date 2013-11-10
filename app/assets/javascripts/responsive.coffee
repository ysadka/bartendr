$ ->
  window.renderGlass
    slice: true

  $(window).on 'resize', ->
    $('svg').remove()
    window.renderGlass
      slice: false

