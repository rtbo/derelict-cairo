module derelict.cairo;

public import derelict.cairo.types;
public import derelict.cairo.functions;

import std.conv;


enum CAIRO_VERSION_MAJOR = 1;
enum CAIRO_VERSION_MINOR = 13;
enum CAIRO_VERSION_MICRO = 1;

ulong CAIRO_VERSION_ENCODE(uint major, uint minor, uint micro)
{
    return (major * 10000) + (minor * 100) + (micro);
}


enum ulong CAIRO_VERSION = CAIRO_VERSION_ENCODE(
	CAIRO_VERSION_MAJOR,
    CAIRO_VERSION_MINOR,
    CAIRO_VERSION_MICRO);


string CAIRO_VERSION_STRINGIZE(uint major, uint minor, uint micro)
{
    return to!string(major) ~ "." ~ to!string(minor) ~ "." ~ to!string(micro);
}


enum CAIRO_VERSION_STRING = CAIRO_VERSION_STRINGIZE(
	CAIRO_VERSION_MAJOR,
    CAIRO_VERSION_MINOR,
    CAIRO_VERSION_MICRO);



public __gshared CairoDylibLoader DerelictCairo;

shared static this() {
    DerelictCairo = new CairoDylibLoader();
}



import derelict.util.loader;
import derelict.util.system;

static if( Derelict_OS_Windows )
    enum libNames = "libcairo-2.dll";
else static if( Derelict_OS_Mac )
    enum libNames = "libcairo.dylib";
else static if( Derelict_OS_Posix )
    enum libNames = "libcairo.so.2";
else
    static assert(0, "derelict.cairo is not compatible with your system");



class CairoDylibLoader : SharedLibLoader {

    package this() {
        super(libNames);
    }

