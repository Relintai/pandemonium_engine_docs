extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";


void show_stripe_pattern(PDFPage page, float x, float y) {
	int iy = 0;

	while (iy < 50) {
		page.rgb_stroke = Color(0.0, 0.0, 0.5);
		page.line_width = 1;
		page.path_move_to(Vector2(x, y + iy));
		page.path_line_to(Vector2(x + page.text_width("ABCabc123"), y + iy));
		page.path_stroke();
		iy += 3;
	}
	
	page.line_width = 2.5;
}


void show_description(PDFPage page, float x, float y, String text) {
	float fsize = page.current_font_size_get();
	PDFFont font = page.current_font_get();
	Color c = page.rgb_fill;

	page.begin_text();
	
	page.rgb_fill = Color(0, 0, 0);
	page.text_rendering_mode = PDFPage.TEXT_RENDERING_MODE_FILL;
	page.set_font_and_size(font, 10);
	page.draw_text_out(Vector2(x, y - 12), text);
	page.end_text();
	
	page.set_font_and_size(font, fsize);
	page.rgb_fill = Color(c.r, c.g, c.b);
}


void _ready() {
	PrintGrid pg = PrintGrid.new();
	
	PDFDocument pdf = PDFDocument.new();
	
//	/* set compression mode */
	pdf.compression_mode_set(PDFDocument.COMPRESSION_MODE_ALL);
	
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);
	
	String page_title = "Text Demo";
	String samp_text = "abcdefgABCDEFG123!#$%&+-@?";
	String samp_text2 = "The quick brown fox jumps over the lazy dog.";

//	/* add a new page object. */
	PDFPage page = pdf.page_add();

//	/* draw grid to the page */
	pg.print_grid(pdf, page);

//	/* print the lines of the page.
//	page.line_width = 1);
//	HPDF_Page_Rectangle (page, 50, 50, page.width - 100,
//				page.height - 110);
//	page.path_stroke();
//	*/

//	/* print the title of the page (with positioning center). */
	page.set_font_and_size(font, 24);
	float tw = page.text_width(page_title);
	page.begin_text();
	page.draw_text_out(Vector2((page.width - tw) / 2, page.height - 50), page_title);
	page.end_text();

	page.begin_text();
	page.move_text_pos(60, page.height - 60);

//	/*
//	 * font size
//	 */
	float fsize = 8;
	while (fsize < 60) {
		String buf = samp_text;

//		/* set style and size of font. */
		page.set_font_and_size(font, fsize);

//		/* set the position of the text. */
		page.move_text_pos(0, -5 - fsize);

//		/* measure the number of characters which included in the page. */
		int length = page.measure_text(samp_text, page.width - 120, false).x;

		page.show_text(buf);

//		/* print the description. */
		page.move_text_pos(0, -10);
		page.set_font_and_size(font, 8);
		buf = "Fontsize=%.0f" % fsize;
		page.show_text(buf);

		fsize *= 1.5;
	}

//	/*
//	 * font color
//	 */
	page.set_font_and_size(font, 8);
	page.move_text_pos(0, -30);
	page.show_text("Font color");

	page.set_font_and_size(font, 18);
	page.move_text_pos(0, -20);
	int length = samp_text.length();
	
	for (int i = 0; i < length; i++) {
		float r = float(i) / float(length);
		float g = 1 - (float(i) / float(length));
		String buf = samp_text[i];

		page.rgb_fill = Color(r, g, 0.0);
		page.show_text(buf);
	}
	page.move_text_pos(0, -25);

	for (int i = 0; i < length; i++) {
		float r = float(i) / float(length);
		float b = 1 - (float(i) / float(length));
		String buf = samp_text[i];

		page.rgb_fill = Color(r, 0.0, b);
		page.show_text(buf);
	}
	page.move_text_pos(0, -25);

	for (int i = 0; i < length; i++) {
		float b = float(i) / float(length);
		float g = 1 - (float(i) / float(length));
		String buf = samp_text[i];

		page.rgb_fill = Color(0.0, g, b);
		page.show_text(buf);
	}

	page.end_text();

	float ypos = 450;

//	/*
//	 * Font rendering mode
//	 */
	page.set_font_and_size(font, 32);
	page.rgb_fill = Color(0.5, 0.5, 0.0);
	page.line_width = 1.5;

//	 /* PDF_FILL */
	show_description (page,  60, ypos,
				"RenderingMode=PDF_FILL");
	page.text_rendering_mode = PDFPage.TEXT_RENDERING_MODE_FILL;
	page.begin_text();
	page.draw_text_out(Vector2(60, ypos), "ABCabc123");
	page.end_text();

//	/* PDF_STROKE */
	show_description (page, 60, ypos - 50,
				"RenderingMode=PDF_STROKE");
	page.text_rendering_mode = PDFPage.TEXT_RENDERING_MODE_STROKE;
	page.begin_text();
	page.draw_text_out(Vector2(60, ypos - 50), "ABCabc123");
	page.end_text();

