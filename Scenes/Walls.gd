extends Node2D

signal body_has_escaped(body)

func _ready():
	pass


func _on_Botton_body_entered(body):
	emit_signal("body_has_escaped", body)


