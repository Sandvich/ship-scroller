extends Sprite

const spriteSheet = {
					"right_down":Rect2(Vector2(140, 0), Vector2(110,110)),
					"right_up":Rect2(Vector2(262,2), Vector2(110,110)),
					"left_up":Rect2(Vector2(395,2), Vector2(110,110)),
					"left_down":Rect2(Vector2(5,0), Vector2(110,110))
}
var facing = "right_down"

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

func _process(delta):
	# If event is a direction, move in that direction
	if (Input.is_action_pressed("ui_up")) or (Input.is_action_pressed("ui_right")) or \
			(Input.is_action_pressed("ui_down")) or (Input.is_action_pressed("ui_left")):
		move(Input)
	# If it's cancel, return to the menu
	elif Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/menu.tscn")
	# Otherwise we don't have this key mapped to anything, so ignore it.
	else:
		pass

func _ready():
	set_process(true)
