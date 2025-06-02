extends PanelContainer

var totp : TOTP = null

var _totp_value_log : RichTextLabel = null

func _ready() -> void:
	_totp_value_log = get_node("%TOTPValueLog")
	
	totp = TOTP.new()
	
	totp.create_secret()
	
	var ls : String = ""
	
	ls += str(totp.secret_string) + "\n"
	
	ls += str(totp.base32_to_raw(totp.secret_string)) + "\n"
	ls += str(totp.raw_to_base32((totp.base32_to_raw(totp.secret_string)))) + "\n"
	
	ls += str(totp.is_valid_base32(totp.secret_string)) + "\n"
	
	ls += str(totp.get_otpauth_uri("Test Issuer", "Test Label")) + "\n"
	ls += str(totp.get_otpauth_uri("Test Issuer", "Test Label", "Test Image URL")) + "\n"
	ls += (totp.get_otpauth_uri("Test Issuer", "Test Label", "Test Image URL", false, 32)) + "\n"
	
	print(ls)
	
	get_node("%SecretKeyValue").text = totp.secret_string
	get_node("%OTPAuthURI").text = totp.get_otpauth_uri("Test Issuer", "Test Label")
	get_node("%QRCode").data = totp.get_otpauth_uri("Test Issuer", "Test Label")
	#get_node("%StartupLog").text = ls


func _process(delta: float) -> void:
	var tp : Array = totp.calculate_totp()
	
	var l : String = ""
	
	l += "Value from TOTPResult Enum: " + str(tp[0]) + "\n"
	l += "HOTP value: " + str(tp[1]) + "\n"
	l += "Time period: " + str(tp[2])
	

	_totp_value_log.text = l
	
