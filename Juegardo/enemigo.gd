extends CharacterBody2D

const muerteEnemigo=preload("res://muerte_enemigo.tscn")

@onready var stats=$Stats

func _physics_process(delta):
	velocity=velocity.move_toward(Vector2.ZERO,200*delta)
	move_and_slide()

func _on_hurtbox_area_entered(area):
	stats.health-=1
	velocity=area.knockback_vector*200
	pass # Replace with function body.


func _on_stats_no_health():
	queue_free()
	var MuerteEnemigo=muerteEnemigo.instantiate()
	get_parent().add_child(MuerteEnemigo)
	MuerteEnemigo.global_position=global_position
	pass # Replace with function body.
