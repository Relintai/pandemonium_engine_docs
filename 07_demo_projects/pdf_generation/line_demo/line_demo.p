extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";


void draw_line(PDFPage page, float x, float y, String label) {
	page.begin_text();
	page.move_text_pos(x, y - 10);
	page.show_text(label);
	page.end_text();
	
	page.path_move_to(Vector2(x, y - 15));
	page.path_line_to(Vector2(x + 220, y - 15));
	page.path_stroke();
}

void draw_line2(PDFPage page, float x,float y, String label) {
	page.begin_text();
	page.move_text_pos(x, y);
	page.show_text(label);
	page.end_text();

	page.path_move_to(Vector2(x + 30, y - 25));
	page.path_line_to(Vector2(x + 160, y - 25));
	page.path_stroke();
}

void draw_rect(PDFPage page, float x, float y, String label) {
	page.begin_text();
	page.move_text_pos(x, y - 10);
	page.show_text(label);
	page.end_text();
	
	page.path_rectangle(Rect2(x, y - 40, 220, 25));
}


void _ready() {
	PDFDocument pdf = PDFDocument.new();
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);
	
	String page_title = "Line Example";
	
	PDFDashMode DASH_MODE1 = PDFDashMode.new();
	DASH_MODE1.phase = 1;
	DASH_MODE1.num_elements = 1;
	DASH_MODE1.set_pattern_element(0, 3);
	
	PDFDashMode DASH_MODE2 = PDFDashMode.new();
	DASH_MODE2.phase = 2;
	DASH_MODE2.num_elements = 2;
	DASH_MODE2.set_pattern_element(0, 3);
	DASH_MODE2.set_pattern_element(1, 7);
	
	PDFDashMode DASH_MODE3 = PDFDashMode.new();
	DASH_MODE3.phase = 0;
	DASH_MODE3.num_elements = 4;
	DASH_MODE3.set_pattern_element(0, 8);
	DASH_MODE3.set_pattern_element(1, 7);
	DASH_MODE3.set_pattern_element(2, 2);
	DASH_MODE3.set_pattern_element(3, 7);

	PDFPage page = pdf.page_add();

//	/* print the lines of the page. */
	
	page.line_width = 1;
	
	page.path_rectangle(Rect2(50, 50, page.width - 100, page.height - 110));
	page.path_stroke();

//	/* print the title of the page (with positioning center). */
	page.set_font_and_size(font, 24);
	float tw = page.text_width(page_title);
	page.begin_text();
	page.move_text_pos((page.width - tw) / 2, page.height - 50);
	page.show_text(page_title);
	page.end_text();

	page.set_font_and_size(font, 10);

//	/* Draw various widths of lines. */
	page.line_width = 0;
	draw_line (page, 60, 770, "line width = 0");

	page.line_width = 1.0;
	draw_line (page, 60, 740, "line width = 1.0");

	page.line_width = 2.0;
	draw_line (page, 60, 710, "line width = 2.0");

//	/* Line dash pattern */
	page.line_width = 1.0;
	

	page.dash_set(DASH_MODE1);
	draw_line (page, 60, 680, "dash_ptn=[3], phase=1 -- 2 on, 3 off, 3 on...");

	page.dash_set(DASH_MODE2);
	draw_line (page, 60, 650, "dash_ptn=[7, 3], phase=2 -- 5 on 3 off, 7 on,...");

	page.dash_set(DASH_MODE3);
	draw_line (page, 60, 620, "dash_ptn=[8, 7, 2, 7], phase=0");

	page.dash_set(null);

	page.line_width = 30;
	page.rgb_stroke = Color(0.0, 0.5, 0.0);

//	/* Line Cap Style */
	page.line_cap = PDFPage.LINE_CAP_BUTT_END;
	draw_line2 (page, 60, 570, "PDF_BUTT_END");
	
	page.line_cap = PDFPage.LINE_CAP_ROUND_END;
	draw_line2 (page, 60, 505, "PDF_ROUND_END");
	
	page.line_cap = PDFPage.LINE_CAP_PROJECTING_SQUARE_END;
	draw_line2 (page, 60, 440, "PDF_PROJECTING_SCUARE_END");

//	/* Line Join Style */
	page.line_width = 30;
	page.rgb_stroke = Color(0.0, 0.0, 0.5);
	
	page.line_join = PDFPage.LINE_JOIN_MITER_JOIN;
	page.path_move_to(Vector2(120, 300));
	page.path_line_to(Vector2(160, 340));
	page.path_line_to(Vector2(200, 300));
	page.path_stroke();

	page.begin_text();
	page.move_text_pos(60, 360);
	page.show_text("PDF_MITER_JOIN");
	page.end_text();
	
	page.line_join = PDFPage.LINE_JOIN_ROUND_JOIN;
	page.path_move_to(Vector2(120, 195));
	page.path_line_to(Vector2(160, 235));
	page.path_line_to(Vector2(200, 195));
	page.path_stroke();

	page.begin_text();
	page.move_text_pos(60, 255);
	page.show_text("PDF_ROUND_JOIN");
	page.end_text();
	
	page.line_join = PDFPage.LINE_JOIN_BEVEL_JOIN;
	page.path_move_to(Vector2(120, 90));
	page.path_line_to(Vector2(160, 130));
	page.path_line_to(Vector2(200, 90));
	page.path_stroke();

	page.begin_text();
	page.move_text_pos(60, 150);
	page.show_text("PDF_BEVEL_JOIN");
	page.end_text();

