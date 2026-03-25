extends Reference;
class_name PrintGrid;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";

void print_grid(PDFDocument pdf, PDFPage page) {
	float height = page.height;
	float width = page.width;
	String font_name = pdf.font_load_ttf_from_file(font_file_path, true);
	PDFFont font = pdf.font_get(font_name);

	page.set_font_and_size(font, 5);
	page.gray_fill = 0.5;
	page.gray_stroke = 0.8;

//	/* Draw horizontal lines */
	int y = 0;
	while (y < height) {
		if (y % 10 == 0) {
			page.line_width = 0.5;
		} else {
			if (page.line_width != 0.25) {
				page.line_width = 0.25;
			}
		}

		page.path_move_to(Vector2(0, y));
		page.path_line_to(Vector2(width, y));
		page.path_stroke();

		if (y % 10 == 0 && y > 0) {
			page.gray_stroke = 0.5;

			page.path_move_to(Vector2(0, y));
			page.path_line_to(Vector2(5, y));
			page.path_stroke();

			page.gray_stroke = 0.8;
		}

		y += 5;
	}


//	/* Draw vertical lines */
	int x = 0;
	while (x < width) {
		if (x % 10 == 0) {
			page.line_width = 0.5;
		} else {
			if (page.line_width != 0.25) {
				page.line_width = 0.25;
			}
		}

		page.path_move_to(Vector2(x, 0));
		page.path_line_to(Vector2(x, height));
		page.path_stroke();

		if (x % 50 == 0 && x > 0) {
			page.gray_stroke = 0.5;

			page.path_move_to(Vector2(x, 0));
			page.path_line_to(Vector2(x, 5));
			page.path_stroke();

			page.path_move_to(Vector2(x, height));
			page.path_line_to(Vector2(x, height - 5));
			page.path_stroke();

			page.gray_stroke = 0.8;
		}

		x += 5;
	}

//	/* Draw horizontal text */
	y = 0;
	while (y < height) {
		if (y % 10 == 0 && y > 0) {
			page.begin_text();
			page.move_text_pos(5, y - 2);
			page.show_text(str(y));
			page.end_text();
		}

		y += 5;
	}


//	/* Draw vertical text */
	x = 0;
	while (x < width) {
		if (x % 50 == 0 && x > 0) {
			page.begin_text();
			page.move_text_pos(x, 5);
			page.show_text(str(x));
			page.end_text();

			page.begin_text();
			page.move_text_pos(x, height - 10);
			page.show_text(str(x));
			page.end_text();
		}

		x += 5;
	}

	page.gray_fill = 0;
	page.gray_stroke = 0;
}
