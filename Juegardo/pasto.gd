extends Node2D

const EfectoPasto=preload("res://efecto_pasto.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func crear_efecto_pasto():
	var efectoPasto=EfectoPasto.instantiate()
	get_parent().add_child(efectoPasto)
	efectoPasto.global_position=global_position
	queue_free()

func _on_hurtbox_area_entered(area):
	crear_efecto_pasto()
	queue_free()
	pass # Replace with function body.
