window.$                     = require('jquery')
window.requestAnimationFrame = require('raf')
window.THREE                 = require('three')
window.TweenMax              = require('TweenMax')
window.CustomEase            = require('CustomEase')
window.TimelineMax           = require('TimelineMax')
window.isMobile              = require('ismobilejs')

Profiler   = require('./core/Profiler')
MainVisual = require('./MainVisual')

class Main

  constructor: ->


  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    mv = new MainVisual({
      el:$('.visual')
    })
    mv.init()





module.exports = Main


main = new Main()
main.init()
