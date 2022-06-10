extends RigidBody


func _ready():
	self.apply_impulse(Vector3.ZERO, Vector3(500, 300, 0))#.rotated(Vector3(0, 1, 0), rand_range(-PI/6, PI/6)))
	pass


func _on_Ball_body_entered(body):
	if body.name == "taxi":
		apply_impulse(Vector3.ZERO, Vector3(-500, 300, 0))
		pass
	print("HIT")
	print(body.name)
