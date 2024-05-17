extends Node

signal no_health

@export var max_health:int=1
@onready var health=max_health:
	get: 
		return health
	set(value): 
		health = value
		if health <= 0:
			emit_signal("no_health")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
