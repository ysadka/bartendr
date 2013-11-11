window.renderGlass = (options) ->
  s = Snap($(window).width(), 400)
  $('svg').appendTo '#svg-container'
  p = 100 / 30
  h = 250
  x = 400
  y = 200
  R = 100
  r = 70
  open = 0

  lighterHex = (num) ->
    switch num
      when num then Math.round(num * 1.05).toString 16
      else Math.round(num * 1.1).toString 16

  lighten = (color) ->
    result = []
    for hue in color
      integer = parseInt "0x#{hue}", 16
      result.push lighterHex(integer)
    result.join ''

  setGradients = (components) ->
    svgGradients = []
    for component in components
      color = component.ingredient.hex_color
      rgb = color.match /.{2}/g
      svgGradients.push "l()##{color}-##{lighten rgb}:50-##{color}:50-##{color}"
    svgGradients

  if options.components
    gradients = setGradients(options.components)
    top_layer = options.components[options.components.length - 1]

  Snap.load 'demo.svg', (f) ->
    top = f.select '#top'
    bot = f.select '#bottom'
    tap = f.select '#tap'
    angle = 0
    grp = s.g().insertBefore tap
    x = $(window).width() / 2
    y = 75
    R = 120
    r = 92
    h = 280
    s.add f.select('g')
    grp.path(outline(0, h)).attr 'class', 'outline'
    cover = grp.ellipse(getEll(h - 60)).attr 'class', 'water'


    ohs = []
    cuts = []
    calculateLayers = (ingredients) ->
      numberOfIngredients = ingredients.length
      totalOunces = _.reduce ingredients, (memo, ingredient)-> 
        memo + ingredient.quantity_in_ounces
      , 0   
      
      for ingredient, index in ingredients
        portionOfTotal = ingredient.quantity_in_ounces / totalOunces
        ohs.push (h - 70) * portionOfTotal

        previousOh = ohs[index - 1] or 0
        cuts.push grp.path(cut(10 + previousOh, 10 + ohs[index], 0)).attr
          fill: gradients[index]

    calculateLayers options.components if options.components

    g = grp.g()
    dr = grp.path(doors(0)).attr 'class', 'doors'
    types =
      0: ->
        cover.attr 'class', 'water'
        for index in [0...cuts.length]
          cuts[index].attr 'fill', gradients[index]
  
    closeCup = (callback) ->
      Snap.animate 90, 0, (val) ->
        cuts[0].attr 'path', cut(10, middle, val)
        cuts[1].attr 'path', cut(middle, h - 60, val)
        dr.attr 'path', doors(val)
      , 500, mina.easein, callback

    pour = ->
      Snap.animate 0, 90, (val) ->
        last = ohs.length
        total = 0
        for oh,index in ohs
          if index is 0
            cuts[index].attr 'path', cut(10, ohs[index], val)
            total = total + ohs[index]
          else if index is last-1
            cuts[index].attr 'path', cut(total, h - 60, val)
          else
            cuts[index].attr 'path', cut(total, total+ohs[index], val)
            total = total + ohs[index]
        dr.attr 'path', doors(val)
      , 1500, mina.elastic

    if options.slice is true
      types[0]()
      $('.water').css 'opacity', 1
      $('.water').attr 'fill', "##{top_layer.ingredient.hex_color}"
      pour()


  getEll = (height) ->
    ra = r + (R - r) / h * height
    cx: x
    cy: y + h - height
    rx: ra
    ry: ra / p

  arc = (cx, cy, R, r, from, to, command) ->
    start = pointAtAngle(cx, cy, R, r, from)
    end = pointAtAngle(cx, cy, R, r, to)
    command = command || 'M'
    command + Snap.format "{sx},{sy}A{R},{r},0,{big},{way},{tx},{ty}",
      sx: start.x
      sy: start.y
      R: R
      r: r
      tx: end.x
      ty: end.y
      big: +(Math.abs(to - from) > 180)
      way: +(from > to)

  pointAtAngle = (cx, cy, rx, ry, angle) ->
    angle = Snap.rad angle
    x: cx + rx * Math.cos(angle)
    y: cy - ry * Math.sin(angle)

  doors = (alpha) ->
    sa = 270 - alpha / 2
    ea = 270 + alpha / 2
    if alpha
      arc(x, y, R, R / p, 180, sa) +
      arc(x, y + h, r, r / p, sa, 180, 'L') +
      'z' +
      arc(x, y, R, R / p, ea, 360) +
      arc(x, y + h, r, r / p, 360, ea, 'L') + 'z'
    else
      arc(x, y, R, R / p, 180, 360) +
      arc(x, y + h, r, r / p, 360, 180, 'L') + 'z'

  fill = (from, to) ->
    start = getEll from
    end = getEll to
    'M' + (start.cx - start.rx) + ',' + start.cy + 'h' + start.rx * 2 +
      arc(end.cx, end.cy, end.rx, end.ry, 0, 180, 'L') + 'z'

  outline = (from, to) ->
    start = getEll from
    end = getEll to
    arc(start.cx, start.cy, start.rx, start.ry, 180, 0) +
      arc(end.cx, end.cy, end.rx, end.ry, 0, 180, 'L') + 'z'

  cut = (from, to, alpha) ->
    s = getEll from
    e = getEll to
    sa = Snap.rad 270 - alpha / 2
    ea = Snap.rad 270 + alpha / 2
    'M' + [
      s.cx
      s.cy
      s.cx + s.rx * Math.cos(ea)
      s.cy - s.ry * Math.sin(ea)
      e.cx + e.rx * Math.cos(ea)
      e.cy - e.ry * Math.sin(ea)
      e.cx
      e.cy
      e.cx + e.rx * Math.cos(sa)
      e.cy - e.ry * Math.sin(sa)
      s.cx + s.rx * Math.cos(sa)
      s.cy - s.ry * Math.sin(sa)
    ] + 'z'
