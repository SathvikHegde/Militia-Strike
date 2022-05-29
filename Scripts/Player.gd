extends KinematicBody2D

var moveSpeed = 300;
var bulletSpeed = 1500;
var bullet = preload("res://Scenes/Bullet.tscn");

func _ready():
	pass 

func _physics_process(delta):
	var motion = Vector2();
	
	if Input.is_action_pressed("up"):
		motion.y -= 1;
	if Input.is_action_pressed("down"):
		motion.y += 1;
	if Input.is_action_pressed("right"):
		motion.x += 1;
	if Input.is_action_pressed("left"):
		motion.x -= 1;
	
	motion = motion.normalized();
	motion = move_and_slide(motion * moveSpeed);
	
	look_at(get_global_mouse_position());
	
	if Input.is_action_just_pressed("mouse1"):
		fireBullet();

func fireBullet():
	var bulletInstance = bullet.instance();
	bulletInstance.position = get_global_position();
	bulletInstance.position.x += 8;
	bulletInstance.position.y += 8;
	bulletInstance.rotation_degrees = rotation_degrees;
	bulletInstance.apply_impulse(Vector2(), Vector2(bulletSpeed, 0).rotated(rotation));
	get_tree().get_root().call_deferred("add_child", bulletInstance);

func killed():
	get_tree().reload_current_scene();

func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		killed();
