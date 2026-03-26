extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";

const int PAGE_WIDTH = 420;
const int PAGE_HEIGHT = 400;
const int CELL_WIDTH = 20;
const int CELL_HEIGHT = 20;


void draw_graph (PDFPage page) {
//	/* Draw 16 X 15 cells */

//	/* Draw vertical lines. */
	page.line_width = 0.5;

	for (int i = 0; i <= 17; i++) {
		int x = i * CELL_WIDTH + 40;
		
		page.path_move_to(Vector2(x, PAGE_HEIGHT - 60));
		page.path_line_to(Vector2(x, 40));
		page.path_stroke();

		if (i > 0 && i <= 16) {
			page.begin_text();
			page.move_text_pos(x + 5, PAGE_HEIGHT - 75);
			String buf = "%X" % (i - 1);
			page.show_text(buf);
			page.end_text();
		}
	}

//	/* Draw horizontal lines. */
	for (int i = 0; i <= 15; i++) {
	   int y = i * CELL_HEIGHT + 40;

		page.path_move_to(Vector2(40, y));
		page.path_line_to(Vector2(PAGE_WIDTH - 40, y));
		page.path_stroke();

		if (i < 14) {
			page.begin_text();
			page.move_text_pos(45, y + 5);
			String buf = "%X" % (15 - i);
			page.show_text(buf);
			page.end_text();
		}
	}
}


void draw_fonts(PDFPage page) {
	page.begin_text();

//	/* Draw all character from 0x20 to 0xFF to the canvas. */
	for (int i = 1; i < 17; i++) {
		for (int j = 1; j < 17; j++) {
			int y = PAGE_HEIGHT - 55 - ((i - 1) * CELL_HEIGHT);
			int x = j * CELL_WIDTH + 50;
			
			int chr = (i - 1) * 16 + (j - 1);
			String buf = char(chr);
			
			if (chr >= 32) {
				float d = x - page.text_width(buf) / 2;
				page.draw_text_out(Vector2(d, y), buf);
			}
		}
	}

	page.end_text();
}


void _ready() {
	String SAMP_TXT = "The quick brown fox jumps over the lazy dog.";
	
	PDFDocument pdf = PDFDocument.new();

	PoolStringArray encodings = [
			"StandardEncoding",
			"MacRomanEncoding",
			"WinAnsiEncoding",
			"ISO8859-2",
			"ISO8859-3",
			"ISO8859-4",
			"ISO8859-5",
			"ISO8859-9",
			"ISO8859-10",
			"ISO8859-13",
			"ISO8859-14",
			"ISO8859-15",
			"ISO8859-16",
			"CP1250",
			"CP1251",
			"CP1252",
			"CP1254",
			"CP1257",
			"KOI8-R",
			"Symbol-Set",
			"ZapfDingbats-Set"
	];

//	/* set compression mode */
	pdf.compression_mode_set(PDFDocument.COMPRESSION_MODE_ALL);

//	/* Set page mode to use outlines. */
	pdf.page_mode = PDFDocument.PAGE_MODE_USE_OUTLINE;

//	/* get default font */

	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);

//	/* load font object */
	font_name = pdf.font_load_type_1_from_file("res://type1/a010013l.afm","res://type1/a010013l.pfb");
	
//	/* create outline root. */
	PDFOutline root = pdf.outline_create(null, "Encoding list", null);
	root.set_opened(true);

	for (int i = 0; i < encodings.size(); ++i) {
		PDFPage page = pdf.page_add();
		
		page.width = PAGE_WIDTH;
		page.height = PAGE_HEIGHT;

		PDFOutline outline = pdf.outline_create(root, encodings[i], null);
		PDFDestination dst = page.create_destination();
		dst.set_xyz(0,page.height, 1);
//		/* HPDF_Destination_SetFitB(dst); */
		outline.set_destination(dst);
		
		page.set_font_and_size(font, 15);
		draw_graph(page);

		page.begin_text();
		page.set_font_and_size(font, 20);
		page.move_text_pos(40, PAGE_HEIGHT - 50);
		page.show_text(encodings[i]);
		page.show_text(" Encoding");
		page.end_text();
		
		PDFFont font2 = null;

		if (encodings[i] == "Symbol-Set") {
			font2 = pdf.font_get("Symbol", String());
		} else if (encodings[i] == "ZapfDingbats-Set") {
			font2 = pdf.font_get("ZapfDingbats", String());
		} else {
			font2 = pdf.font_get(font_name, encodings[i]);
		}
		
		#PDFFont font2 = pdf.font_get(font_name, encodings[i]);
		
		if (!font2) {
			print("Encoding was not found for the given font!");
			pdf.reset_error();
			continue;
		}
		
		page.set_font_and_size(font2, 14);
		draw_fonts(page);
	}

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

