extends Node2D

var draw_scale
var draw_alpha=1
var direct; var step; var sizeChange
var pos =Vector2(0,0)
var count

func blood():
	randomize()
	for i in range(0,361,30):
		count=rand_range(16,48)
		draw_alpha=1
		draw_scale=rand_range(0.3,1.1)
		pos = Vector2(0,0)
		direct = rand_range(i-10,i+10)
		for n in range(count):
			step = rand_range(2,8)
			sizeChange = rand_range(draw_scale/10,draw_scale/3)
			
			draw_scale -= sizeChange
			draw_alpha -= rand_range(0.05,0.1)
			
			pos = Vector2(pos.x+step+rand_range(-8,9),pos.y + step+rand_range(-8,9))
			draw_circle(pos.rotated(deg2rad(direct)),draw_scale * 12,Color(1- draw_alpha/1.5,0,0,draw_alpha))
			

func _draw():
	blood()



func _on_Timer_timeout():
	queue_free()
