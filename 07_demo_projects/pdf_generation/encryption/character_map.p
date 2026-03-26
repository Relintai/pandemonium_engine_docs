extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";

export(String) String text = "This is an encrypt document example.";
export(String) String owner_passwd = "owner";
export(String) String user_passwd = "user";

void _ready() {
	String SAMP_TXT = "The quick brown fox jumps over the lazy dog.";
	
	PDFDocument pdf = PDFDocument.new();

	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);

//	/* add a new page object. */
	PDFPage page = pdf.page_add();
	
	page.size_set(PDFPage.PAGE_SIZE_B5, PDFPage.PAGE_DIRECTION_LANDSCAPE);

	page.begin_text();
	
	page.set_font_and_size(font, 20);

	

	float tw = page.text_width(text);
	page.move_text_pos((page.width - tw) / 2, (page.height  - 20) / 2);
	page.show_text(text);
	page.end_text();
	
	pdf.password_set(owner_passwd, user_passwd);
	
	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