    protected override void loadSymbols() {

        bindFunc( cast (void**)&cairo_version, "cairo_version");

        bindFunc( cast (void**)&cairo_version_string, "cairo_version_string");


        /* Functions for manipulating state objects */
        bindFunc( cast (void**)&cairo_create, "cairo_create");

        bindFunc( cast (void**)&cairo_reference, "cairo_reference");

        bindFunc( cast (void**)&cairo_destroy, "cairo_destroy");

        bindFunc( cast (void**)&cairo_get_reference_count, "cairo_get_reference_count");

        bindFunc( cast (void**)&cairo_get_user_data, "cairo_get_user_data");

        bindFunc( cast (void**)&cairo_set_user_data, "cairo_set_user_data");

        bindFunc( cast (void**)&cairo_save, "cairo_save");

        bindFunc( cast (void**)&cairo_restore, "cairo_restore");

        bindFunc( cast (void**)&cairo_push_group, "cairo_push_group");

        bindFunc( cast (void**)&cairo_push_group_with_content, "cairo_push_group_with_content");

        bindFunc( cast (void**)&cairo_pop_group, "cairo_pop_group");

        bindFunc( cast (void**)&cairo_pop_group_to_source, "cairo_pop_group_to_source");



        /* Modify state */
        bindFunc( cast (void**)&cairo_set_operator, "cairo_set_operator");

        bindFunc( cast (void**)&cairo_set_source, "cairo_set_source");

        bindFunc( cast (void**)&cairo_set_source_rgb, "cairo_set_source_rgb");

        bindFunc( cast (void**)&cairo_set_source_rgba, "cairo_set_source_rgba");

        bindFunc( cast (void**)&cairo_set_source_surface, "cairo_set_source_surface");

        bindFunc( cast (void**)&cairo_set_tolerance, "cairo_set_tolerance");


        bindFunc( cast (void**)&cairo_set_antialias, "cairo_set_antialias");

        bindFunc( cast (void**)&cairo_set_fill_rule, "cairo_set_fill_rule");

        bindFunc( cast (void**)&cairo_set_line_width, "cairo_set_line_width");

        bindFunc( cast (void**)&cairo_set_line_cap, "cairo_set_line_cap");


        bindFunc( cast (void**)&cairo_set_line_join, "cairo_set_line_join");

        bindFunc( cast (void**)&cairo_set_dash, "cairo_set_dash");

        bindFunc( cast (void**)&cairo_set_miter_limit, "cairo_set_miter_limit");

        bindFunc( cast (void**)&cairo_translate, "cairo_translate");

        bindFunc( cast (void**)&cairo_scale, "cairo_scale");

        bindFunc( cast (void**)&cairo_rotate, "cairo_rotate");

        bindFunc( cast (void**)&cairo_transform, "cairo_transform");

        bindFunc( cast (void**)&cairo_set_matrix, "cairo_set_matrix");

        bindFunc( cast (void**)&cairo_identity_matrix, "cairo_identity_matrix");

        bindFunc( cast (void**)&cairo_user_to_device, "cairo_user_to_device");

        bindFunc( cast (void**)&cairo_user_to_device_distance, "cairo_user_to_device_distance");

        bindFunc( cast (void**)&cairo_device_to_user, "cairo_device_to_user");

        bindFunc( cast (void**)&cairo_device_to_user_distance, "cairo_device_to_user_distance");

        /* Path creation functions */
        bindFunc( cast (void**)&cairo_new_path, "cairo_new_path");

        bindFunc( cast (void**)&cairo_move_to, "cairo_move_to");

        bindFunc( cast (void**)&cairo_new_sub_path, "cairo_new_sub_path");

        bindFunc( cast (void**)&cairo_line_to, "cairo_line_to");

        bindFunc( cast (void**)&cairo_curve_to, "cairo_curve_to");

        bindFunc( cast (void**)&cairo_arc, "cairo_arc");

        bindFunc( cast (void**)&cairo_arc_negative, "cairo_arc_negative");

        /* XXX: NYI
        void
        cairo_arc_to (cairo_t *cr,
                  double x1, double y1,
                  double x2, double y2,
                  double radius);
        */

        bindFunc( cast (void**)&cairo_rel_move_to, "cairo_rel_move_to");

        bindFunc( cast (void**)&cairo_rel_line_to, "cairo_rel_line_to");

        bindFunc( cast (void**)&cairo_rel_curve_to, "cairo_rel_curve_to");

        bindFunc( cast (void**)&cairo_rectangle, "cairo_rectangle");

        /* XXX: NYI
        void
        cairo_stroke_to_path (cairo_t *cr);
        */

        bindFunc( cast (void**)&cairo_close_path, "cairo_close_path");

        bindFunc( cast (void**)&cairo_path_extents, "cairo_path_extents");

        /* Painting functions */
        bindFunc( cast (void**)&cairo_paint, "cairo_paint");

        bindFunc( cast (void**)&cairo_paint_with_alpha, "cairo_paint_with_alpha");

        bindFunc( cast (void**)&cairo_mask, "cairo_mask");

        bindFunc( cast (void**)&cairo_mask_surface, "cairo_mask_surface");

        bindFunc( cast (void**)&cairo_stroke, "cairo_stroke");

        bindFunc( cast (void**)&cairo_stroke_preserve, "cairo_stroke_preserve");

        bindFunc( cast (void**)&cairo_fill, "cairo_fill");

        bindFunc( cast (void**)&cairo_fill_preserve, "cairo_fill_preserve");

        bindFunc( cast (void**)&cairo_copy_page, "cairo_copy_page");

        bindFunc( cast (void**)&cairo_show_page, "cairo_show_page");

        /* Insideness testing */
        bindFunc( cast (void**)&cairo_in_stroke, "cairo_in_stroke");

        bindFunc( cast (void**)&cairo_in_fill, "cairo_in_fill");

        bindFunc( cast (void**)&cairo_in_clip, "cairo_in_clip");

        /* Rectangular extents */
        bindFunc( cast (void**)&cairo_stroke_extents, "cairo_stroke_extents");

        bindFunc( cast (void**)&cairo_fill_extents, "cairo_fill_extents");

        /* Clipping */
        bindFunc( cast (void**)&cairo_reset_clip, "cairo_reset_clip");

        bindFunc( cast (void**)&cairo_clip, "cairo_clip");

        bindFunc( cast (void**)&cairo_clip_preserve, "cairo_clip_preserve");

        bindFunc( cast (void**)&cairo_clip_extents, "cairo_clip_extents");


        bindFunc( cast (void**)&cairo_copy_clip_rectangle_list, "cairo_copy_clip_rectangle_list");

        bindFunc( cast (void**)&cairo_rectangle_list_destroy, "cairo_rectangle_list_destroy");


        /* Font/Text functions */


        bindFunc( cast (void**)&cairo_glyph_allocate, "cairo_glyph_allocate");

        bindFunc( cast (void**)&cairo_glyph_free, "cairo_glyph_free");



        bindFunc( cast (void**)&cairo_text_cluster_allocate, "cairo_text_cluster_allocate");

        bindFunc( cast (void**)&cairo_text_cluster_free, "cairo_text_cluster_free");



        bindFunc( cast (void**)&cairo_font_options_create, "cairo_font_options_create");

        bindFunc( cast (void**)&cairo_font_options_copy, "cairo_font_options_copy");

        bindFunc( cast (void**)&cairo_font_options_destroy, "cairo_font_options_destroy");

        bindFunc( cast (void**)&cairo_font_options_status, "cairo_font_options_status");

        bindFunc( cast (void**)&cairo_font_options_merge, "cairo_font_options_merge");
        bindFunc( cast (void**)&cairo_font_options_equal, "cairo_font_options_equal");

        bindFunc( cast (void**)&cairo_font_options_hash, "cairo_font_options_hash");

        bindFunc( cast (void**)&cairo_font_options_set_antialias, "cairo_font_options_set_antialias");
        bindFunc( cast (void**)&cairo_font_options_get_antialias, "cairo_font_options_get_antialias");

        bindFunc( cast (void**)&cairo_font_options_set_subpixel_order, "cairo_font_options_set_subpixel_order");
        bindFunc( cast (void**)&cairo_font_options_get_subpixel_order, "cairo_font_options_get_subpixel_order");

        bindFunc( cast (void**)&cairo_font_options_set_hint_style, "cairo_font_options_set_hint_style");
        bindFunc( cast (void**)&cairo_font_options_get_hint_style, "cairo_font_options_get_hint_style");

        bindFunc( cast (void**)&cairo_font_options_set_hint_metrics, "cairo_font_options_set_hint_metrics");
        bindFunc( cast (void**)&cairo_font_options_get_hint_metrics, "cairo_font_options_get_hint_metrics");

        /* This interface is for dealing with text as text, not caring about the
           font object inside the the cairo_t. */

        bindFunc( cast (void**)&cairo_select_font_face, "cairo_select_font_face");

        bindFunc( cast (void**)&cairo_set_font_size, "cairo_set_font_size");

        bindFunc( cast (void**)&cairo_set_font_matrix, "cairo_set_font_matrix");

        bindFunc( cast (void**)&cairo_get_font_matrix, "cairo_get_font_matrix");

        bindFunc( cast (void**)&cairo_set_font_options, "cairo_set_font_options");

        bindFunc( cast (void**)&cairo_get_font_options, "cairo_get_font_options");

        bindFunc( cast (void**)&cairo_set_font_face, "cairo_set_font_face");

        bindFunc( cast (void**)&cairo_get_font_face, "cairo_get_font_face");

        bindFunc( cast (void**)&cairo_set_scaled_font, "cairo_set_scaled_font");

        bindFunc( cast (void**)&cairo_get_scaled_font, "cairo_get_scaled_font");

        bindFunc( cast (void**)&cairo_show_text, "cairo_show_text");

        bindFunc( cast (void**)&cairo_show_glyphs, "cairo_show_glyphs");

        bindFunc( cast (void**)&cairo_show_text_glyphs, "cairo_show_text_glyphs");

        bindFunc( cast (void**)&cairo_text_path, "cairo_text_path");

        bindFunc( cast (void**)&cairo_glyph_path, "cairo_glyph_path");

        bindFunc( cast (void**)&cairo_text_extents, "cairo_text_extents");

        bindFunc( cast (void**)&cairo_glyph_extents, "cairo_glyph_extents");

        bindFunc( cast (void**)&cairo_font_extents, "cairo_font_extents");

        /* Generic identifier for a font style */

        bindFunc( cast (void**)&cairo_font_face_reference, "cairo_font_face_reference");

        bindFunc( cast (void**)&cairo_font_face_destroy, "cairo_font_face_destroy");

        bindFunc( cast (void**)&cairo_font_face_get_reference_count, "cairo_font_face_get_reference_count");

        bindFunc( cast (void**)&cairo_font_face_status, "cairo_font_face_status");

        bindFunc( cast (void**)&cairo_font_face_get_type, "cairo_font_face_get_type");

        bindFunc( cast (void**)&cairo_font_face_get_user_data, "cairo_font_face_get_user_data");

        bindFunc( cast (void**)&cairo_font_face_set_user_data, "cairo_font_face_set_user_data");

        /* Portable interface to general font features. */

        bindFunc( cast (void**)&cairo_scaled_font_create, "cairo_scaled_font_create");

        bindFunc( cast (void**)&cairo_scaled_font_reference, "cairo_scaled_font_reference");

        bindFunc( cast (void**)&cairo_scaled_font_destroy, "cairo_scaled_font_destroy");

        bindFunc( cast (void**)&cairo_scaled_font_get_reference_count, "cairo_scaled_font_get_reference_count");

        bindFunc( cast (void**)&cairo_scaled_font_status, "cairo_scaled_font_status");

        bindFunc( cast (void**)&cairo_scaled_font_get_type, "cairo_scaled_font_get_type");

        bindFunc( cast (void**)&cairo_scaled_font_get_user_data, "cairo_scaled_font_get_user_data");

        bindFunc( cast (void**)&cairo_scaled_font_set_user_data, "cairo_scaled_font_set_user_data");

        bindFunc( cast (void**)&cairo_scaled_font_extents, "cairo_scaled_font_extents");

        bindFunc( cast (void**)&cairo_scaled_font_text_extents, "cairo_scaled_font_text_extents");

        bindFunc( cast (void**)&cairo_scaled_font_glyph_extents, "cairo_scaled_font_glyph_extents");

        bindFunc( cast (void**)&cairo_scaled_font_text_to_glyphs, "cairo_scaled_font_text_to_glyphs");

        bindFunc( cast (void**)&cairo_scaled_font_get_font_face, "cairo_scaled_font_get_font_face");

        bindFunc( cast (void**)&cairo_scaled_font_get_font_matrix, "cairo_scaled_font_get_font_matrix");

        bindFunc( cast (void**)&cairo_scaled_font_get_ctm, "cairo_scaled_font_get_ctm");

        bindFunc( cast (void**)&cairo_scaled_font_get_scale_matrix, "cairo_scaled_font_get_scale_matrix");

        bindFunc( cast (void**)&cairo_scaled_font_get_font_options, "cairo_scaled_font_get_font_options");


        /* Toy fonts */

        bindFunc( cast (void**)&cairo_toy_font_face_create, "cairo_toy_font_face_create");

        bindFunc( cast (void**)&cairo_toy_font_face_get_family, "cairo_toy_font_face_get_family");

        bindFunc( cast (void**)&cairo_toy_font_face_get_slant, "cairo_toy_font_face_get_slant");

        bindFunc( cast (void**)&cairo_toy_font_face_get_weight, "cairo_toy_font_face_get_weight");


        /* User fonts */

        bindFunc( cast (void**)&cairo_user_font_face_create, "cairo_user_font_face_create");

        /* User-font method signatures */

        /* User-font method setters */

        bindFunc( cast (void**)&cairo_user_font_face_set_init_func, "cairo_user_font_face_set_init_func");

        bindFunc( cast (void**)&cairo_user_font_face_set_render_glyph_func, "cairo_user_font_face_set_render_glyph_func");

        bindFunc( cast (void**)&cairo_user_font_face_set_text_to_glyphs_func, "cairo_user_font_face_set_text_to_glyphs_func");

        bindFunc( cast (void**)&cairo_user_font_face_set_unicode_to_glyph_func, "cairo_user_font_face_set_unicode_to_glyph_func");

        /* User-font method getters */

        bindFunc( cast (void**)&cairo_user_font_face_get_init_func, "cairo_user_font_face_get_init_func");

        bindFunc( cast (void**)&cairo_user_font_face_get_render_glyph_func, "cairo_user_font_face_get_render_glyph_func");

        bindFunc( cast (void**)&cairo_user_font_face_get_text_to_glyphs_func, "cairo_user_font_face_get_text_to_glyphs_func");

        bindFunc( cast (void**)&cairo_user_font_face_get_unicode_to_glyph_func, "cairo_user_font_face_get_unicode_to_glyph_func");


        /* Query functions */

        bindFunc( cast (void**)&cairo_get_operator, "cairo_get_operator");

        bindFunc( cast (void**)&cairo_get_source, "cairo_get_source");

        bindFunc( cast (void**)&cairo_get_tolerance, "cairo_get_tolerance");

        bindFunc( cast (void**)&cairo_get_antialias, "cairo_get_antialias");

        bindFunc( cast (void**)&cairo_has_current_point, "cairo_has_current_point");

        bindFunc( cast (void**)&cairo_get_current_point, "cairo_get_current_point");

        bindFunc( cast (void**)&cairo_get_fill_rule, "cairo_get_fill_rule");

        bindFunc( cast (void**)&cairo_get_line_width, "cairo_get_line_width");

        bindFunc( cast (void**)&cairo_get_line_cap, "cairo_get_line_cap");

        bindFunc( cast (void**)&cairo_get_line_join, "cairo_get_line_join");

        bindFunc( cast (void**)&cairo_get_miter_limit, "cairo_get_miter_limit");

        bindFunc( cast (void**)&cairo_get_dash_count, "cairo_get_dash_count");

        bindFunc( cast (void**)&cairo_get_dash, "cairo_get_dash");

        bindFunc( cast (void**)&cairo_get_matrix, "cairo_get_matrix");

        bindFunc( cast (void**)&cairo_get_target, "cairo_get_target");

        bindFunc( cast (void**)&cairo_get_group_target, "cairo_get_group_target");


        bindFunc( cast (void**)&cairo_copy_path, "cairo_copy_path");

        bindFunc( cast (void**)&cairo_copy_path_flat, "cairo_copy_path_flat");

        bindFunc( cast (void**)&cairo_append_path, "cairo_append_path");

        bindFunc( cast (void**)&cairo_path_destroy, "cairo_path_destroy");

        /* Error status queries */

        bindFunc( cast (void**)&cairo_status, "cairo_status");

        bindFunc( cast (void**)&cairo_status_to_string, "cairo_status_to_string");

        /* Backend device manipulation */

        bindFunc( cast (void**)&cairo_device_reference, "cairo_device_reference");


        bindFunc( cast (void**)&cairo_device_get_type, "cairo_device_get_type");

        bindFunc( cast (void**)&cairo_device_status, "cairo_device_status");

        bindFunc( cast (void**)&cairo_device_acquire, "cairo_device_acquire");

        bindFunc( cast (void**)&cairo_device_release, "cairo_device_release");

        bindFunc( cast (void**)&cairo_device_flush, "cairo_device_flush");

        bindFunc( cast (void**)&cairo_device_finish, "cairo_device_finish");

        bindFunc( cast (void**)&cairo_device_destroy, "cairo_device_destroy");

        bindFunc( cast (void**)&cairo_device_get_reference_count, "cairo_device_get_reference_count");

        bindFunc( cast (void**)&cairo_device_get_user_data, "cairo_device_get_user_data");

        bindFunc( cast (void**)&cairo_device_set_user_data, "cairo_device_set_user_data");


        /* Surface manipulation */

        bindFunc( cast (void**)&cairo_surface_create_similar, "cairo_surface_create_similar");

        bindFunc( cast (void**)&cairo_surface_create_similar_image, "cairo_surface_create_similar_image");

        bindFunc( cast (void**)&cairo_surface_map_to_image, "cairo_surface_map_to_image");

        bindFunc( cast (void**)&cairo_surface_unmap_image, "cairo_surface_unmap_image");

        bindFunc( cast (void**)&cairo_surface_create_for_rectangle, "cairo_surface_create_for_rectangle");


        bindFunc( cast (void**)&cairo_surface_create_observer, "cairo_surface_create_observer");


        bindFunc( cast (void**)&cairo_surface_observer_add_paint_callback, "cairo_surface_observer_add_paint_callback");

        bindFunc( cast (void**)&cairo_surface_observer_add_mask_callback, "cairo_surface_observer_add_mask_callback");

        bindFunc( cast (void**)&cairo_surface_observer_add_fill_callback, "cairo_surface_observer_add_fill_callback");

        bindFunc( cast (void**)&cairo_surface_observer_add_stroke_callback, "cairo_surface_observer_add_stroke_callback");

        bindFunc( cast (void**)&cairo_surface_observer_add_glyphs_callback, "cairo_surface_observer_add_glyphs_callback");

        bindFunc( cast (void**)&cairo_surface_observer_add_flush_callback, "cairo_surface_observer_add_flush_callback");

        bindFunc( cast (void**)&cairo_surface_observer_add_finish_callback, "cairo_surface_observer_add_finish_callback");

        bindFunc( cast (void**)&cairo_surface_observer_print, "cairo_surface_observer_print");
        bindFunc( cast (void**)&cairo_surface_observer_elapsed, "cairo_surface_observer_elapsed");

        bindFunc( cast (void**)&cairo_device_observer_print, "cairo_device_observer_print");

        bindFunc( cast (void**)&cairo_device_observer_elapsed, "cairo_device_observer_elapsed");

        bindFunc( cast (void**)&cairo_device_observer_paint_elapsed, "cairo_device_observer_paint_elapsed");

        bindFunc( cast (void**)&cairo_device_observer_mask_elapsed, "cairo_device_observer_mask_elapsed");

        bindFunc( cast (void**)&cairo_device_observer_fill_elapsed, "cairo_device_observer_fill_elapsed");

        bindFunc( cast (void**)&cairo_device_observer_stroke_elapsed, "cairo_device_observer_stroke_elapsed");

        bindFunc( cast (void**)&cairo_device_observer_glyphs_elapsed, "cairo_device_observer_glyphs_elapsed");

        bindFunc( cast (void**)&cairo_surface_reference, "cairo_surface_reference");

        bindFunc( cast (void**)&cairo_surface_finish, "cairo_surface_finish");

        bindFunc( cast (void**)&cairo_surface_destroy, "cairo_surface_destroy");

        bindFunc( cast (void**)&cairo_surface_get_device, "cairo_surface_get_device");

        bindFunc( cast (void**)&cairo_surface_get_reference_count, "cairo_surface_get_reference_count");

        bindFunc( cast (void**)&cairo_surface_status, "cairo_surface_status");

        bindFunc( cast (void**)&cairo_surface_get_type, "cairo_surface_get_type");

        bindFunc( cast (void**)&cairo_surface_get_content, "cairo_surface_get_content");


        version (CairoNoPngFunctions) {}
        else {
            bindFunc( cast (void**)&cairo_surface_write_to_png, "cairo_surface_write_to_png");

            bindFunc( cast (void**)&cairo_surface_write_to_png_stream, "cairo_surface_write_to_png_stream");
        }

        bindFunc( cast (void**)&cairo_surface_get_user_data, "cairo_surface_get_user_data");

        bindFunc( cast (void**)&cairo_surface_set_user_data, "cairo_surface_set_user_data");


        bindFunc( cast (void**)&cairo_surface_get_mime_data, "cairo_surface_get_mime_data");

        bindFunc( cast (void**)&cairo_surface_set_mime_data, "cairo_surface_set_mime_data");

        bindFunc( cast (void**)&cairo_surface_supports_mime_type, "cairo_surface_supports_mime_type");

        bindFunc( cast (void**)&cairo_surface_get_font_options, "cairo_surface_get_font_options");

        bindFunc( cast (void**)&cairo_surface_flush, "cairo_surface_flush");

        bindFunc( cast (void**)&cairo_surface_mark_dirty, "cairo_surface_mark_dirty");

        bindFunc( cast (void**)&cairo_surface_mark_dirty_rectangle, "cairo_surface_mark_dirty_rectangle");

        bindFunc( cast (void**)&cairo_surface_set_device_scale, "cairo_surface_set_device_scale");

        bindFunc( cast (void**)&cairo_surface_get_device_scale, "cairo_surface_get_device_scale");

        bindFunc( cast (void**)&cairo_surface_set_device_offset, "cairo_surface_set_device_offset");

        bindFunc( cast (void**)&cairo_surface_get_device_offset, "cairo_surface_get_device_offset");

        bindFunc( cast (void**)&cairo_surface_set_fallback_resolution, "cairo_surface_set_fallback_resolution");

        bindFunc( cast (void**)&cairo_surface_get_fallback_resolution, "cairo_surface_get_fallback_resolution");

        bindFunc( cast (void**)&cairo_surface_copy_page, "cairo_surface_copy_page");

        bindFunc( cast (void**)&cairo_surface_show_page, "cairo_surface_show_page");

        bindFunc( cast (void**)&cairo_surface_has_show_text_glyphs, "cairo_surface_has_show_text_glyphs");

        /* Image-surface functions */

        bindFunc( cast (void**)&cairo_image_surface_create, "cairo_image_surface_create");

        bindFunc( cast (void**)&cairo_format_stride_for_width, "cairo_format_stride_for_width");

        bindFunc( cast (void**)&cairo_image_surface_create_for_data, "cairo_image_surface_create_for_data");

        bindFunc( cast (void**)&cairo_image_surface_get_data, "cairo_image_surface_get_data");

        bindFunc( cast (void**)&cairo_image_surface_get_format, "cairo_image_surface_get_format");

        bindFunc( cast (void**)&cairo_image_surface_get_width, "cairo_image_surface_get_width");

        bindFunc( cast (void**)&cairo_image_surface_get_height, "cairo_image_surface_get_height");

        bindFunc( cast (void**)&cairo_image_surface_get_stride, "cairo_image_surface_get_stride");

        version (CairoNoPngFunctions) {}
        else {
            bindFunc( cast (void**)&cairo_image_surface_create_from_png, "cairo_image_surface_create_from_png");

            bindFunc( cast (void**)&cairo_image_surface_create_from_png_stream, "cairo_image_surface_create_from_png_stream");

        }

        /* Recording-surface functions */

        bindFunc( cast (void**)&cairo_recording_surface_create, "cairo_recording_surface_create");

        bindFunc( cast (void**)&cairo_recording_surface_ink_extents, "cairo_recording_surface_ink_extents");

        bindFunc( cast (void**)&cairo_recording_surface_get_extents, "cairo_recording_surface_get_extents");


        bindFunc( cast (void**)&cairo_pattern_create_raster_source, "cairo_pattern_create_raster_source");

        bindFunc( cast (void**)&cairo_raster_source_pattern_set_callback_data, "cairo_raster_source_pattern_set_callback_data");

        bindFunc( cast (void**)&cairo_raster_source_pattern_get_callback_data, "cairo_raster_source_pattern_get_callback_data");

        bindFunc( cast (void**)&cairo_raster_source_pattern_set_acquire, "cairo_raster_source_pattern_set_acquire");

        bindFunc( cast (void**)&cairo_raster_source_pattern_get_acquire, "cairo_raster_source_pattern_get_acquire");
        bindFunc( cast (void**)&cairo_raster_source_pattern_set_snapshot, "cairo_raster_source_pattern_set_snapshot");

        bindFunc( cast (void**)&cairo_raster_source_pattern_get_snapshot, "cairo_raster_source_pattern_get_snapshot");

        bindFunc( cast (void**)&cairo_raster_source_pattern_set_copy, "cairo_raster_source_pattern_set_copy");

        bindFunc( cast (void**)&cairo_raster_source_pattern_get_copy, "cairo_raster_source_pattern_get_copy");

        bindFunc( cast (void**)&cairo_raster_source_pattern_set_finish, "cairo_raster_source_pattern_set_finish");

        bindFunc( cast (void**)&cairo_raster_source_pattern_get_finish, "cairo_raster_source_pattern_get_finish");

        /* Pattern creation functions */

        bindFunc( cast (void**)&cairo_pattern_create_rgb, "cairo_pattern_create_rgb");

        bindFunc( cast (void**)&cairo_pattern_create_rgba, "cairo_pattern_create_rgba");

        bindFunc( cast (void**)&cairo_pattern_create_for_surface, "cairo_pattern_create_for_surface");

        bindFunc( cast (void**)&cairo_pattern_create_linear, "cairo_pattern_create_linear");

        bindFunc( cast (void**)&cairo_pattern_create_radial, "cairo_pattern_create_radial");

        bindFunc( cast (void**)&cairo_pattern_create_mesh, "cairo_pattern_create_mesh");

        bindFunc( cast (void**)&cairo_pattern_reference, "cairo_pattern_reference");

        bindFunc( cast (void**)&cairo_pattern_destroy, "cairo_pattern_destroy");

        bindFunc( cast (void**)&cairo_pattern_get_reference_count, "cairo_pattern_get_reference_count");

        bindFunc( cast (void**)&cairo_pattern_status, "cairo_pattern_status");

        bindFunc( cast (void**)&cairo_pattern_get_user_data, "cairo_pattern_get_user_data");

        bindFunc( cast (void**)&cairo_pattern_set_user_data, "cairo_pattern_set_user_data");

        bindFunc( cast (void**)&cairo_pattern_get_type, "cairo_pattern_get_type");

        bindFunc( cast (void**)&cairo_pattern_add_color_stop_rgb, "cairo_pattern_add_color_stop_rgb");

        bindFunc( cast (void**)&cairo_pattern_add_color_stop_rgba, "cairo_pattern_add_color_stop_rgba");

        bindFunc( cast (void**)&cairo_mesh_pattern_begin_patch, "cairo_mesh_pattern_begin_patch");

        bindFunc( cast (void**)&cairo_mesh_pattern_end_patch, "cairo_mesh_pattern_end_patch");

        bindFunc( cast (void**)&cairo_mesh_pattern_curve_to, "cairo_mesh_pattern_curve_to");

        bindFunc( cast (void**)&cairo_mesh_pattern_line_to, "cairo_mesh_pattern_line_to");

        bindFunc( cast (void**)&cairo_mesh_pattern_move_to, "cairo_mesh_pattern_move_to");

        bindFunc( cast (void**)&cairo_mesh_pattern_set_control_point, "cairo_mesh_pattern_set_control_point");

        bindFunc( cast (void**)&cairo_mesh_pattern_set_corner_color_rgb, "cairo_mesh_pattern_set_corner_color_rgb");

        bindFunc( cast (void**)&cairo_mesh_pattern_set_corner_color_rgba, "cairo_mesh_pattern_set_corner_color_rgba");

        bindFunc( cast (void**)&cairo_pattern_set_matrix, "cairo_pattern_set_matrix");

        bindFunc( cast (void**)&cairo_pattern_get_matrix, "cairo_pattern_get_matrix");

        bindFunc( cast (void**)&cairo_pattern_set_extend, "cairo_pattern_set_extend");

        bindFunc( cast (void**)&cairo_pattern_get_extend, "cairo_pattern_get_extend");

        bindFunc( cast (void**)&cairo_pattern_set_filter, "cairo_pattern_set_filter");

        bindFunc( cast (void**)&cairo_pattern_get_filter, "cairo_pattern_get_filter");

        bindFunc( cast (void**)&cairo_pattern_get_rgba, "cairo_pattern_get_rgba");

        bindFunc( cast (void**)&cairo_pattern_get_surface, "cairo_pattern_get_surface");


        bindFunc( cast (void**)&cairo_pattern_get_color_stop_rgba, "cairo_pattern_get_color_stop_rgba");

        bindFunc( cast (void**)&cairo_pattern_get_color_stop_count, "cairo_pattern_get_color_stop_count");

        bindFunc( cast (void**)&cairo_pattern_get_linear_points, "cairo_pattern_get_linear_points");

        bindFunc( cast (void**)&cairo_pattern_get_radial_circles, "cairo_pattern_get_radial_circles");

        bindFunc( cast (void**)&cairo_mesh_pattern_get_patch_count, "cairo_mesh_pattern_get_patch_count");

        bindFunc( cast (void**)&cairo_mesh_pattern_get_path, "cairo_mesh_pattern_get_path");

        bindFunc( cast (void**)&cairo_mesh_pattern_get_corner_color_rgba, "cairo_mesh_pattern_get_corner_color_rgba");

        bindFunc( cast (void**)&cairo_mesh_pattern_get_control_point, "cairo_mesh_pattern_get_control_point");

        /* Matrix functions */

        bindFunc( cast (void**)&cairo_matrix_init, "cairo_matrix_init");

        bindFunc( cast (void**)&cairo_matrix_init_identity, "cairo_matrix_init_identity");

        bindFunc( cast (void**)&cairo_matrix_init_translate, "cairo_matrix_init_translate");

        bindFunc( cast (void**)&cairo_matrix_init_scale, "cairo_matrix_init_scale");

        bindFunc( cast (void**)&cairo_matrix_init_rotate, "cairo_matrix_init_rotate");

        bindFunc( cast (void**)&cairo_matrix_translate, "cairo_matrix_translate");

        bindFunc( cast (void**)&cairo_matrix_scale, "cairo_matrix_scale");

        bindFunc( cast (void**)&cairo_matrix_rotate, "cairo_matrix_rotate");

        bindFunc( cast (void**)&cairo_matrix_invert, "cairo_matrix_invert");

        bindFunc( cast (void**)&cairo_matrix_multiply, "cairo_matrix_multiply");

        bindFunc( cast (void**)&cairo_matrix_transform_distance, "cairo_matrix_transform_distance");

        bindFunc( cast (void**)&cairo_matrix_transform_point, "cairo_matrix_transform_point");

        /* Region functions */

        bindFunc( cast (void**)&cairo_region_create, "cairo_region_create");

        bindFunc( cast (void**)&cairo_region_create_rectangle, "cairo_region_create_rectangle");

        bindFunc( cast (void**)&cairo_region_create_rectangles, "cairo_region_create_rectangles");

        bindFunc( cast (void**)&cairo_region_copy, "cairo_region_copy");

        bindFunc( cast (void**)&cairo_region_reference, "cairo_region_reference");

        bindFunc( cast (void**)&cairo_region_destroy, "cairo_region_destroy");

        bindFunc( cast (void**)&cairo_region_equal, "cairo_region_equal");

        bindFunc( cast (void**)&cairo_region_status, "cairo_region_status");

        bindFunc( cast (void**)&cairo_region_get_extents, "cairo_region_get_extents");

        bindFunc( cast (void**)&cairo_region_num_rectangles, "cairo_region_num_rectangles");

        bindFunc( cast (void**)&cairo_region_get_rectangle, "cairo_region_get_rectangle");

        bindFunc( cast (void**)&cairo_region_is_empty, "cairo_region_is_empty");

        bindFunc( cast (void**)&cairo_region_contains_rectangle, "cairo_region_contains_rectangle");

        bindFunc( cast (void**)&cairo_region_contains_point, "cairo_region_contains_point");

        bindFunc( cast (void**)&cairo_region_translate, "cairo_region_translate");

        bindFunc( cast (void**)&cairo_region_subtract, "cairo_region_subtract");

        bindFunc( cast (void**)&cairo_region_subtract_rectangle, "cairo_region_subtract_rectangle");

        bindFunc( cast (void**)&cairo_region_intersect, "cairo_region_intersect");

        bindFunc( cast (void**)&cairo_region_intersect_rectangle, "cairo_region_intersect_rectangle");

        bindFunc( cast (void**)&cairo_region_union, "cairo_region_union");

        bindFunc( cast (void**)&cairo_region_union_rectangle, "cairo_region_union_rectangle");

        bindFunc( cast (void**)&cairo_region_xor, "cairo_region_xor");

        bindFunc( cast (void**)&cairo_region_xor_rectangle, "cairo_region_xor_rectangle");

        /* Functions to be used while debugging (not intended for use in production code) */
        bindFunc( cast (void**)&cairo_debug_reset_static_data, "cairo_debug_reset_static_data");

    }


}
