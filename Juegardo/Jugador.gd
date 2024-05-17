extends CharacterBody2D

@export var ACELERACION=1000
@export var VEL_MAX=400
@export var FRICCION=1000

enum{
	MOVIENDO,
	DASH,
	ATAQUE
}

var state=MOVIENDO

var dash_vector=Vector2.DOWN

@onready var animationPlayer=$AnimationPlayer
@onready var animationTree=$AnimationTree
@onready var animationState=animationTree.get("parameters/playback")
@onready var hitboxArma=$PivoteHitbox/HitboxArma

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animationTree.active=true
	hitboxArma.knockback_vector=dash_vector

func _physics_process(delta):
	match state:
		MOVIENDO:
			moverse_state(delta)
		DASH:
			dash_state(delta)
		ATAQUE:
			atacar_state(delta)
	
func atacar_state(delta):
	velocity=Vector2.ZERO
	animationState.travel("Atacar")
	
func dash_state(delta):
	velocity=dash_vector*VEL_MAX*1.25
	animationState.travel("Dashear")
	move_and_slide()

func acabo_ataque():
	state=MOVIENDO

func acabo_dash():
	velocity=velocity/2
	state=MOVIENDO

func moverse_state(delta):
	var input_vector=Vector2.ZERO
	input_vector = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	input_vector = input_vector.normalized()
	input_vector=input_vector.normalized()
	if input_vector!=Vector2.ZERO:
		dash_vector=input_vector
		hitboxArma.knockback_vector=input_vector
		animationTree.set("parameters/Caminar/blend_position",input_vector)
		animationTree.set("parameters/Atacar/blend_position",input_vector)
		animationTree.set("parameters/Dashear/blend_position",input_vector)
		animationState.travel("Caminar")
		velocity=velocity.move_toward(input_vector*VEL_MAX,ACELERACION*delta)
	else:
		animationState.travel("Caminar")
		velocity=velocity.move_toward(Vector2.ZERO,FRICCION*delta)
	move_and_slide()
	if Input.is_action_just_pressed("Atacar"):
		state=ATAQUE
	if Input.is_action_just_pressed("Dash"):
		state=DASH
