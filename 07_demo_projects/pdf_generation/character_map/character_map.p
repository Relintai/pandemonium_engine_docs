extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";

const int PAGE_WIDTH = 420;
const int CELL_HEIGHT = 20;
const int CELL_WIDTH = 20;

void draw_page(PDFPage page, PDFFont title_font, PDFFont font, int h_byte, int l_byte) {
	l_byte = int((l_byte / 16) * 16);
	int h_count = 16 - (l_byte / 16);
	int page_height = 40 + 40 + (h_count + 1) * CELL_HEIGHT;
	
	page.height = page_height;
	page.width = PAGE_WIDTH;

	page.set_font_and_size(title_font, 10);

	int ypos = h_count + 1;
	for (;;) {
		int y = (ypos) * CELL_HEIGHT + 40;

		page.path_move_to(Vector2(40, y));
		page.path_line_to(Vector2(380, y));
		page.path_stroke();
		
		if (ypos < h_count) {
			int chr = 16 - ypos - 1;
			if (chr < 10) {
				chr += ord('0');
			} else {
				chr += (ord('A') - 10);
			}
			String c = char(chr);
			
			float w = page.text_width(c);
			page.begin_text();
			page.move_text_pos(40 + (float(20) - w) / 2, y + 5);
			page.show_text(c);
			page.end_text();
		}

		if (ypos == 0) {
			break;
		}
		
		ypos--;
	}
	
	for (int xpos = 0; xpos <= 17; xpos++) {
		int y = (h_count + 1) * CELL_HEIGHT + 40;
		int x = xpos * CELL_WIDTH + 40;

		page.path_move_to(Vector2(x, 40));
		page.path_line_to(Vector2(x, y));
		page.path_stroke();

		if (xpos > 0 && xpos <= 16) {
			int chr = xpos - 1;
			if (chr < 10) {
				chr += ord('0');
			} else {
				chr += (ord('A') - 10);
			}
			String c = char(chr);

			float w = page.text_width(c);
			page.begin_text();
			page.move_text_pos(x + (float(20) - w) / 2, h_count * CELL_HEIGHT + 45);
			page.show_text(c);
			page.end_text();
		}
	}

	page.set_font_and_size(font, 15);

	ypos = h_count;
	for (;;) {
		int y = (ypos - 1) * CELL_HEIGHT + 45;

		for (int xpos = 0; xpos < 16; xpos++) {
			String buf;

			int x = xpos * CELL_WIDTH + 40 + CELL_WIDTH;

			buf += char(h_byte);
			buf += char((16 - ypos) * 16 + xpos);

			float w = page.text_width(buf);
			if (w > 0) {
				page.begin_text();
				page.move_text_pos(x + (float(20) - w) / 2, y);
				page.show_text(buf);
				page.end_text();
			}
		}

		if (ypos == 0) {
			break;
		}
		
		ypos--;
	}

}


void _ready() {
	String SAMP_TXT = "The quick brown fox jumps over the lazy dog.";
	
	PDFDocument pdf = PDFDocument.new();
//	pdf.new_document();
//	print(pdf.has_document());
	
	// Will not work: (Need explicit path to font file)
	//PDFFont title_font = pdf.font_get("Helvetica");
	
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);
	PDFFont title_font = pdf.font_get(font_name);

	PoolIntArray flg;
	flg.resize(256);

//	/* configure pdf-document (showing outline, compression enabled) */
	pdf.page_mode = PDFDocument.PAGE_MODE_USE_OUTLINE;
	pdf.compression_mode_set(PDFDocument.COMPRESSION_MODE_ALL);
	pdf.pages_set_configuration(10);
	
	pdf.encodings_use_jp();
	pdf.fonts_use_jp();
	pdf.encodings_use_kr();
	pdf.fonts_use_kr();
	pdf.encodings_use_cns();
	pdf.fonts_use_cns();
	pdf.encodings_use_cnt();
	pdf.fonts_use_cnt();
	
	String encoder_type = "KSCms-UHC-H";
	PDFEncoder encoder = pdf.encoder_get(encoder_type);
	print(encoder.get_type());
	if (encoder.get_type() != PDFEncoder.ENCODER_TYPE_DOUBLE_BYTE) {
		print("error: %s is not cmap-encoder\n" % encoder_type);
		return;
	}

	int min_l = 255;
	int min_h = 256;
	int max_l = 0;
	int max_h = 0;

	for (int i = 0; i <= 255; i++) {
		flg[i] = 0;
	}

	for (int i = 0; i <= 255; i++) {
		for (int j = 20; j <= 255; j++) {
			int code = i * 256 + j;

			String buf = String();
			buf += char(i);
			buf += char(j);

			int btype = encoder.get_byte_type(buf, 0);
			int unicode = encoder.get_unicode(code);

			if (btype == PDFEncoder.BYTE_TYPE_LEAD && unicode != 0x25A1) {
				if (min_l > j) {
					min_l = j;
				}
				
				if (max_l < j) {
					max_l = j;
				}
				
				if (min_h > i) {
					min_h = i;
				}
				
				if (max_h < i) {
					max_h = i;
				}
				
				flg[i] = 1;
			}
		}
	}

	print("min_h=%04X max_h=%04X min_l=%04X max_l=%04X\n" % [ min_h, max_h, min_l, max_l ]);

//	/* create outline root. */
	PDFOutline root = pdf.outline_create(null, encoder_type, null);
	root.set_opened(true);

	for (int i = 0; i <= 255; i++) {
		if (flg[i]) {
			PDFPage page = pdf.page_add();
			PDFOutline outline;
			PDFDestination dst;
			
			String buf = "0x%04X-0x%04X" % [ int((i * 256 + min_l)), int((i * 256 + max_l)) ];
			
			outline = pdf.outline_create(root, buf, null);
			dst = page.create_destination();
			outline.set_destination(dst);

			draw_page(page, title_font, font, i, min_l);

			buf = "%s (%s) 0x%04X-0x%04X" % [ encoder_type, font_name, int((i * 256 + min_l)), int((i * 256 + max_l)) ];

			page.set_font_and_size(title_font, 10);
			page.begin_text();
			page.move_text_pos(40, page.height - 35);
			page.show_text(buf);
			page.end_text();
		}
	}

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

