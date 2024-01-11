extends Marker2D
class_name Spawner

@export var visitors_count : int  = 1
@onready var timer :Timer = $Timer

@export var visitor_scene :PackedScene

var visitors_sprite_path:String = "res://assets/images/visitors/"
@onready var texture_array :Array = DirAccess.open(visitors_sprite_path).get_files()
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	#print(DirAccess.open(visitors_sprite_path).get_files())
	spawn_visitor()
	timer.timeout.connect(spawn_visitor)
	#timer.wait_time = 10
	timer.wait_time = randi_range(5,10)
	timer.start()
	
func spawn_visitor()->void:
	var visitor : VisitorCharacter = visitor_scene.instantiate() as VisitorCharacter
	#print_debug("СДЕЛАЙ НОРМАЛЬНЫЙ РАНДОМ")
	visitor.visitor_sprite = load(visitors_sprite_path+(texture_array.pick_random()).trim_suffix(".import"))
	visitor.event_count = randi_range(1,2)
	visitor.global_position = global_position
	visitors_count -=1
	get_parent().add_child(visitor)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
