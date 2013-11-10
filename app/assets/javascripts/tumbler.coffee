$ ->
  s = Snap($(window).width(), 800)
  p = 100 / 30
  h = 250
  x = 400
  y = 200
  R = 100
  r = 70
  open = 0
  gmilk = 'l()#F4EEE6-#fff:50-#F4EEE6:50-#F4EEE6'
  gcoffee = 'l()#60544F-#8c7a73:50-#60544F:50-#60544F'
  gwater = 'l()#B4D6DB-#D6EDEE:50-#B4D6DB:50-#B4D6DB'

  Snap.load 'demo.svg', (f) ->
    top = f.select '#top'
    bot = f.select '#bottom'
    tap = f.select '#tap'
    angle = 0
    grp = s.g().insertBefore tap
    x = $(window).width() / 2
    y = 100
    R = 250
    r = 150
    h = 600
    s.add f.select('g')
    grp.path(outline(0, h)).attr 'class', 'outline'
    o3 = (h - 70) / 3
    o2 = (h - 70) / 2
    cover = grp.ellipse(getEll(h - 60)).attr 'class', 'water'
    ct1 = grp.path(cut(10, 10 + o3, 0)).attr
      fill: gcoffee
    ct2 = grp.path(cut(10 + o3, h - 60, 0)).attr
      fill: gwater
    middle = 10 + o3
    g = grp.g()
    dr = grp.path(doors(0)).attr 'class', 'doors'
    types =
      0: ->
        cover.attr 'class', 'water'
        ct2.attr 'fill', gwater
        middle = 10 + o3
      72: ->
        cover.attr 'class', 'milk'
        ct2.attr 'fill', gmilk
        middle = 10 + o3 * 2

    closeCup = (callback) ->
      Snap.animate 90, 0, (val) ->
        ct1.attr 'path', cut(10, middle, val)
        ct2.attr 'path', cut(middle, h - 60, val)
        dr.attr 'path', doors(val)
      , 500, mina.easein, callback

    pour = ->
      Snap.animate 0, 90, (val) ->
        ct1.attr 'path', cut(10, middle, val)
        ct2.attr 'path', cut(middle, h - 60, val)
        dr.attr 'path', doors(val)
      , 1500, mina.elastic

    types[0]()
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
