@tool 
extends Area2D

var direction= Vector2.RIGHT

enum SIZE {
	SMALL ,
	MEDIUM,
	BIG 
}

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D


@export var size : SIZE = SIZE.BIG:
	set(value):
		if value != size:
			size = value
			size_changed.emit()


@export var speed = 200.0
@export var torque = 50.0

@export var asteroid_size_array : Array[AsteroidSize]
signal size_changed

func _ready() -> void :
	size_changed.connect(update_size)


func _physics_process(delta: float) ->void:
	var velocity = speed * direction * delta
	global_position += velocity
	
	rotation_degrees += torque * delta


func update_size() -> void:
	var asteroid_size = asteroid_size_array[size]
	
	sprite.texture = asteroid_size.texture
	collision_shape.shape = asteroid_size.shape

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.destroy()
