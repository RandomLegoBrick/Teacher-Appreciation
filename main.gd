extends Spatial



func alert(text: String, title: String='Message') -> void:
	var dialog = AcceptDialog.new()
	dialog.dialog_text = text
	dialog.window_title = title
	dialog.connect('modal_closed', dialog, 'queue_free')
	add_child(dialog)
	dialog.popup_centered()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	OS.set_window_maximized(true)
	alert("Happy Teacher Appreciation Day, Mrs. Hickok!\nUse the arrow keys to move and the mouse to look around.\nWhen you are done, press escape to exit. Press enter to close this message.", "Welcome")
