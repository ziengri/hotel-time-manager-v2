extends Marker2D
class_name Spawner

@export var visitors_count : int  = 1
@onready var timer :Timer = $Timer
@export var visitor_scene :PackedScene
var visitors_sprite_path:String = "res://assets/images/visitors/"
@onready var texture_array :Array = DirAccess.open(visitors_sprite_path).get_files()


var bodies :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/bodies/"))
var outfits :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/outfits/"))
var hairs :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/hairs/"))
var eyes :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/eyes/"))

# Called when the node enters the scene tree for the first time.
func _ready()->void:
	
	#print(DirAccess.open(visitors_sprite_path).get_files())


	timer.timeout.connect(spawn_visitor)
	#timer.wait_time = 10
	timer.wait_time = randi_range(1,3)
	timer.start()
	
func spawn_visitor()->void:
	if(visitors_count>0):
		print("SPAWN VISITOR")
		var visitor : VisitorCharacter = visitor_scene.instantiate() as VisitorCharacter
		#print_debug("СДЕЛАЙ НОРМАЛЬНЫЙ РАНДОМ")
		#visitor.visitor_sprite = load(visitors_sprite_path+(texture_array.pick_random()).trim_suffix(".import"))
		visitor.event_count = randi_range(1,2)
		visitor.global_position = global_position
		visitors_count -=1
		Rel.world.add_child(visitor)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func filter_paths(unfiltered_paths:Array)->Array:
	var filtered_paths :Array = []

	for i in range(0,unfiltered_paths.size()):
		if unfiltered_paths[i].rfind(".import")==-1:
			filtered_paths.append(unfiltered_paths[i])
	
	return filtered_paths
	