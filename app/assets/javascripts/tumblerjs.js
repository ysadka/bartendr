// window.onload = function () {
//   var s = Snap(),
//       p = 100 / 30,
//       h = 250,
//       x = 400,
//       y = 200,
//       R = 100,
//       r = 70,
//       open = 0,
//       gstream,
//       gmilk = "l()#F4EEE6-#fff:50-#F4EEE6:50-#F4EEE6",
//       gcoffee = "l()#60544F-#8c7a73:50-#60544F:50-#60544F",
//       gwater = "l()#B4D6DB-#D6EDEE:50-#B4D6DB:50-#B4D6DB";

//   Snap.load('demo.svg', function (f) {
//       var top = f.select("#top"),
//           bot = f.select("#bottom"),
//           tap = f.select("#tap"),
//           // pie = {
//           //     cx: f.select("#pie-chart circle").attr("cx"),
//           //     cy: f.select("#pie-chart circle").attr("cy"),
//           //     r: f.select("#pie-chart circle").attr("r"),
//           //     coffee: f.select("#legend text"),
//           //     water: f.selectAll("#legend text")[1],
//           //     title: f.selectAll("#legend text")[2],
//           //     waterBox: f.select("#legend rect:nth-child(2)")
//           // },
//           angle = 0,
//           lastAngle,
//           startAngle,
//           closed,
//           grp = s.g().insertBefore(tap);
//       // f.select("#pie-chart").remove();
//     //  f.select("#americano-area").click(//function () {
//     //      chosen(0);
//     //  });
//     //  f.select("#latte-area").click(function () //{
//     //      chosen(72);
//     //  });
//     //  f.select("#mocha-area").click(function () //{
//     //      chosen(144);
//     //  });
//     //  f.select("#mochiatto-area").click(//function () {
//     //      chosen(216);
//     //  });
//     //  f.select("#espresso-area").click(//function() {
//     //      chosen(288);
//     //  });
//       x = $(window).width() / 2;
//       y = $(window).height() / 3;
//       R = $(window).width() / 10;
//       r = $(window).width() / 15;
//       h = $(window).height() / 2.5;
//       s.add(f.select("g"));
//       grp.path(outline(0, h)).attr("class", "outline");
//       var o3 = (h - 70) / 3,
//           o2 = (h - 70) / 2,
//           cover = grp.ellipse(getEll(h - 60)).attr("class", "water"),
//           ct1 = grp.path(cut(10, 10 + o3, 0)).attr({
//               fill: gcoffee
//           }),
//           ct2 = grp.path(cut(10 + o3, h - 60, 0)).attr({
//               fill: gwater
//           }),
//           middle = 10 + o3,
//           pieCoffee,
//           pieTitle,
//           pieType,
//           g = grp.g(),
//           dr = grp.path(doors(0)).attr("class", "doors"),
//           types = {
//               // americano
//               0: function () {
//                   cover.attr("class", "water");
//                   ct2.attr("fill", gwater);
//                   middle = 10 + o3;
//                   // pieCoffee = 1 / 3;
//                   // pieType = "water";
//                   // pieTitle = "Americano";
//                   // gstream = "l(0,1,0,0)#60544F-#60544F:33-#B4D6DB";
//               },
//               // latté
//               72: function () {
//                   cover.attr("class", "milk");
//                   ct2.attr("fill", gmilk);
//                   middle = 10 + o3 * 2;
//                   pieCoffee = 2 / 3;
//                   pieType = "milk";
//                   pieTitle = "Latté";
//                   gstream = "l(0,1,0,0)#60544F-#60544F:66-#fff";
//               },
//               // mocha
//               144: function () {
//                   cover.attr("class", "milk");
//                   ct2.attr("fill", gmilk);
//                   middle = 10 + o3;
//                   pieCoffee = 1 / 3;
//                   pieType = "milk";
//                   pieTitle = "Mocha";
//                   gstream = "l(0,1,0,0)#60544F-#60544F:33-#fff";
//               },
//               // machiatto
//               216: function () {
//                   cover.attr("class", "milk");
//                   ct2.attr("fill", gmilk);
//                   middle = 10 + o2;
//                   pieCoffee = 1 / 2;
//                   pieType = "milk";
//                   pieTitle = "Machiatto";
//                   gstream = "l(0,1,0,0)#60544F-#60544F:50-#fff";
//               },
//               // espresso
//               288: function () {
//                   cover.attr("class", "coffee");
//                   ct2.attr("fill", gcoffee);
//                   middle = 10;
//                   pieCoffee = 1;
//                   pieType = "milk";
//                   pieTitle = "Espresso";
//                   gstream = "#60544F";
//               }
//           };
//       function closeCup(callback) {
//           Snap.animate(90, 0, function (val) {
//               ct1.attr("path", cut(10, middle, val));
//               ct2.attr("path", cut(middle, h - 60, val));
//               dr.attr("path", doors(val));
//           }, 500, mina.easein, callback);
//       }
//       function pour() {
//         Snap.animate(0, 90, function (val) {
//           ct1.attr("path", cut(10, middle, val));
//           ct2.attr("path", cut(middle, h - 60, val));
//           dr.attr("path", doors(val));
//         }, 1500, mina.elastic);
//       }
//       // var pieShow = (function () {
//       //     var disc = s.circle(pie.cx, pie.cy, pie.r).attr({
//       //         fill: "#fff",
//       //         stroke: "#60544F"
//       //     }),
//       //     coffee = s.path().attr({
//       //         stroke: "#60544F",
//       //         strokeWidth: pie.r,
//       //         fill: "none"
//       //     }),
//       //     olda = 0,
//       //     a;
//       //     return function () {
//       //         var cof = pieCoffee,
//       //             type = pieType;
//       //         a = 360 * cof / 2;
//       //         pie.waterBox.attr({
//       //             fill: type == "water" ? "#d6edee" : "#fff"
//       //         });
//       //         disc.attr({
//       //             fill: type == "water" ? "#d6edee" : "#fff"
//       //         });
//       //         pie.title.attr({
//       //             "#text": pieTitle
//       //         });
//       //         pie.coffee.attr({
//       //             "#text": "Espresso (" + Math.round(cof * 100) + "%)"
//       //         });
//       //         pie.water.attr({
//       //             "#text": (type == "water" ? "Hot Water" : "Milk") + " (" + (100 - Math.round(cof * 100)) + "%)"
//       //         });
//       //         Snap.animate(olda, a, function (val) {
//       //             coffee.attr({
//       //                 d: "M" + [pie.cx, pie.cy] +
//       //                    "U" + [pie.r / 2, 90 - val, 90 + val]
//       //             });
//       //         }, 500, function () {
//       //             if (cof == 1) {
//       //                 disc.attr({
//       //                     fill: "#60544F"
//       //                 });
//       //             }
//       //         });
//       //         olda = a;
//       //     };
//       // }());

