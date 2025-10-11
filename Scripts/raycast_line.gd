extends MeshInstance3D
const life := 5.0
var lifetime := life
func _process(delta: float) -> void:
	lifetime -= delta
	var material : Material = mesh.surface_get_material(0)
	material.albedo_color.a = lifetime / life
	if lifetime < 0:
		queue_free()
func update_points(points : Array[Vector3]) : 
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(points[0])
	immediate_mesh.surface_add_vertex(points[1])
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.VIOLET
	mesh = immediate_mesh
