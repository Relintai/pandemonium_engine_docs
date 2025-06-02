tool
extends TextureRect
class_name QRCodeTextureRect, "res://addons/QRCodeTexture/icon.png"

export(String) var data: String = "" setget set_data

export(int, "LOW,MEDIUM,QUARTILE,HIGH") var error_correct_level = QRCode.ERROR_CORRECT_LEVEL.LOW setget set_error_correct_level

var _qr_code: QRCode = null

# ------------------------------------------------------------------------------
# Build-in methods
# ------------------------------------------------------------------------------

func set_data(new_value):
	data = new_value
	_ui_update_texture()

func set_error_correct_level(new_value):
	error_correct_level = new_value
	_update_error_correct_level()
	_ui_update_texture()


func _ready() -> void:
	_qr_code = QRCode.new()

	self.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	_ui_update()

# ------------------------------------------------------------------------------
# Private methods
# ------------------------------------------------------------------------------

func _update_error_correct_level() -> void:
	if _qr_code == null: return
	
	_qr_code.error_correct_level = error_correct_level

# ------------------------------------------------------------------------------
# UI update methods
# ------------------------------------------------------------------------------

func _ui_update_texture() -> void:
	if _qr_code == null: return
	
	self.texture = _qr_code.get_texture(data)

func _ui_update() -> void:
	_ui_update_texture()
