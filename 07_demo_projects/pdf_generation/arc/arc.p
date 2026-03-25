extends Node;

export(String) String output_pdf_name = "demo.pdf";

void _ready() {
	PrintGrid pg = PrintGrid.new();
	
	PDFDocument pdf = PDFDocument.new();

	PDFPage page = pdf.page_add();

	page.height = 220;
	page.width = 200;

//	draw grid to the page
	pg.print_grid(pdf, page);

//	draw pie chart
//	A: 45% Red
//	B: 25% Blue
//	C: 15% green
//	D: other yellow

//	/* A */
	page.rgb_fill = Color(1.0, 0, 0);
	page.path_move_to(Vector2(100, 100));
	page.path_line_to(Vector2(100, 180));
	page.path_arc(Vector2(100, 100), 80, 0, 360 * 0.45);
	Vector2 pos = page.current_pos_get();
	page.path_line_to(Vector2(100, 100));
	page.path_fill();

//	/* B */
	page.rgb_fill = Color(0, 0, 1.0);
	page.path_move_to(Vector2(100, 100));
	page.path_line_to(Vector2(pos.x, pos.y));
	page.path_arc(Vector2(100, 100), 80, 360 * 0.45, 360 * 0.7);
	pos = page.current_pos_get();
	page.path_line_to(Vector2(100, 100));
	page.path_fill();

//	/* C */
	page.rgb_fill = Color(0, 1.0, 0);
	page.path_move_to(Vector2(100, 100));
	page.path_line_to(Vector2(pos.x, pos.y));
	page.path_arc(Vector2(100, 100), 80, 360 * 0.7, 360 * 0.85);
	pos = page.current_pos_get();
	page.path_line_to(Vector2(100, 100));
	page.path_fill();

//	/* D */
	page.rgb_fill = Color(1.0, 1.0, 0);
	page.path_move_to(Vector2(100, 100));
	page.path_line_to(Vector2(pos.x, pos.y));
	page.path_arc(Vector2(100, 100), 80, 360 * 0.85, 360);
	pos = page.current_pos_get();
	page.path_line_to(Vector2(100, 100));
	page.path_fill();

//	/* draw center circle */
	page.gray_stroke = 0;
	page.gray_fill = 1;
	page.path_circle(Vector2(100, 100), 30);
	page.path_fill();

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

