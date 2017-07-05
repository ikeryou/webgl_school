dat  = require('dat-gui')
Conf = require('./Conf')


# ---------------------------------------------------
# 可変パラメータ
# ---------------------------------------------------
class Param

  constructor: ->

    @_gui

    # メインビジュアル用パラメータ
    @mv = {
      speed:{value:20, min:1, max:100}
      light_num:{value:5, min:1, max:10}
      light_pos_range:{value:50, min:1, max:100}
      mesh_num:{value:10, min:1, max:100}
      mesh_seg:{value:16, min:1, max:128}
      mesh_scale_min:{value:20, min:1, max:100}
      mesh_scale_max:{value:30, min:1, max:100}
      mesh_pos_range:{value:50, min:1, max:100}
      mesh_opacity:{value:100, min:1, max:100}
      mesh_move_range:{value:0, min:0, max:100}
      mesh_move_x:{value:0, min:0, max:100}
      mesh_move_y:{value:0, min:0, max:100}
      mesh_move_z:{value:0, min:0, max:100}
      mesh_move_x2:{value:0, min:0, max:100}
      mesh_move_y2:{value:0, min:0, max:100}
      mesh_move_z2:{value:0, min:0, max:100}
      light_power:{value:700, min:1, max:1000}
      brightness:{value:0, min:-200, max:200}
      contrastR:{value:0, min:0, max:100}
      contrastG:{value:0, min:0, max:100}
      contrastB:{value:0, min:0, max:100}
      lineScaleR:{value:0, min:0, max:50}
      lineScaleG:{value:0, min:0, max:50}
      lineScaleB:{value:0, min:0, max:50}
      discard_alpha:{value:0, min:0, max:100}
      title:{value:false}
    }

    @_init()



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  _init: =>

    if location.href.indexOf('a=1') > 0
      @mv.mesh_num.value = 30
      @mv.mesh_seg.value = 64
      @mv.mesh_scale_min.value = 15
      @mv.mesh_scale_max.value = 15
      @mv.mesh_pos_range.value = 1
      @mv.mesh_move_range.value = 100
      @mv.mesh_move_x.value = 10
      @mv.mesh_move_y.value = 13
      @mv.mesh_move_z.value = 18
      @mv.mesh_move_x2.value = 20
      @mv.mesh_move_y2.value = 22
      @mv.mesh_move_z2.value = 28
      @mv.light_power.value = 333
      @mv.brightness.value = 13
      @mv.contrastR.value = 100
      @mv.contrastG.value = 78
      @mv.lineScaleR.value = 2
      @mv.title.value = true

    if location.href.indexOf('b=1') > 0
      @mv.mesh_num.value = 25
      @mv.mesh_seg.value = 1
      @mv.mesh_num.value = 100
      @mv.mesh_scale_min.value = 20
      @mv.mesh_scale_max.value = 30
      @mv.mesh_pos_range.value = 1
      @mv.mesh_opacity.value = 9
      @mv.mesh_move_range.value = 42
      @mv.mesh_move_z.value = 100
      @mv.mesh_move_z2.value = 100
      @mv.light_power.value = 565
      @mv.brightness.value = -40
      @mv.contrastR.value = 100
      @mv.contrastG.value = 55
      @mv.contrastB.value = 100
      @mv.lineScaleG.value = 50
      @mv.lineScaleB.value = 50
      @mv.discard_alpha.value = 33
      @mv.title.value = true

    if !Conf.FLG.PARAM
      return

    @_gui = new dat.GUI()
    @_addGui(@mv)

    $('.dg').css('zIndex', 99999999)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _addGui: (obj) =>

    for key,val of obj
      if !val.flg?
        if key.indexOf('Color') > 0
          g = @_gui.addColor(val, 'value').name(key)
        else
          if val.list?
            g = @_gui.add(val, 'value', val.list).name(key)
          else
            g = @_gui.add(val, 'value', val.min, val.max).name(key)
        val.gui = g



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _addGuiListen: (obj) =>

    for key,val of obj
      @_gui.add(val, 'value').name(key).listen()









module.exports = new Param()
