extends Area2D

export(int) var speed = 200
export(int) var damage = 10
export(float) var cooldown = 0.35

var velocity = Vector2()
var direction = 1

func _ready():
	pass # Replace with function body.

#Change Direction
func set_direction(dir):
	direction = dir
	if direction == -1:
		$Bullet_Anim.flip_h = true
	else:
		$Bullet_Anim.flip_h = false

func _physics_process(delta):
	velocity.x = speed * delta * direction
	translate(velocity)
	$Bullet_Anim.play("BulletFired")


#RELEASE IF OUT OF SCREEN
func _on_Bullet_Visibility_screen_exited():
	queue_free()

#RELEASE IF COLLIDE
func _on_RegularBullet_body_entered(body):
	if body.name != 'TileMap':		
		var b_type = body.get_meta('TAG')
		if b_type == 'ENEMY':
			body.hit_by_player(damage)
	queue_free()
