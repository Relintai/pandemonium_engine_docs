extends Node;


void _ready() {
	print("Ternary if tests:");
	
	int a = 100;
	
	int b = a > 10 ? 12 <> 13;
	print(b); 
	

	print(a > 100 ? "Yes, a is bigger than 100." <> "No, a is not bigger than 100."); 
}



