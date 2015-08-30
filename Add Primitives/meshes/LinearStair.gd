extends "builder/MeshBuilder.gd"

var steps = 10
var width = 1.0
var height = 2.0
var length = 2.0
var fill_end = true
var fill_bottom = true

static func get_name():
	return "Linear Stair"
	
static func get_container():
	return "Add Stair"
	
func set_parameter(name, value):
	if name == 'Steps':
		steps = value
		
	elif name == 'Width':
		width = value
		
	elif name == 'Height':
		height = value
		
	elif name == 'Length':
		length = value
		
	elif name == 'Fill End':
		fill_end = value
		
	elif name == 'Fill Bottom':
		fill_bottom = value
		
func create(smooth, invert):
	var sh = height/steps
	var sl = length/steps
	
	begin(VS.PRIMITIVE_TRIANGLES)
	
	set_invert(invert)
	add_smooth_group(smooth)
	
	for i in range(steps):
		add_quad(build_plane_verts(Vector3(0, 0, sl), Vector3(width, 0, 0), Vector3(0, (i+1) * sh, i * sl)))
		add_quad(build_plane_verts(Vector3(0, sh, 0), Vector3(width, 0, 0), Vector3(0, i * sh, i * sl)))
		add_quad(build_plane_verts(Vector3(0, 0, sl), Vector3(0, (i+1)*sh, 0), Vector3(0, 0, i * sl)))
		add_quad(build_plane_verts(Vector3(0, (i+1)*sh, 0), Vector3(0, 0, sl), Vector3(width, 0, i * sl)))
		
	if fill_end:
		add_quad(build_plane_verts(Vector3(width, 0, 0), Vector3(0, steps * sh, 0), Vector3(0, 0, steps * sl)))
		
	if fill_bottom:
		add_quad(build_plane_verts(Vector3(width, 0, 0), Vector3(0, 0, steps * sl)))
		
	var mesh = commit()
	
	return mesh
	
func mesh_parameters(tree):
	add_tree_range(tree, 'Steps', steps, 1, 1, 64)
	add_tree_range(tree, 'Width', width)
	add_tree_range(tree, 'Height', height)
	add_tree_range(tree, 'Length', length)
	add_tree_empty(tree)
	add_tree_check(tree, 'Fill End', fill_end)
	add_tree_check(tree, 'Fill Bottom', fill_bottom)

