extends Node2D
class_name FPSSmiler

@export var min_fps:int = 15
@export var max_fps:int = 60
@export var color_gradient:Gradient

@onready var sprite: Sprite2D = $Sprite
@onready var brow_l: Line2D = $BrowL
@onready var brow_r: Line2D = $BrowR
@onready var mouth: Line2D = $Mouth

var curFPS:float
var happyLevel:float = 1.0

func _process(delta: float) -> void:
	curFPS = Engine.get_frames_per_second()
	happyLevel = move_toward(
		happyLevel,
		clamp(
		remap(curFPS,min_fps,max_fps,-1.0,1.0),
		-1, 1.0),
		delta)
	set_color()
	move_brows()
	set_smile()

func move_brows():
	var browAngle:float = happyLevel * 45 + 45
	brow_l.rotation_degrees = -browAngle
	brow_r.rotation_degrees = browAngle

func set_color():
	sprite.modulate = color_gradient.sample(happyLevel)

func set_smile():
	var pointpos:float = 8 * happyLevel
	mouth.points[0].y = -pointpos
	mouth.points[1].y = pointpos
	mouth.points[2].y = pointpos
	mouth.points[3].y = -pointpos
