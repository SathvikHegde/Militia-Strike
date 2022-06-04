extends Area2D
class_name Bullet

export (int) var speed = 100;

var direction = Vector2.ZERO;

onready var killTimer = $KillTimer;

func _ready():
	killTimer.start();

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed;
		
		global_position += velocity;

func setDirection(direction: Vector2):
	self.direction = direction;
	rotation += direction.angle();

func _on_KillTimer_timeout():
	queue_free();

func _on_Bullet_body_entered(body):
	if body.has_method("handleHit"):
		body.handleHit();
		queue_free();
