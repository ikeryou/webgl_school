Param = require('./core/Param')
Conf  = require('./core/Conf')
Util  = require('./libs/Util')


class MyMesh extends THREE.Mesh


  constructor: (color, emissive, seg) ->

    super(
      # new THREE.BoxBufferGeometry(1, 1, 1, seg, seg, seg),
      new THREE.SphereBufferGeometry(1, seg, seg),
      new THREE.MeshPhongMaterial({
        color       : color
        emissive    : emissive
        side        : THREE.DoubleSide
        shading     : THREE.FlatShading
        transparent : true
        # alphaTest   : 0.2
      })
    )

    @_rotation = new THREE.Vector3(
      Util.range(1),
      Util.range(1),
      Util.range(1)
    )

    @_time = Util.random(0, 360)
    @basePosition = new THREE.Vector3()



  # -----------------------------------------------
  # 更新
  # -----------------------------------------------
  update: =>

    @material.opacity = Param.mv.mesh_opacity.value * 0.01

    #@material.color = new THREE.Color(Param.mv.lightColor.value)

    speed = Param.mv.speed.value * 0.001

    @rotation.x += @_rotation.x * speed
    @rotation.y += @_rotation.y * speed
    @rotation.z += @_rotation.z * speed

    @_time += speed
    range = Math.min(window.innerWidth, window.innerHeight) * Param.mv.mesh_move_range.value * 0.01
    @position.x = @basePosition.x + Math.sin(@_time) * Param.mv.mesh_move_x.value * 0.01 * range
    @position.y = @basePosition.y + Math.cos(@_time * 0.91) * Param.mv.mesh_move_y.value * 0.01 * range
    @position.z = @basePosition.z + Math.sin(@_time * 0.82) * Param.mv.mesh_move_z.value * 0.01 * range

    @position.x += Math.cos(@_time * 0.91) * Param.mv.mesh_move_x2.value * 0.01 * range
    @position.y += Math.sin(@_time * 1.11) * Param.mv.mesh_move_y2.value * 0.01 * range
    @position.z += Math.cos(@_time * 0.88) * Param.mv.mesh_move_z2.value * 0.01 * range








module.exports = MyMesh
