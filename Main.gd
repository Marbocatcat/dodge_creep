extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.show_message("Ready")
	$HUD.update_score(score)
	$Music.play()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.game_over()
	$Music.stop()
	$DeathSound.play()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi()) # randomize mob spawn
	var mob = Mob.instance()
	add_child(mob) # add to main so its part of the scene
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(mob.MIN_SPEED, mob.MAX_SPEED).rotated(direction))
