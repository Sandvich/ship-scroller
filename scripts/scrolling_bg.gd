extends Sprite

var speed = 0.2
var count = 0.0

func _ready():
	set_process(true)

func _process(delta):
	var region_rect = get_region_rect()
	set_region_rect(Rect2(region_rect.pos - Vector2(-speed, 0), region_rect.size))
