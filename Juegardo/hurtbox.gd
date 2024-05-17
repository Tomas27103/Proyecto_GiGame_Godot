extends Area2D

@export var show_hit:bool =true

const golpe=preload("res://golpe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if show_hit:
		var efecto=golpe.instantiate()
		var main=get_tree().current_scene
		main.add_child(efecto)
		efecto.global_position=global_position
	pass # Replace with function body.
