extends KinematicBody2D

export (int) var speed = 100;
export (PackedScene) var Bullet;

signal playerFiredBullet(bullet, position, direction);

onready var endOfGun = $EndOfGun;
onready var gunDirection = $GunDirection;
onready var attackCooldown = $AttackCooldown;
onready var muzzleFlashAnimation = $AnimationPlayer;

var health: int = 100;

func _ready():
	pass 

func _process(delta):
	var direction = Vector2();
	
	if Input.is_action_pressed("up"):
		direction.y = -1;
	if Input.is_action_pressed("down"):
		direction.y = 1;
	if Input.is_action_pressed("right"):
		direction.x = 1;
	if Input.is_action_pressed("left"):
		direction.x = -1;
	
	direction = direction.normalized();
	
	move_and_slide(direction * speed);
	look_at(get_global_mouse_position());

func _unhandled_input(event):
	if event.is_action_pressed("mouse1"):
		shootBullet();

func shootBullet():
	if attackCooldown.is_stopped():
		var bulletInstance = Bullet.instance();
		var direction = (gunDirection.global_position - endOfGun.global_position).normalized();
		emit_signal("playerFiredBullet", bulletInstance, endOfGun.global_position, direction);
		attackCooldown.start();
		muzzleFlashAnimation.play("muzzleFlash");

func handleHit():
	health -= 30;
	print("Player got hit. Health: ", health);
