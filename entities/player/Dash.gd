extends State

var p0: = Vector2(0.0, 1.0)
var p1: = Vector2(0.0, 15.0)
var p2: = Vector2(0.75, 1.0)
var p3: = Vector2(1.0, 1.0)

@onready var timer: Timer = $Timer
@onready var idle: Node = $"../Idle"

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)

func on_enter():
	timer.wait_time = Player.DASH_TIME
	timer.start()

func state_process(_delta):
	var t = (timer.wait_time - timer.time_left) / timer.wait_time
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)

	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)

	var s = r0.lerp(r1, t)
	Player.temp_speed_modifier = s.y

func on_timer_timeout():
	next_state = idle