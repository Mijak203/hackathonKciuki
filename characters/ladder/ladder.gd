extends Area2D

func _on_body_entered(body):
	body.on_ledder = true

func _on_body_exited(body):
	body.on_ledder = false

