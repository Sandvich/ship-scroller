extends Sprite
var start
var shot_range
var type
var direction
const fire_directions = {
							"right_up":Vector2(2, -2),
							"left_up":Vector2(-2, -2),
							"right_down":Vector2(2, 2),
							"left_down":Vector2(-2, 2)
}

func set_stuff(created_type, created_shot_range):
	type = created_type
	shot_range = created_shot_range
	set_texture(load("res://assets/sprites/cannonball.png"))
	set_scale(Vector2(0.05, 0.05))
	set_centered(false)

func set_fire(position, ship_facing, side):
	start = position
	set_pos(position)
	if side:
		direction = fire_directions[ship_facing].rotated(PI/2)
	else:
		direction = fire_directions[ship_facing].rotated(-PI/2)

func _ready():
	set_process(true)

func _process(delta):
	translate(direction)

func check_range():
	var distance = start.distance_to(get_pos())
	if distance >= shot_range:
		return true
	else:
		return false
