extends KinematicBody2D

onready var blood = preload("res://Blood.tscn")
onready var ray = $ray
var health =120;
var speed=25
var velocity = Vector2.ZERO
var pos=Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _init(_pos=Vector2.ZERO):
	pos =_pos
	look_at(pos)


# warning-ignore:unused_argument
func _physics_process(delta):
	look_at(pos)
	velocity =position.direction_to(pos) * speed
	move_and_slide(velocity)
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider.name == "Player":
			 $AnimatedSprite.animation = "attack"
	
	if(health < 0):
		queue_free()
	 
	
func kill():
	
	if health%50 < 5:
		var bld = blood.instance()
		bld.position = position
		get_parent().add_child(bld)
	health -=10
