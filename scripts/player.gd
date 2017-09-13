extends Sprite

const spriteSheet = {
					"right_down":Rect2(Vector2(140, 0), Vector2(110,110)),
					"right_up":Rect2(Vector2(262,2), Vector2(110,110)),
					"left_up":Rect2(Vector2(395,2), Vector2(110,110)),
					"left_down":Rect2(Vector2(5,0), Vector2(110,110))
}
var facing = "right_down"
var cannonball = load("res://scripts/shot.gd")
var cooldown

func move(direction):
	# This should only ever be passed "ui_" + a direction.
	if direction.is_action_pressed("ui_up"):
		translate(Vector2(1,-1))
		if facing != "right_up":
			set_region_rect(spriteSheet["right_up"])
			facing = "right_up"
	elif direction.is_action_pressed("ui_down"):
		translate(Vector2(-1,1))
		if facing != "left_down":
			set_region_rect(spriteSheet["left_down"])
			facing = "left_down"
	elif direction.is_action_pressed("ui_left"):
		translate(Vector2(-1,-1))
		if facing != "left_up":
			set_region_rect(spriteSheet["left_up"])
			facing = "left_up"
	else:
		translate(Vector2(1,1))
		if facing != "right_down":
			set_region_rect(spriteSheet["right_down"])
			facing = "right_down"

func shoot(side):	
	if int(cooldown.get_time_left()) == 0:
		var shot = cannonball.new()
		shot.set_stuff("solid", 200)
		shot.set_fire(get_pos(), facing, side.is_action_pressed("fire_left"))
		self.add_child(shot)
		cooldown.set_wait_time(2)
		cooldown.start()

func _process(delta):
	# Check the cannonballs to see if they've hit their maximum range, and if so delete them
	for ball in self.get_children():
		if ball.check_range():
			ball.queue_free()
	
	# If event is a direction, move in that direction
	if (Input.is_action_pressed("ui_up")) or (Input.is_action_pressed("ui_right")) or \
			(Input.is_action_pressed("ui_down")) or (Input.is_action_pressed("ui_left")):
		move(Input)
	# If it's a fire action, fire a cannonball
	if (Input.is_action_pressed("shoot_left")) or (Input.is_action_pressed("shoot_right")):
		shoot(Input)
	# If it's cancel, return to the menu
	elif Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/menu.tscn")
	# Otherwise we don't have this key mapped to anything, so ignore it.
	else:
		pass

func _ready():
	cooldown = get_node("../cooldown")
	cooldown.set_one_shot(true)
	cooldown.set_active(true)
	set_process(true)
