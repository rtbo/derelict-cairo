module imagetest;

import std.stdio;

import derelict.cairo;

import std.stdio;
import std.path;
import std.string;

int main(string [] args) {

    DerelictCairo.load();

	cairo_surface_t * surf = cairo_image_surface_create(
		CAIRO_FORMAT_ARGB32,
		256, 256);

	cairo_t *cr = cairo_create(surf);

	double x=25.6,  y=128.0;
	double x1=102.4, y1=230.4,
       x2=153.6, y2=25.6,
       x3=230.4, y3=128.0;

	cairo_move_to (cr, x, y);
	cairo_curve_to (cr, x1, y1, x2, y2, x3, y3);

	cairo_set_line_width (cr, 10.0);
	cairo_stroke (cr);

	cairo_set_source_rgba (cr, 1, 0.2, 0.2, 0.6);
	cairo_set_line_width (cr, 6.0);
	cairo_move_to (cr,x,y);   cairo_line_to (cr,x1,y1);
	cairo_move_to (cr,x2,y2); cairo_line_to (cr,x3,y3);
	cairo_stroke (cr);

	cairo_surface_flush(surf);

	string filename = expandTilde("~/cairo-d-test.png");
	if (args.length > 1) {
		filename = args[1];
	}

	auto status = cairo_surface_write_to_png(surf, toStringz(filename));

	cairo_surface_destroy(surf);

	if (status != CAIRO_STATUS_SUCCESS) {
		stderr.writeln("writing image to ", filename, " failed with status: ", status);
		return 1;
	}

	return 0;
}