//	/* PDF_FILL_THEN_STROKE */
	show_description (page, 60, ypos - 100,
				"RenderingMode=PDF_FILL_THEN_STROKE");
	page.text_rendering_mode = PDFPage.TEXT_RENDERING_MODE_FILL_THEN_STROKE;
	page.begin_text();
	page.draw_text_out(Vector2(60, ypos - 100), "ABCabc123");
	page.end_text();

//	/* PDF_FILL_CLIPPING */
	show_description (page, 60, ypos - 150,
				"RenderingMode=PDF_FILL_CLIPPING");
	page.g_save();
	page.text_rendering_mode = PDFPage.TEXT_RENDERING_MODE_FILL_CLIPPING;
	page.begin_text();
	page.draw_text_out(Vector2(60, ypos - 150), "ABCabc123");
	page.end_text();
	show_stripe_pattern(page, 60, ypos - 150);
	page.g_restore();

//	/* PDF_STROKE_CLIPPING */
	show_description (page, 60, ypos - 200,
				"RenderingMode=PDF_STROKE_CLIPPING");
	page.g_save();
	page.text_rendering_mode = PDFPage.TEXT_RENDERING_MODE_STROKE_CLIPPING;
	page.begin_text();
	page.draw_text_out(Vector2(60, ypos - 200), "ABCabc123");
	page.end_text();
	show_stripe_pattern(page, 60, ypos - 200);
	page.g_restore();

//	/* PDF_FILL_STROKE_CLIPPING */
	show_description (page, 60, ypos - 250,
				"RenderingMode=PDF_FILL_STROKE_CLIPPING");
	page.g_save();
	page.text_rendering_mode = PDFPage.TEXT_RENDERING_MODE_FILL_STROKE_CLIPPING;
	page.begin_text();
	page.draw_text_out(Vector2(60, ypos - 250), "ABCabc123");
	page.end_text();
	show_stripe_pattern(page, 60, ypos - 250);
	page.g_restore();

//	/* Reset text attributes */
	page.text_rendering_mode = PDFPage.TEXT_RENDERING_MODE_FILL;
	page.rgb_fill = Color(0, 0, 0);
	page.set_font_and_size(font, 30);


//	/*
//	 * Rotating text
//	 */
	float angle1 = 30;                   //* A rotation of 30 degrees. */
	float rad1 = angle1 / 180 * 3.141592; //* Calculate the radian value. */

	show_description (page, 320, ypos - 60, "Rotating text");
	page.begin_text();
	
	Transform2D t = Transform2D();
	t.x = Vector2(cos(rad1), sin(rad1));
	t.y = Vector2(-sin(rad1), cos(rad1));
	t.origin = Vector2(330, ypos - 60);
	page.text_matrix = t;
	page.show_text("ABCabc123");
	page.end_text();

//	/*
//	 * Skewing text.
//	 */
	show_description (page, 320, ypos - 120, "Skewing text");
	page.begin_text();

	angle1 = 10;
	float angle2 = 20;
	rad1 = angle1 / 180 * 3.141592;
	float rad2 = angle2 / 180 * 3.141592;
	
	t.x = Vector2( 1, tan(rad1));
	t.y = Vector2(tan(rad2), 1);
	t.origin = Vector2(320, ypos - 120);
	page.text_matrix = t;
	page.show_text("ABCabc123");
	page.end_text();


//	/*
//	 * scaling text (X direction)
//	 */
	show_description (page, 320, ypos - 175, "Scaling text (X direction)");
	page.begin_text();
	t.x = Vector2(1.5, 0);
	t.y = Vector2(0, 1);
	t.origin = Vector2(320, ypos - 175);
	page.text_matrix = t;
	page.show_text("ABCabc12");
	page.end_text();


//	/*
//	 * scaling text (Y direction)
//	 */
	show_description (page, 320, ypos - 250, "Scaling text (Y direction)");
	page.begin_text();
	t.x = Vector2(1, 0);
	t.y = Vector2(0, 2);
	t.origin = Vector2(320, ypos - 250);
	page.text_matrix = t;
	page.show_text("ABCabc123");
	page.end_text();


//	/*
//	 * char spacing, word spacing
//	 */

	show_description (page, 60, 140, "char-spacing 0");
	show_description (page, 60, 100, "char-spacing 1.5");
	show_description (page, 60, 60, "char-spacing 1.5, word-spacing 2.5");

	page.set_font_and_size(font, 20);
	page.rgb_fill = Color(0.1, 0.3, 0.1);

//	/* char-spacing 0 */
	page.begin_text();
	page.draw_text_out(Vector2(60, 140), samp_text2);
	page.end_text();

//	/* char-spacing 1.5 */
	page.char_space = 1.5;

	page.begin_text();
	page.draw_text_out(Vector2(60, 100), samp_text2);
	page.end_text();

//	/* char-spacing 1.5, word-spacing 3.5 */
	page.word_space = 2.5;

	page.begin_text();
	page.draw_text_out(Vector2(60, 60), samp_text2);
	page.end_text();
	

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

