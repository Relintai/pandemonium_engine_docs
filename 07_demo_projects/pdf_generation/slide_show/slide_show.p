extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";

void print_page(PDFPage page, String caption, PDFFont font, int style, PDFPage prev, PDFPage next) {
	float r = randf();
	float g = randf();
	float b = randf();
	
	Rect2 rect;
	PDFDestination dst;
	PDFAnnotationLink annot;
	
	page.width = 800;
	page.height = 600;
	
	page.rgb_fill = Color(r, g, b);
	
	page.path_rectangle(Rect2(0, 0, 800, 600));
	page.path_fill();

	page.rgb_fill = Color(1.0 - r, 1.0 - g, 1.0 - b);

	page.set_font_and_size(font, 30);
	
	page.begin_text();
	
	Transform2D t = Transform2D();
	t.x = Vector2(0.8, 0.0);
	t.y = Vector2(0.0, 1.0);
	t.origin = Vector2(0.0, 0.0);
	
	page.text_matrix = t;
	
	page.draw_text_out(Vector2(50, 530), caption);

	page.text_matrix = Transform2D();
	page.set_font_and_size(font, 20);
	page.draw_text_out(Vector2(55, 300), "Type \"Ctrl+L\" in order to return from full screen mode.");
	page.end_text();

	page.slide_show_set(style, 5.0, 1.0);

	page.set_font_and_size(font, 20);

	if (next) {
		page.begin_text();
		page.draw_text_out(Vector2(680, 50), "Next=>");
		page.end_text();
		
		rect.position = Vector2(680, 70);
		rect.set_end(Vector2(750, 50));
//		rect.left = 680;
//		rect.top = 70;
//		rect.right = 750;
//		rect.bottom = 50;
		
		dst = next.create_destination();
		dst.set_fit();
		annot = page.annotation_link_create(rect, dst);
		annot.set_link_border_style(0, 0, 0);
		annot.set_highlight_mode(PDFAnnotationLink.HIGHLIGHT_MODE_INVERT_BOX);
	} 

	if (prev) {
		page.begin_text();
		page.draw_text_out(Vector2(50, 50), "<=Prev");
		page.end_text();
		
		rect.position = Vector2(50, 70);
		rect.set_end(Vector2(110, 50));
//		rect.left = 50;
//		rect.top = 70;
//		rect.right = 110;
//		rect.bottom = 50;

		dst = prev.create_destination();
		dst.set_fit();
		annot = page.annotation_link_create(rect, dst);
		annot.set_link_border_style(0, 0, 0);
		annot.set_highlight_mode(PDFAnnotationLink.HIGHLIGHT_MODE_INVERT_BOX);
	}
}

void _ready() {
	PDFDocument pdf = PDFDocument.new();
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);
	
	Array page;

//	/* Add 17 pages to the document. */
	for (int i = 0; i < 17; ++i) {
		page.push_back(pdf.page_add());
	}

	print_page(page[0], "PDFPage.TRANSITION_STYLE_WIPE_RIGHT", font, 
			PDFPage.TRANSITION_STYLE_WIPE_RIGHT, null, page[1]);
	print_page(page[1], "PDFPage.TRANSITION_STYLE_WIPE_UP", font, 
			PDFPage.TRANSITION_STYLE_WIPE_UP, page[0], page[2]);
	print_page(page[2], "PDFPage.TRANSITION_STYLE_WIPE_LEFT", font, 
			PDFPage.TRANSITION_STYLE_WIPE_LEFT, page[1], page[3]);
	print_page(page[3], "PDFPage.TRANSITION_STYLE_WIPE_DOWN", font, 
			PDFPage.TRANSITION_STYLE_WIPE_DOWN, page[2], page[4]);
	print_page(page[4], "PDFPage.TRANSITION_STYLE_BARN_DOORS_HORIZONTAL_OUT", font, 
			PDFPage.TRANSITION_STYLE_BARN_DOORS_HORIZONTAL_OUT, page[3], page[5]);
	print_page(page[5], "PDFPage.TRANSITION_STYLE_BARN_DOORS_HORIZONTAL_IN", font, 
			PDFPage.TRANSITION_STYLE_BARN_DOORS_HORIZONTAL_IN, page[4], page[6]);
	print_page(page[6], "PDFPage.TRANSITION_STYLE_BARN_DOORS_VERTICAL_OUT", font, 
			PDFPage.TRANSITION_STYLE_BARN_DOORS_VERTICAL_OUT, page[5], page[7]);
	print_page(page[7], "PDFPage.TRANSITION_STYLE_BARN_DOORS_VERTICAL_IN", font, 
			PDFPage.TRANSITION_STYLE_BARN_DOORS_VERTICAL_IN, page[6], page[8]);
	print_page(page[8], "PDFPage.TRANSITION_STYLE_BOX_OUT", font, 
			PDFPage.TRANSITION_STYLE_BOX_OUT, page[7], page[9]);
	print_page(page[9], "PDFPage.TRANSITION_STYLE_BOX_IN", font, 
			PDFPage.TRANSITION_STYLE_BOX_IN, page[8], page[10]);
	print_page(page[10], "PDFPage.TRANSITION_STYLE_BLINDS_HORIZONTAL", font, 
			PDFPage.TRANSITION_STYLE_BLINDS_HORIZONTAL, page[9], page[11]);
	print_page(page[11], "PDFPage.TRANSITION_STYLE_BLINDS_VERTICAL", font, 
			PDFPage.TRANSITION_STYLE_BLINDS_VERTICAL, page[10], page[12]);
	print_page(page[12], "PDFPage.TRANSITION_STYLE_DISSOLVE", font, 
			PDFPage.TRANSITION_STYLE_DISSOLVE, page[11], page[13]);
	print_page(page[13], "PDFPage.TRANSITION_STYLE_GLITTER_RIGHT", font, 
			PDFPage.TRANSITION_STYLE_GLITTER_RIGHT, page[12], page[14]);
	print_page(page[14], "PDFPage.TRANSITION_STYLE_GLITTER_DOWN", font, 
			PDFPage.TRANSITION_STYLE_GLITTER_DOWN, page[13], page[15]);
	print_page(page[15], "PDFPage.TRANSITION_STYLE_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT", font, 
			PDFPage.TRANSITION_STYLE_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT, page[14], page[16]);
	print_page(page[16], "PDFPage.TRANSITION_STYLE_REPLACE", font, 
			PDFPage.TRANSITION_STYLE_REPLACE, page[15], null);

	pdf.page_mode = PDFDocument.PAGE_MODE_FULL_SCREEN;

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

