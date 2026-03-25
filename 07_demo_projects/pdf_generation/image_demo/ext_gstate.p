extends Node;

export(String) String font_file_path = "res://ttfont/PenguinAttack.ttf";
export(bool) bool embed = true;
export(String) String output_pdf_name = "ttfont_demo.pdf";

void show_description(PDFPage page, float x,  float y, String text) {
	page.path_move_to(Vector2(x, y - 10));
	page.path_line_to(Vector2(x, y + 10));
	page.path_move_to(Vector2(x - 10, y));
	page.path_line_to(Vector2(x + 10, y));
	page.path_stroke();
	
	page.set_font_and_size(page.current_font_get(), 8);
	page.rgb_fill = Color(0, 0, 0);
	
	page.begin_text();
	String buf = "(x=%d,y=%d)" % [ int(x), int(y) ];
	page.move_text_pos(x - page.text_width(buf) - 5, y - 10);
	page.show_text(buf);
	page.end_text();

	page.begin_text();
	page.move_text_pos(x - 20, y - 25);
	page.show_text(text);
	page.end_text();
}


void _ready() {
	String SAMP_TXT = "The quick brown fox jumps over the lazy dog.";
	
	PDFDocument pdf = PDFDocument.new();
	
	pdf.compression_mode_set(PDFDocument.COMPRESSION_MODE_ALL);
	
	String font_name = pdf.font_load_ttf_from_file(font_file_path, embed);
	PDFFont font = pdf.font_get(font_name);

// /* add a new page object. */
	PDFPage page = pdf.page_add();
	
	page.width = 550;
	page.height = 500;

	PDFDestination dst = page.create_destination();
	dst.set_xyz(0, page.height, 1);
	pdf.open_action_set(dst);

	page.begin_text();
	page.set_font_and_size(font, 20);
	page.move_text_pos(220, page.height - 70);
	page.show_text("ImageDemo");
	page.end_text();

//	/* load image file. */
	PDFImage image = pdf.image_load_png_from_file("res://pngsuite/basn3p02.png");
//	/* image1 is masked by image2. */
	PDFImage image1 = pdf.image_load_png_from_file("res://pngsuite/basn3p02.png");
//	/* image2 is a mask image. */
	PDFImage image2 = pdf.image_load_png_from_file("res://pngsuite/basn0g01.png");
//	/* image3 is a RGB-color image. we use this image for color-mask demo.
	PDFImage image3 = pdf.image_load_png_from_file("res://pngsuite/maskimage.png");

	float iw = image.get_width();
	float ih = image.get_height();
	
	page.line_width = 0.5;

	float x = 100;
	float y = page.height - 150;

//	/* Draw image to the canvas. (normal-mode with actual size.)*/
	page.draw_image(image, Rect2(x, y, iw, ih));

	show_description(page, x, y, "Actual Size");

	x += 150;

//	/* Scalling image (X direction) */
	page.draw_image(image, Rect2(x, y, iw * 1.5, ih));

	show_description(page, x, y, "Scalling image (X direction)");

	x += 150;

//	/* Scalling image (Y direction). */
	page.draw_image(image, Rect2(x, y, iw, ih * 1.5));
	show_description(page, x, y, "Scalling image (Y direction)");

	x = 100;
	y -= 120;

//	/* Skewing image. */
	float angle1 = 10;
	float angle2 = 20;
	float rad1 = angle1 / 180 * 3.141592;
	float rad2 = angle2 / 180 * 3.141592;
	
	page.g_save();
	
	Transform2D t;
	t.x = Vector2(iw, tan(rad1) * iw);
	t.y = Vector2(tan(rad2) * ih, ih);
	t.origin =  Vector2(x, y);
	page.concat(t);
	
	page.execute_x_object(image.as_x_object());
	page.g_restore();

	show_description(page, x, y, "Skewing image");

	x += 150;

//	/* Rotating image */
	float angle = 30;     // rotation of 30 degrees. */
	float rad = angle / 180 * 3.141592; // Calculate the radian value. */

	page.g_save();

	t.x = Vector2(iw * cos(rad), iw * sin(rad));
	t.y = Vector2(ih * -sin(rad), ih * cos(rad));
	t.origin =  Vector2(x, y);
	page.concat(t);

	page.execute_x_object(image.as_x_object());
	page.g_restore();

	show_description(page, x, y, "Rotating image");

	x += 150;

//	/* draw masked image. */

//	/* Set image2 to the mask image of image1 */
	image1.set_mask_image(image2);

	page.rgb_fill = Color(0, 0, 0);
	page.begin_text();
	page.move_text_pos(x - 6, y + 14);
	page.show_text("MASKMASK");
	page.end_text();

	page.draw_image(image1, Rect2(x - 3, y - 3, iw + 6, ih + 6));

	show_description(page, x, y, "masked image");

	x = 100;
	y -= 120;

//	/* color mask. */
	page.rgb_fill = Color(0, 0, 0);
	page.begin_text();
	page.move_text_pos(x - 6, y + 14);
	page.show_text("MASKMASK");
	page.end_text();
	
	image3.set_color_mask(Vector2i(0, 255), Vector2i(0, 0), Vector2i(0, 255));
	page.draw_image(image3, Rect2(x, y, iw, ih));

	show_description(page, x, y, "Color Mask");

	print("%X" % [ pdf.save_to_file(output_pdf_name) ]);
}

