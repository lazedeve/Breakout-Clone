extends CanvasLayer

signal new_game


func _ready():
	$Play.show()
	$Title.show()


func _on_Button_pressed():
	emit_signal("new_game")
	$Play.hide()
	$Title.hide()
