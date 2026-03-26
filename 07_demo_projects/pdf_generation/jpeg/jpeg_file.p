extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "jpeg_file_demo.pdf";

void draw_image (PDFDocument pdf, String filename, float x, float y, String text) {
	PDFPage page = pdf.page_get_current();

	PDFImage image = pdf.image_load_jpg_from_file(filename);

	// Draw image to the canvas.
	page.draw_image(image, Rect2(x, y, image.get_width(), image.get_height()));

	// Print the text.
//	page.begin_text();
//	HPDF_Page_SetTextLeading (page, 16);
//	HPDF_Page_MoveTextPos (page, x, y);
//	HPDF_Page_ShowTextNextLine (page, filename);
//	HPDF_Page_ShowTextNextLine (page, text);
//	page.end_text();
}


void _ready() {
	PDFDocument pdf = PDFDocument.new();

	pdf.compression_mode_set(PDFDocument.COMPRESSION_MODE_ALL);

	//PDFFont font = pdf.get_font("Helvetica");
	
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);

	// add a new page object.
	PDFPage page = pdf.page_add();

	page.width = 650;
	page.height = 500;

//	HPDF_Destination dst = HPDF_Page_CreateDestination (page);
//	HPDF_Destination_SetXYZ (dst, 0, HPDF_Page_GetHeight (page), 1);
//	HPDF_SetOpenAction(pdf, dst);

	page.begin_text();
	page.set_font_and_size(font, 20);
	page.move_text_pos(220, page.height - 70);
	page.show_text("JpegDemo");
	page.end_text();

	page.set_font_and_size(font, 12);

	draw_image (pdf, "res://images/rgb.jpg", 70, page.height - 410, "24bit color image");
	draw_image (pdf, "res://images/gray.jpg", 340, page.height - 410, "8bit grayscale image");

	// save the document to a file
	pdf.save_to_file(output_pdf_name);

}
