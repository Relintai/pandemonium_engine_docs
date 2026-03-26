extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";

int no = 0;

void PrintText(PDFPage page)
{
	Vector2 pos = page.current_pos_get();
	
	String buf = ".[%d]%0.2f %0.2f" % [no, pos.x, pos.y];

	no++;
	
	page.show_text(buf);
}


void _ready() {
	PDFDocument pdf = PDFDocument.new();
	
//	/* set compression mode */
	pdf.compression_mode_set(PDFDocument.COMPRESSION_MODE_ALL);
	
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);
	
//	float angle1;
//	float angle2;
//	float rad1;
//	float rad2;

	String SAMP_TXT = "The quick brown fox jumps over the lazy dog. ";

//	/* add a new page object. */
	PDFPage page = pdf.page_add();
	page.size_set(PDFPage.PAGE_SIZE_A5, PDFPage.PAGE_DIRECTION_PORTRAIT);

	PrintGrid pg = PrintGrid.new();
	pg.print_grid(pdf, page);

	page.text_leading = 20;

//	/* text_rect method */

//	/* HPDF_TALIGN_LEFT */
	Rect2 rect;
	rect.position = Vector2(25, 545);
	rect.end = Vector2(200, rect.position.y - 40);
//	rect.left = 25;
//	rect.top = 545;
//	rect.right = 200;
//	rect.bottom = rect.top - 40;

	page.path_rectangle(rect);
//	HPDF_Page_Rectangle (page, rect.left, rect.bottom, rect.right - rect.left,
//				rect.top - rect.bottom);
	page.path_stroke();
	
	page.begin_text();
	
	page.set_font_and_size(font, 10);
	
	page.draw_text_out(Vector2(rect.position.x, rect.position.y + 3), "HPDF_TALIGN_LEFT");

	page.set_font_and_size(font, 13);
	page.draw_text_rect(rect, SAMP_TXT, PDFPage.TEXT_ALIGN_LEFT);
	
	page.end_text();

//	/* HPDF_TALIGN_RIGTH */
	rect.position.x = 220;
	rect.size.x = 395 - rect.position.x;

	page.path_rectangle(rect);
	page.path_stroke();

	page.begin_text();

	page.set_font_and_size(font, 10);
	page.draw_text_out(Vector2(rect.position.x, rect.position.y + 3), "HPDF_TALIGN_RIGTH");

	page.set_font_and_size(font, 13);
	page.draw_text_rect(rect, SAMP_TXT, PDFPage.TEXT_ALIGN_RIGHT);

	page.end_text();

//	/* HPDF_TALIGN_CENTER */
	rect.position = Vector2(25, 475);
	rect.end = Vector2(200, rect.position.y - 40);
//	rect.left = 25;
//	rect.top = 475;
//	rect.right = 200;
//	rect.bottom = rect.top - 40;

	page.path_rectangle(rect);
	page.path_stroke();

	page.begin_text();

	page.set_font_and_size(font, 10);
	page.draw_text_out(Vector2(rect.position.x, rect.position.y + 3), "HPDF_TALIGN_CENTER");

	page.set_font_and_size(font, 13);
	page.draw_text_rect(rect, SAMP_TXT, PDFPage.TEXT_ALIGN_CENTER);

	page.end_text();

//	/* HPDF_TALIGN_JUSTIFY */
	rect.position.x = 220;
	rect.size.x = 395 - rect.position.x;

	page.path_rectangle(rect);
	page.path_stroke();

	page.begin_text();

	page.set_font_and_size(font, 10);
	page.draw_text_out(Vector2(rect.position.x, rect.position.y + 3), "HPDF_TALIGN_JUSTIFY");

	page.set_font_and_size(font, 13);
	page.draw_text_rect(rect, SAMP_TXT, PDFPage.TEXT_ALIGN_JUSTIFY);

	page.end_text();

//	/* Skewed coordinate system */
	
	page.g_save();

	float angle1 = 5;
	float angle2 = 10;
	float rad1 = angle1 / 180 * 3.141592;
	float rad2 = angle2 / 180 * 3.141592;
	
	Transform2D t;
	t.x = Vector2(1, tan(rad1));
	t.y = Vector2(tan(rad2), 1);
	t.origin = Vector2(25, 350);
	page.concat(t);
	
	rect.position = Vector2(0, 40);
	rect.end = Vector2(175, 0);

	page.path_rectangle(rect);
	page.path_stroke();

	page.begin_text();

	page.set_font_and_size(font, 10);
	page.draw_text_out(Vector2(rect.position.x, rect.position.y + 3), "Skewed coordinate system");

	page.set_font_and_size(font, 13);
	page.draw_text_rect(rect, SAMP_TXT, PDFPage.TEXT_ALIGN_LEFT);

	page.end_text();
	
	page.g_restore();


//	/* Rotated coordinate system */
	page.g_save();

	angle1 = 5;
	rad1 = angle1 / 180 * 3.141592;
	
	t.x = Vector2(cos(rad1), sin(rad1));
	t.y = Vector2(-sin(rad1), cos(rad1));
	t.origin = Vector2(220, 350);
	page.concat(t);
	
	rect.position = Vector2(0, 40);
	rect.end = Vector2(175, 0);

	page.path_rectangle(rect);
	page.path_stroke();

	page.begin_text();

	page.set_font_and_size(font, 10);
	page.draw_text_out(Vector2(rect.position.x, rect.position.y + 3), "Rotated coordinate system");

	page.set_font_and_size(font, 13);
	page.draw_text_rect(rect, SAMP_TXT, PDFPage.TEXT_ALIGN_LEFT);

	page.end_text();

	page.g_restore();


//	/* text along a circle */
	page.gray_stroke = 0;
	page.path_circle(Vector2(210, 190), 145);
	page.path_circle(Vector2(210, 190), 113);
	page.path_stroke();

	angle1 = 360 / SAMP_TXT.length();
	angle2 = 180;

	page.begin_text();

	page.set_font_and_size(font, 30);

	for (int i = 0; i < SAMP_TXT.length(); i++) {
		float x;
		float y;

		rad1 = (angle2 - 90) / 180 * 3.141592;
		rad2 = angle2 / 180 * 3.141592;

		x = 210 + cos(rad2) * 122;
		y = 190 + sin(rad2) * 122;
		
		t.x = Vector2(cos(rad1), sin(rad1));
		t.y = Vector2(-sin(rad1), cos(rad1));
		t.origin = Vector2(x, y);
		
		page.text_matrix = t;
		
		page.show_text(SAMP_TXT[i]);
		angle2 -= angle1;
	}

	page.end_text();

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

