extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
const grav_const = 6.673 * pow(10, -11) # I have no idea if Godot can handle floats this small
const black_hole_mass = 100 # Adjust to taste

export (NodePath) var path_black_hole
onready var black_hole = get_node(path_black_hole)

func _physics_process(delta):
    var distance = black_hole.distance_to_(self)
    var force_amount = (grav_const * self.mass * black_hole_mass) / pow(distance, 2)
    var direction = (black_hole.translation- self.translation).normalized()
    var force = direction * force_amount
    add_central_force(force)