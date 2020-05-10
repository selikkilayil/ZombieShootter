extends Node2D

onready var zombie = preload("res://TestItems/Scenes/zombie.tscn")
#onready var blood = preload("res://Blood.tscn")
onready var trail = preload("res://trail.tscn")

func _ready():
	$Player.position=Vector2(get_viewport().size.x/2,get_viewport().size.y-50)
#	var z1 = zombie.instance()
#	z1.position = Vector2(0,0)
#	z1._init($Player.position)
#	var z2 = zombie.instance()
#	z2.position = Vector2(100,0)
#	z2._init($Player.position)
#	var z3 = zombie.instance()
#	z3.position = Vector2(200,0)
#	z3._init($Player.position)
#	var z4 = zombie.instance()
#	z4.position = Vector2(500,0)
#	z4._init($Player.position)
#	add_child(z1)
#	add_child(z2)
#	add_child(z3)
#	add_child(z4)
#	$Player.connect("hit",self,"show_hit")
	
#func show_hit(gunloc,hit_location):
#	var bloodshot = blood.instance()
#	add_child(bloodshot)
#	bloodshot.position=hit_location
#	bloodshot.set_emitting(true)
	
#	var t =trail.instance()
#	add_child(t)
#	var d=hit_location-gunloc
#	t.set_region_rect(Rect2(0,0,d.length(),2))
#	t.rotation= -d.angle_to(Vector2(1,0))



func _on_Timer_timeout():
	for i in 5:
		var z =zombie.instance()
		z._init($Player.position)
		var x=rand_range(0,get_viewport().size.x)
		z.position = Vector2(x,0)
		add_child(z)
	$Timer.wait_time +=.2
# Replace with function body.
