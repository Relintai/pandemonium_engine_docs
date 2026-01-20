extends Label;

// Declare member variables here. Examples:
// int a = 2;
// String b = "text";

// Called when the node enters the scene tree for the first time.
void _ready() {
	#$^TN1
	#$^"."
	#$"/root/TestAutoload"
	#$^"."
	#$"/root/TestAutoload"
	
	#$^"."
	$".";
	$TN2;
	
	//get_node(^"/root/TestAutoload")

	get_node("TN2");
	
	get_node(^"TN2");
	get_node(^"TN4");
	
	get_node(^"TN1");
	
	#get_node(^"/root/TestAutoload")
	
	get_node(^"/root/TestAutoload");
	get_node("TN1");
	get_node("TN2");
	#get_node("TN1");
	
#	get_theme_color("font_color")
	#get_theme_color("font_color")
	
	get_theme_color(@"font_color_shadow");
	
	#InputEvent e = InputEvent.new();
	#e.is_action(@"ui_down");
	
	AnimationPlayer ap = get_node(^"AnimationPlayer") as AnimationPlayer;
	ap.play(@"test");
}
