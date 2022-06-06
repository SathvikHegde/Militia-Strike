extends Node2D

signal stateChanged(newState);

enum State {
	PATROL,
	ENGAGE
};

onready var detectionZone = $DetectionZone;

var state: int = State.PATROL setget setState, getState;
var player: Player = null;
var character = null;
var weapon: Weapon = null;

func _process(delta):
	match state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null && weapon != null:
				character.rotation = character.global_position.direction_to(player.global_position).angle();
				weapon.shootBullet();
			else:
				print("ERROR! Player or Weapon is undefined in AI.")
		_:
			print("ERROR! Non-existant state value.")

func init(p_character, p_weapon: Weapon):
	character = p_character;
	weapon = p_weapon;

func setState(newState: int):
	if state == newState:
		return
	
	state = newState;
	emit_signal("stateChanged", state);

func getState():
	return state;

func _on_DetectionZone_body_entered(body):
	if body.is_in_group("Player"):
		setState(State.ENGAGE);
		player = body;
