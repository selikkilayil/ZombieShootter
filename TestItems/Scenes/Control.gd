extends KinematicBody2D
onready var blood = preload("res://Blood.tscn")

var freez =false
var emmo=80;
var firing=false
var isReload=false
var count =0
var isLeft = false
var Clicked =false
var health = 1000
signal hit

func _ready():
	$AnimatedSprite.playing = true;
	rotation_degrees=-90

func _physics_process(delta):
	look_at(get_global_mouse_position())

	if(Input.is_mouse_button_pressed(BUTTON_LEFT) || Input.is_action_pressed("ui_select"))  &&  !isReload && !freez :
	   $AnimatedSprite.animation = "Shoot"
	   createFlare()
	   playfire()
	else:   
	   $flare.visible =false
	   $fireSound.stop()
	   if($AnimatedSprite.animation != "reload"):$AnimatedSprite.animation ="Idle"
	   firing=false
	if(health<0):
		get_tree(). reload_current_scene();
   

func playfire():
	if(!firing):
		$fireSound.play(0)
		firing=true
	
func createFlare():
	if($AnimatedSprite.frame == 1 &&  !isReload):
		count +=1 
		$CanvasLayer/RichTextLabel.text= "Ammo "+str(count)
		if(emmo == 0):
			$AnimatedSprite.animation="reload"
			isReload=true
			return
		emmo-=1
		if($RayCast2D.is_colliding()):
			var colider =$RayCast2D.get_collider()
			emit_signal("hit",$RayCast2D.position,$RayCast2D.get_collision_point())
			if colider.has_method("kill"):
				colider.kill()
		$flare.visible =true
	else:
		$flare.visible =false

func _kill():
	freez = true
	health-=1
	if(health%50 <=8 ):
		var bld = blood.instance()
		bld.position = position
		get_parent().add_child(bld)

func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation=="reload"):
		emmo=80
		isReload=false
		$AnimatedSprite.animation="Idle"
