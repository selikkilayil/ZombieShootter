extends KinematicBody2D

var isSoundOn=true;
var emmo=80;
var firing=false
var isReload=false
var count =0
signal hit

func _ready():
	$AnimatedSprite.playing = true;

func _physics_process(delta):
	look_at(get_global_mouse_position()+ Vector2(-100,100))
	$CanvasLayer/RichTextLabel.text= "angle "+str(get_global_mouse_position())
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) &&  !isReload):
	   $AnimatedSprite.animation = "Shoot"
	   createFlare()
	   playfire()
	else:   
	   $flare.visible =false
	   $fireSound.stop()
	   if($AnimatedSprite.animation != "reload"):$AnimatedSprite.animation ="Idle"
	   firing=false
   

func playfire():
	if(!firing && isSoundOn):
		$fireSound.play(0)
		firing=true
	
func createFlare():
	if($AnimatedSprite.frame == 1 &&  !isReload):
#		count +=1 
#		$CanvasLayer/RichTextLabel.text= "Ammo "+str(count)
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

func soundOnOff():
	isSoundOn = !isSoundOn


func _on_AnimatedSprite_animation_finished():
	if($AnimatedSprite.animation=="reload"):
		emmo=80
		isReload=false
		$AnimatedSprite.animation="Idle"


func _on_TouchScreenButton_pressed():
	soundOnOff()
