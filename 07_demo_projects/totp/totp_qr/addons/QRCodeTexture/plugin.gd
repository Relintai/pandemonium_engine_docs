tool
extends EditorPlugin

# ------------------------------------------------------------------------------
# Build-in methods
# ------------------------------------------------------------------------------

func _enter_tree():
	add_custom_type("QRCodeTextureRect", "TextureRect", preload("qr_code_texture_rect.gd"), preload("res://addons/QRCodeTexture/icon.png"))

func _exit_tree():
	remove_custom_type("QRCodeTextureRect")
