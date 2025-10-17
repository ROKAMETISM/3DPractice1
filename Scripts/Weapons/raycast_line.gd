extends MeshInstance3D
const LIFE := 0.4
const INITIAL_ALPHA := 0.75
var lifetime := LIFE
func _process(delta: float) -> void:
	lifetime -= delta
	if lifetime < 0:
		queue_free()
	if Engine.get_process_frames()%5!=0:
		return
	if mesh:
		mesh.surface_get_material(0).albedo_color.a = INITIAL_ALPHA * lifetime / LIFE
func update_points(points : Array[Vector3]) : 
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(points[0])
	immediate_mesh.surface_add_vertex(points[1])
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.albedo_color = Color.VIOLET
	mesh = immediate_mesh
