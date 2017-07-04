
class Capture extends THREE.Scene

  constructor: ->

    super()

    @_texture



  # -----------------------------------
  # 初期化
  # -----------------------------------
  init: =>

    @_texture = new THREE.WebGLRenderTarget(16, 16)


  # -----------------------------------
  # テクスチャ
  # -----------------------------------
  texture: =>

    return @_texture.texture



  # -----------------------------------
  # テクスチャにレンダリング
  # -----------------------------------
  render: (renderer, camera) =>

    renderer.render(@, camera, @_texture)



  # -----------------------------------
  # レンダリング先テクスチャのサイズ設定
  # -----------------------------------
  size: (width, height) =>

    ratio = window.devicePixelRatio || 1
    @_texture.setSize(width * ratio, height * ratio)





module.exports = Capture
