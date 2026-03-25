extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";

String load_font_from_mem(PDFDocument pdf) {
	File f = File.new();
	f.open(font_file_path, File.READ);
	PoolByteArray buf = f.get_buffer(f.get_len());
	f.close();

	return pdf.load_ttf_font_from_mem(buf, embed);
}

void _ready() {
	String SAMP_TXT = "The quick brown fox jumps over the lazy dog.";
	
	PDFDocument pdf = PDFDocument.new();
//	pdf.new_document();
//	print(pdf.has_document());
	
	// Will not work: (Need explicit path to font file)
	//PDFFont title_font = pdf.font_get("Helvetica");
	
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	print(font_name);
	print("error: %X" % [ pdf.get_error_no() ]);
	print("error det: %X" % [ pdf.get_error_detail() ]);
	print("status: %X" % [ pdf.get_status() ]);
	
	PDFFont title_font = pdf.font_get(font_name);
	
	String detail_font_name = font_name;
	PDFFont detail_font = title_font;
	// or:
	#detail_font_name = load_font_from_mem(pdf);
	#detail_font = pdf.font_get(detail_font_name);

	PDFPage page = pdf.page_add();

	page.set_font_and_size(title_font, 10);

	page.begin_text();

	// Move the position of the text to top of the page.
	page.move_text_pos(10, 190);
	page.show_text(detail_font_name);

	if (embed) {
		page.show_text("(Embedded Subset)");
	}
	
	page.set_font_and_size(detail_font, 15);
	page.move_text_pos(10, -20);
	page.show_text("abcdefghijklmnopqrstuvwxyz");
	page.move_text_pos(0, -20);
	page.show_text("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
	page.move_text_pos(0, -20);
	page.show_text("1234567890");
	page.move_text_pos(0, -20);

	page.set_font_and_size(detail_font, 10);
	page.show_text(SAMP_TXT);
	page.move_text_pos(0, -18);

	page.set_font_and_size(detail_font, 16);
	page.show_text(SAMP_TXT);
	page.move_text_pos(0, -27);

	page.set_font_and_size(detail_font, 23);
	page.show_text(SAMP_TXT);
	page.move_text_pos(0, -36);

	page.set_font_and_size(detail_font, 30);
	page.show_text(SAMP_TXT);
	page.move_text_pos(0, -36);

	float pw = page.text_width(SAMP_TXT);
	float page_height = 210;
	float page_width = pw + 40;

	page.width = page_width;
	page.height = page_height;

	// Finish to print text.
	page.end_text();
	
//	HPDF_Page_SetLineWidth (page, 0.5);
//
//	HPDF_Page_MoveTo (page, 10, page_height - 25);
//	HPDF_Page_LineTo (page, page_width - 10, page_height - 25);
//	HPDF_Page_Stroke (page);
//
//	HPDF_Page_MoveTo (page, 10, page_height - 85);
//	HPDF_Page_LineTo (page, page_width - 10, page_height - 85);
//	HPDF_Page_Stroke (page);

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

