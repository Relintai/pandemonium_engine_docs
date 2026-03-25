extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";

const float PAGE_WIDTH = 600.0;
const float PAGE_HEIGHT = 900.0;

void draw_circles(PDFPage page, String description, float x, float y) {
	page.line_width = 1.0;
	page.rgb_stroke = Color(0.0, 0.0, 0.0);
	page.rgb_fill = Color(1.0, 0.0, 0.0);
	page.path_circle(Vector2(x + 40, y + 40), 40);
	page.path_fill_stroke_close();
	page.rgb_fill = Color(0.0, 1.0, 0.0);
	page.path_circle(Vector2(x + 100, y + 40), 40);
	page.path_fill_stroke_close();
	page.rgb_fill = Color(0.0, 0.0, 1.0);
	page.path_circle(Vector2(x + 70, y + 74.64), 40);
	page.path_fill_stroke_close();

	page.rgb_fill = Color(0.0, 0.0, 0.0);
	page.begin_text();
	page.draw_text_out(Vector2(x + 0.0, y + 130.0), description);
	page.end_text();
}

void _ready() {
	String SAMP_TXT = "The quick brown fox jumps over the lazy dog.";
	
	PDFDocument pdf = PDFDocument.new();
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont hfont = pdf.font_get(font_name);

// /* add a new page object. */
	PDFPage page = pdf.page_add();
	
	page.set_font_and_size(hfont, 10);
	
	page.height = PAGE_HEIGHT;
	page.width = PAGE_WIDTH;

//	/* normal */
	page.g_save();
	draw_circles(page, "normal", 40.0, PAGE_HEIGHT - 170);
	page.g_restore();

//	/* transparency (0.8) */
	page.g_save();
	PDFExtGState gstate = pdf.ext_graphic_state_create();
	gstate.set_alpha_fill(0.8);
	gstate.set_alpha_stroke(0.8);
	page.ext_g_state_set(gstate);
	draw_circles(page, "alpha fill = 0.8", 230.0, PAGE_HEIGHT - 170);
	page.g_restore();

//	/* transparency (0.4) */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_alpha_fill(0.4);
	page.ext_g_state_set(gstate);
	draw_circles(page, "alpha fill = 0.4", 420.0, PAGE_HEIGHT - 170);
	page.g_restore();

//	/* blend-mode=HPDF_BM_MULTIPLY */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_MULTIPLY);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_MULTIPLY", 40.0, PAGE_HEIGHT - 340);
	page.g_restore();

//	/* blend-mode=HPDF_BM_SCREEN */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_SCREEN);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_SCREEN", 230.0, PAGE_HEIGHT - 340);
	page.g_restore();

//	/* blend-mode=HPDF_BM_OVERLAY */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_OVERLAY);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_OVERLAY", 420.0, PAGE_HEIGHT - 340);
	page.g_restore();

//	/* blend-mode=HPDF_BM_DARKEN */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_DARKEN);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_DARKEN", 40.0, PAGE_HEIGHT - 510);
	page.g_restore();

//	/* blend-mode=HPDF_BM_LIGHTEN */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_LIGHTEN);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_LIGHTEN", 230.0, PAGE_HEIGHT - 510);
	page.g_restore();

//	/* blend-mode=HPDF_BM_COLOR_DODGE */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_COLOR_DODGE);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_COLOR_DODGE", 420.0, PAGE_HEIGHT - 510);
	page.g_restore();


//	/* blend-mode=HPDF_BM_COLOR_BUM */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_COLOR_BUM);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_COLOR_BUM", 40.0, PAGE_HEIGHT - 680);
	page.g_restore();

//	/* blend-mode=HPDF_BM_HARD_LIGHT */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_HARD_LIGHT);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_HARD_LIGHT", 230.0, PAGE_HEIGHT - 680);
	page.g_restore();

//	/* blend-mode=HPDF_BM_SOFT_LIGHT */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_SOFT_LIGHT);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_SOFT_LIGHT", 420.0, PAGE_HEIGHT - 680);
	page.g_restore();

//	/* blend-mode=HPDF_BM_DIFFERENCE */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_DIFFERENCE);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_DIFFERENCE", 40.0, PAGE_HEIGHT - 850);
	page.g_restore();

//	/* blend-mode=HPDF_BM_EXCLUSHON */
	page.g_save();
	gstate = pdf.ext_graphic_state_create();
	gstate.set_blend_mode(PDFExtGState.BM_EXCLUSHON);
	page.ext_g_state_set(gstate);
	draw_circles(page, "HPDF_BM_EXCLUSHON", 230.0, PAGE_HEIGHT - 850);
	page.g_restore();

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

