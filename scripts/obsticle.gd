extends Node2D

# TODO: Make this a range
@export var gap_size: float = 250
@export var max_height: float = 648
@export var width: float = 100
@export var speed: float = 100

@export_category("Internal Nodes")

@export var top_area: Area2D
@export var bottom_area: Area2D
@export var score_area: Area2D

@export var top_collision_shape: CollisionShape2D
@export var bottom_collision_shape: CollisionShape2D
@export var score_collision_shape: CollisionShape2D

# JUST FOR TESTING
var _initial_position: Vector2

func _ready():
	_initial_position = self.position
	
	top_area.body_entered.connect(_on_body_entered_obsticle)
	top_area.area_entered.connect(_on_area_entered_obsticle)
	bottom_area.body_entered.connect(_on_body_entered_obsticle)
	score_area.body_entered.connect(_on_body_entered_score)
	
	top_collision_shape.shape = _create_new_shape()
	bottom_collision_shape.shape = _create_new_shape()
	score_collision_shape.shape = _create_new_shape()
	
	_setup_new_obsticle_gap()

func _process(delta):
	self.position.x -= speed * delta
	

func _setup_new_obsticle_gap() -> void:
	var gap_start_position = _get_gap_start_position()
	_setup_top_obsticle(gap_start_position)
	
	var gap_end_position = gap_start_position + gap_size
	var bottom_obsticle_height = max_height - gap_end_position
	_setup_bottom_obsticle(bottom_obsticle_height)
	
	_setup_score_area(gap_size, gap_start_position)

func _get_gap_start_position() -> float:
	var start = 0.0
	var end = max_height - gap_size
	var rng = RandomNumberGenerator.new()
	return rng.randf_range(start, end)
	

func _setup_top_obsticle(height: float) -> void:
	top_collision_shape.shape.size.y = height
	var y_offset_position = height * 0.5
	top_area.position = Vector2(0, y_offset_position)
	

func _setup_bottom_obsticle(height: float) -> void:
	bottom_collision_shape.shape.size.y = height
	var y_offset_position = max_height - (height * 0.5)
	bottom_area.position = Vector2(0, y_offset_position)
	

func _setup_score_area(height: float, y_offset: float) -> void:
	score_collision_shape.shape.size.y = height
	score_area.position = Vector2(width, y_offset + (height * 0.5))

func _create_new_shape() -> RectangleShape2D:
	var new_shape = RectangleShape2D.new()
	new_shape.size.x = width
	return new_shape

func _on_body_entered_obsticle(body: Node2D):
	print("Game Over")
	GameEvents.player_touched_obsticle.emit()

func _on_area_entered_obsticle(area: Area2D):
	self.position = _initial_position
	_setup_new_obsticle_gap.call_deferred()

func _on_body_entered_score(body: Node2D):
	print("SCORE!")
	GameEvents.player_passed_obsticle.emit()