//	/* Draw Rectangle */
	page.line_width = 2;
	page.rgb_stroke = Color(0, 0, 0);
	page.rgb_fill = Color(0.75, 0.0, 0.0);

	draw_rect(page, 300, 770, "Stroke");
	page.path_stroke();

	draw_rect(page, 300, 720, "Fill");
	page.path_fill();

	draw_rect(page, 300, 670, "Fill then Stroke");
	page.path_fill_stroke();

//	/* Clip Rect */
	page.g_save();  ///* Save the current graphic state */
	draw_rect(page, 300, 620, "Clip Rectangle");
	page.clip();
	page.path_stroke();
	page.set_font_and_size(font, 13);

	page.begin_text();
	page.move_text_pos(290, 600);
	page.text_leading = 12;
	
	page.show_text("Clip Clip Clip Clip Clip Clipi Clip Clip Clip");
	page.show_text_next_line("Clip Clip Clip Clip Clip Clip Clip Clip Clip");
	page.show_text_next_line("Clip Clip Clip Clip Clip Clip Clip Clip Clip");
	page.end_text();
	page.g_restore();

//	/* Curve Example(CurveTo2) */
	float x = 330;
	float y = 440;
	float x1 = 430;
	float y1 = 530;
	float x2 = 480;
	float y2 = 470;
	float x3 = 480;
	float y3 = 90;

	page.rgb_fill = Color(0, 0, 0);

	page.begin_text();
	page.move_text_pos(300, 540);
	page.show_text("CurveTo2(x1, y1, x2. y2)");
	page.end_text();

	page.begin_text();
	page.move_text_pos(x + 5, y - 5);
	page.show_text("Current point");
	page.move_text_pos(x1 - x, y1 - y);
	page.show_text("(x1, y1)");
	page.move_text_pos(x2 - x1, y2 - y1);
	page.show_text("(x2, y2)");
	page.end_text();

	page.dash_set(DASH_MODE1);

	page.line_width = 0.5;
	page.path_move_to(Vector2(x1, y1));
	page.path_line_to(Vector2(x2, y2));
	page.path_stroke();
	
	page.dash_set(null);

	page.line_width = 1.5;

	page.path_move_to(Vector2(x, y));
	page.path_curve_to_2(Vector2(x1, y1), Vector2(x2, y2));
	page.path_stroke();

//	/* Curve Example(CurveTo3) */
	y -= 150;
	y1 -= 150;
	y2 -= 150;

	page.begin_text();
	page.move_text_pos(300, 390);
	page.show_text("CurveTo3(x1, y1, x2. y2)");
	page.end_text();

	page.begin_text();
	page.move_text_pos(x + 5, y - 5);
	page.show_text("Current point");
	page.move_text_pos(x1 - x, y1 - y);
	page.show_text("(x1, y1)");
	page.move_text_pos(x2 - x1, y2 - y1);
	page.show_text("(x2, y2)");
	page.end_text();

	page.dash_set(DASH_MODE1);

	page.line_width = 0.5;
	page.path_move_to(Vector2(x, y));
	page.path_line_to(Vector2(x1, y1));
	page.path_stroke();

	page.dash_set(null);

	page.line_width = 1.5;
	page.path_move_to(Vector2(x, y));
	page.path_curve_to_3(Vector2(x1, y1), Vector2(x2, y2));
	page.path_stroke();

//	/* Curve Example(CurveTo) */
	y -= 150;
	y1 -= 160;
	y2 -= 130;
	x2 += 10;

	page.begin_text();
	page.move_text_pos(300, 240);
	page.show_text("CurveTo(x1, y1, x2. y2, x3, y3)");
	page.end_text();

	page.begin_text();
	page.move_text_pos(x + 5, y - 5);
	page.show_text("Current point");
	page.move_text_pos(x1 - x, y1 - y);
	page.show_text("(x1, y1)");
	page.move_text_pos(x2 - x1, y2 - y1);
	page.show_text("(x2, y2)");
	page.move_text_pos(x3 - x2, y3 - y2);
	page.show_text("(x3, y3)");
	page.end_text();

	page.dash_set(DASH_MODE1);

	page.line_width = 0.5;
	page.path_move_to(Vector2(x, y));
	page.path_line_to(Vector2(x1, y1));
	page.path_stroke();
	page.path_move_to(Vector2(x2, y2));
	page.path_line_to(Vector2(x3, y3));
	page.path_stroke();

	page.dash_set(null);

	page.line_width = 1.5;
	page.path_move_to(Vector2(x, y));
	page.path_curve_to(Vector2(x1, y1), Vector2(x2, y2), Vector2(x3, y3));
	page.path_stroke();

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

