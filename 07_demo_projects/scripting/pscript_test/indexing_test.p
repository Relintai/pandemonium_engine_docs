extends Node;

int tx = 10;

void _ready() {
	print("IndexingTest");
	
	Vector2 v2 = Vector2(1, 2);
	
	print(str(v2.x) + " " + str(v2.y));
	// Equivalent to `.`. (Actually parsed as .).
	print(str(v2->x) + " " + str(v2->y));
	// This has limitations, but can work
	print(str(v2::x) + " " + str(v2::y));
	
	print(tx);
	print(this.tx);
	print(this->tx);
	print(this::tx);
	
	TypedArray<int> tta = TypedArray<int>();
	tta.push_back(0);
	tta.push_back(1);
	tta.push_back(2);
	
	print(tta[0]);
	print(tta[2]);
	
	tta[0] = 2;
	
	print(tta[0]);
}
