extends Node2D

@export var gap_size: float = 50
@export var max_height: float = 200

@export_category("Internal Nodes")

@export var top_area: Area2D
@export var bottom_area: Area2D
@export var top_collision_shape: CollisionShape2D
@export var bottom_collision_shape: CollisionShape2D

func _ready():
	var gap_start_position = _get_gap_start_position()
	_setup_top_obsticle(gap_start_position)
	
	var gap_end_position = gap_start_position + gap_size
	var bottom_obsticle_height = max_height - gap_end_position
	_setup_bottom_obsticle(bottom_obsticle_height)
	

func _process(delta):
	position.x -= 100 * delta

func _get_gap_start_position() -> float:
	var start = 0.0
	var end = max_height - gap_size
	var rng = RandomNumberGenerator.new()
	return rng.randf_range(start, end)
	

func _setup_top_obsticle(height: float) -> void:
	top_area.body_entered.connect(_on_area_entered)
	
	# Setup collision shape:
	top_collision_shape.shape = _create_new_shape(height)
	var y_offset_position = height * 0.5
	top_area.position = Vector2(0, y_offset_position)
	

func _setup_bottom_obsticle(height: float) -> void:
	bottom_area.body_entered.connect(_on_area_entered)
	
	# Setup collision shape:
	bottom_collision_shape.shape = _create_new_shape(height)
	var y_offset_position = max_height - (height * 0.5)
	bottom_area.position = Vector2(0, y_offset_position)
	

func _create_new_shape(height: float) -> RectangleShape2D:
	var new_shape = RectangleShape2D.new()
	new_shape.size.x = 20
	new_shape.size.y = height
	return new_shape

func _on_area_entered(body: Node2D):
	print("Game Over")
	GameEvents.player_touched_obsticle.emit()