//       types[0]();
//       pour();
//       // pieShow();
//   });


//   function getEll(height) {
//       var ra = r + (R - r) / h * height;
//       return {
//           cx: x,
//           cy: y + h - height,
//           rx: ra,
//           ry: ra / p
//       };
//   }
//   function arc(cx, cy, R, r, from, to, command) {
//       var start = pointAtAngle(cx, cy, R, r, from),
//           end = pointAtAngle(cx, cy, R, r, to);
//       command = command || "M";
//       return command + Snap.format("{sx},{sy}A{R},{r},0,{big},{way},{tx},{ty}", {
//           sx: start.x,
//           sy: start.y,
//           R: R,
//           r: r,
//           tx: end.x,
//           ty: end.y,
//           big: +(Math.abs(to - from) > 180),
//           way: +(from > to)
//       });
//   }
//   function pointAtAngle(cx, cy, rx, ry, angle) {
//       angle = Snap.rad(angle);
//       return {
//           x: cx + rx * Math.cos(angle),
//           y: cy - ry * Math.sin(angle)
//       };
//   }
//   function doors(alpha) {
//       var sa = 270 - alpha / 2,
//           ea = 270 + alpha / 2;
//       if (alpha) {
//           return arc(x, y, R, R / p, 180, sa) + arc(x, y + h, r, r / p, sa, 180, "L") + "z" +
//                  arc(x, y, R, R / p, ea, 360) + arc(x, y + h, r, r / p, 360, ea, "L") + "z";
//       } else {
//           return arc(x, y, R, R / p, 180, 360) + arc(x, y + h, r, r / p, 360, 180, "L") + "z";
//       }
//   }
//   function fill(from, to) {
//       var start = getEll(from),
//           end = getEll(to);
//       return "M" + (start.cx - start.rx) + "," + start.cy + "h" + start.rx * 2 +
//              arc(end.cx, end.cy, end.rx, end.ry, 0, 180, "L") + "z";
//   }
//   function outline(from, to) {
//       var start = getEll(from),
//           end = getEll(to);
//       return arc(start.cx, start.cy, start.rx, start.ry, 180, 0) +
//              arc(end.cx, end.cy, end.rx, end.ry, 0, 180, "L") + "z";
//   }
//   function cut(from, to, alpha) {
//       var s = getEll(from),
//           e = getEll(to),
//           sa = Snap.rad(270 - alpha / 2),
//           ea = Snap.rad(270 + alpha / 2);
//       return "M" + [s.cx, s.cy,
//           s.cx + s.rx * Math.cos(ea), s.cy - s.ry * Math.sin(ea),
//           e.cx + e.rx * Math.cos(ea), e.cy - e.ry * Math.sin(ea),
//           e.cx, e.cy,
//           e.cx + e.rx * Math.cos(sa), e.cy - e.ry * Math.sin(sa),
//           s.cx + s.rx * Math.cos(sa), s.cy - s.ry * Math.sin(sa)
//       ] + "z";
//   }
// };
