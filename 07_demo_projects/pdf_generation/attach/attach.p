extends Node;

export(String) String output_pdf_name = "demo.pdf";
export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";

void _ready() {
	PDFDocument pdf = PDFDocument.new();

	PDFPage page = pdf.page_add();
	
	String font_name = pdf.font_load_ttf_from_file(font_file_path, true);
	PDFFont font = pdf.font_get(font_name);

	page.size_set(PDFPage.PAGE_SIZE_LETTER, PDFPage.PAGE_DIRECTION_PORTRAIT);
	
	String text = "This PDF should have an attachment named basn3p08.png";

	page.begin_text();
	page.set_font_and_size(font, 20);
	float tw = page.text_width(text);
	page.move_text_pos((page.width  - tw) / 2, (page.height  - 20) / 2);
	page.show_text(text);
	page.end_text();

//	/* attach a file to the document */
	print(pdf.attach_file("res://pngsuite/basn3p08.png"));

//	/* save the document to a file */
	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}
