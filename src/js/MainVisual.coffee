Util    = require('./libs/Util')
Conf    = require('./core/Conf')
Param   = require('./core/Param')
Canvas  = require('./mod/Canvas')
Capture = require('./mod/Capture')
MyMesh  = require('./MyMesh')


class MainVisual extends Canvas

  constructor: (opt) ->

    super(opt)

    @_cap
    @_dest
    @_container
    @_mesh = []
    @_light = []



  # -----------------------------------------------
  # 初期化
  # -----------------------------------------------
  init: =>

    super()

    @camera = @_makeCamera({isOrthographic:false})
    @_updatePerspectiveCamera(@camera)

    @_cap = new Capture()
    @_cap.init()

    @_container = new THREE.Object3D()
    @_cap.add(@_container)
    # @mainScene.add(@_container)

    # 出力用メッシュ
    @_dest = new THREE.Mesh(
      new THREE.PlaneBufferGeometry(1, 1),
      new THREE.ShaderMaterial({
        vertexShader   : require('../shader/Base.vert')
        fragmentShader : require('../shader/MV.frag')
        uniforms:{
          tDiffuse  : {value:@_cap.texture()}
          time   : {value:0}
          brightness   : Param.mv.brightness
          contrastR   : Param.mv.contrastR
          contrastG   : Param.mv.contrastG
          contrastB   : Param.mv.contrastB
          lineScaleR   : Param.mv.lineScaleR
          lineScaleG   : Param.mv.lineScaleG
          lineScaleB   : Param.mv.lineScaleB
          discardAlpha   : Param.mv.discard_alpha
        }
      })
    )
    @mainScene.add(@_dest)

    if Conf.FLG.PARAM
      # Param.mv.light_num.gui.onFinishChange((val) =>
      #   @_resize()
      # )
      #
      # Param.mv.light_pos_range.gui.onFinishChange((val) =>
      #   @_resize()
      # )

      Param.mv.mesh_num.gui.onFinishChange((val) =>
        @_resize()
      )

      Param.mv.mesh_seg.gui.onFinishChange((val) =>
        @_resize()
      )

      Param.mv.mesh_scale_min.gui.onFinishChange((val) =>
        @_resize()
      )

      Param.mv.mesh_scale_max.gui.onFinishChange((val) =>
        @_resize()
      )

      Param.mv.mesh_pos_range.gui.onFinishChange((val) =>
        @_resize()
      )



    @_resize()



  # -----------------------------------------------
  # 更新
  # -----------------------------------------------
  _update: =>

    @_dest.material.uniforms.time.value += 0.01

    if Param.mv.title.value
      $('.ttl').removeClass('hide')
    else
      $('.ttl').addClass('hide')

    for val,i in @_light
      val.power = Param.mv.light_power.value * 0.01
      # val.color = new THREE.Color(Param.mv.lightColor.value)


    for val,i in @_mesh
      val.update()

    @_cap.render(@renderer, @camera)
    @renderer.render(@mainScene, @camera)



  # -----------------------------------------------
  # リサイズ
  # -----------------------------------------------
  _resize: =>

    w = window.innerWidth
    h = window.innerHeight

    @_makeMesh()
    @_makeLight()

    @_dest.scale.set(w, h, 1)

    @_updatePerspectiveCamera(@camera, w, h)

    @renderer.setPixelRatio(window.devicePixelRatio || 1)
    @renderer.setSize(w, h)
    @renderer.clear()

    @_cap.size(w, h)



  # -----------------------------------------------
  #
  # -----------------------------------------------
  _makeMesh: =>

    # まず破棄
    for val,i in @_mesh
      @_container.remove(val)
      val.geometry.dispose()
      val.material.dispose()
    @_mesh = []

    w = window.innerWidth
    h = window.innerHeight

    i = 0
    num = ~~(Param.mv.mesh_num.value)
    while i < num

      mesh = new MyMesh(0xffffff, 0x000000, ~~(Param.mv.mesh_seg.value))

      scale = Math.min(w, h) * Util.random(Param.mv.mesh_scale_min.value * 0.01, Param.mv.mesh_scale_max.value * 0.01)
      mesh.scale.set(scale, scale, scale)

      r = Param.mv.mesh_pos_range.value * 0.01
      mesh.basePosition.set(
        w * Util.range(r),
        h * Util.range(r),
        0
      )

      @_mesh.push(mesh)
      @_container.add(mesh)

      i++


  # -----------------------------------------------
  #
  # -----------------------------------------------
  _makeLight: =>

    # まず破棄
    for val,i in @_light
      @_cap.remove(val)
    @_light = []

    w = window.innerWidth * 2
    h = window.innerHeight * 2

    x = [1, -2, 3, -4, 5]
    y = [1, -2, 3, -4, 5]
    z = [1, -2, 3, -4, 5]

    i = 0
    num = 5
    while i < num

      light = new THREE.PointLight(0xffffff, 1, 0)

      r = 5
      light.position.set(
        w * x[i] * -1,
        h * y[i],
        w * z[i] * 2
      )

      @_light.push(light)
      @_cap.add(light)

      i++







module.exports = MainVisual
