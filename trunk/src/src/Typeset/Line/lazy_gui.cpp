
/******************************************************************************
* MODULE     : lazy_gui.cpp
* DESCRIPTION: Lazy typesetting of GUI primitives
* COPYRIGHT  : (C) 1999  Joris van der Hoeven
*******************************************************************************
* This software falls under the GNU general public license version 3 or later.
* It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
* in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
******************************************************************************/

#include "Line/lazy_typeset.hpp"
#include "Line/lazy_vstream.hpp"
#include "Format/format.hpp"
#include "Stack/stacker.hpp"
#include "Boxes/construct.hpp"
#include "analyze.hpp"
#include "Concat/canvas_properties.hpp"

/******************************************************************************
* Canvases
******************************************************************************/

struct lazy_canvas_rep: public lazy_rep {
  canvas_properties props;
  lazy par;

  lazy_canvas_rep (canvas_properties props2, lazy par2, path ip):
    lazy_rep (LAZY_CANVAS, ip), props (props2), par (par2) {}
  inline operator tree () { return "Canvas"; }
  lazy produce (lazy_type request, format fm);
  format query (lazy_type request, format fm);
};

struct lazy_canvas {
EXTEND_NULL(lazy,lazy_canvas);
  inline lazy_canvas (canvas_properties props, lazy par, path ip):
    rep (tm_new<lazy_canvas_rep> (props, par, ip)) {
      rep->ref_count= 1; }
};
EXTEND_NULL_CODE(lazy,lazy_canvas);

format
lazy_canvas_rep::query (lazy_type request, format fm) {
  if ((request == LAZY_BOX) && (fm->type == QUERY_VSTREAM_WIDTH)) {
    format body_fm= par->query (request, fm);
    format_width fmw= (format_width) body_fm;
    SI width= fmw->width;
    edit_env env= props->env;
    tree old1= env->local_begin (PAGE_MEDIUM, "papyrus");
    tree old2= env->local_begin (PAR_LEFT, "0tmpt");
    tree old3= env->local_begin (PAR_RIGHT, "0tmpt");
    tree old4= env->local_begin (PAR_MODE, "justify");
    tree old5= env->local_begin (PAR_NO_FIRST, "true");
    tree old6= env->local_begin (PAR_WIDTH, tree (TMLEN, as_string (width)));
    SI x1, x2, scx;
    get_canvas_horizontal (props, 0, fmw->width, x1, x2, scx);
    env->local_end (PAR_WIDTH, old6);
    env->local_end (PAR_NO_FIRST, old5);
    env->local_end (PAR_MODE, old4);
    env->local_end (PAR_RIGHT, old3);
    env->local_end (PAR_LEFT, old2);
    env->local_end (PAGE_MEDIUM, old1);
    SI delta= 0;
    string type= props->type;
    if (type != "plain") {
      SI hpad= props->hpadding;
      SI w   = props->bar_width;
      SI pad = props->bar_padding;
      SI bor = props->border;
      if (ends (type, "w") || ends (type, "e"))
	delta= max (0, w + pad);
      delta += 2 * bor + 2 * hpad;
    }
    return make_format_width (x2 - x1 + delta);
  }
  return lazy_rep::query (request, fm);
}

lazy
lazy_canvas_rep::produce (lazy_type request, format fm) {
  if (request == type) return this;
  if (request == LAZY_VSTREAM || request == LAZY_BOX) {
    SI delta= 0;
    string type= props->type;
    if (type != "plain") {
      SI hpad= props->hpadding;
      SI w   = props->bar_width;
      SI pad = props->bar_padding;
      SI bor = props->border;
      if (ends (type, "w") || ends (type, "e"))
	delta= max (0, w + pad);
      delta += 2 * bor + 2 * hpad;
    }
    format bfm= fm;
    if (request == LAZY_VSTREAM) {
      format_vstream fvs= (format_vstream) fm;
      bfm= make_format_width (fvs->width - delta);
    }
    box b= (box) par->produce (LAZY_BOX, bfm);
    format_width fmw= (format_width) bfm;
    SI width= fmw->width + delta;
    edit_env env= props->env;
    tree old1= env->local_begin (PAGE_MEDIUM, "papyrus");
    tree old2= env->local_begin (PAR_LEFT, "0tmpt");
    tree old3= env->local_begin (PAR_RIGHT, "0tmpt");
    tree old4= env->local_begin (PAR_MODE, "justify");
    tree old5= env->local_begin (PAR_NO_FIRST, "true");
    tree old6= env->local_begin (PAR_WIDTH, tree (TMLEN, as_string (width)));
    SI x1, x2, scx;
    get_canvas_horizontal (props, b->x1, b->x2, x1, x2, scx);
    SI y1, y2, scy;
    get_canvas_vertical (props, b->y1, b->y2, y1, y2, scy);
    env->local_end (PAR_WIDTH, old6);
    env->local_end (PAR_NO_FIRST, old5);
    env->local_end (PAR_MODE, old4);
    env->local_end (PAR_RIGHT, old3);
    env->local_end (PAR_LEFT, old2);
    env->local_end (PAGE_MEDIUM, old1);
    path dip= (type == "plain"? ip: decorate (ip));
    box rb= clip_box (dip, b, x1, y1, x2, y2, props->xt, props->yt, scx, scy);
    if (type != "plain") rb= put_scroll_bars (props, rb, ip, b, scx, scy);
    if (request == LAZY_BOX) return make_lazy_box (rb);
    else {
      array<page_item> l;
      l << page_item (rb);
      return lazy_vstream (ip, "", l, stack_border ());
    }
  }
  return lazy_rep::produce (request, fm);
}

lazy
make_lazy_canvas (edit_env env, tree t, path ip) {
  canvas_properties props= get_canvas_properties (env, t);
  lazy par= make_lazy (env, t[6], descend (ip, 6));
  return lazy_canvas (props, par, ip);
}

/******************************************************************************
* Ornaments
******************************************************************************/

struct lazy_ornament_rep: public lazy_rep {
  edit_env env;             // "current" environment
  lazy par;                 // the ornamented body
  SI w, xpad, ypad;         // spacing parameters
  tree bg;                  // background color or pattern
  color sunny, shadow;      // border colors
  lazy_ornament_rep (edit_env env2, lazy par2, path ip,
		     SI w2, SI xpad2, SI ypad2,
		     tree bg2, color sunny2, color shadow2):
    lazy_rep (LAZY_ORNAMENT, ip), env (env2), par (par2),
    w (w2), xpad (xpad2), ypad (ypad2),
    bg (bg2), sunny (sunny2), shadow (shadow2) {}
  
  inline operator tree () { return "Ornament"; }
  lazy produce (lazy_type request, format fm);
  format query (lazy_type request, format fm);
};

struct lazy_ornament {
EXTEND_NULL(lazy,lazy_ornament);
  lazy_ornament (edit_env env, lazy par, path ip,
		 SI w, SI xpad, SI ypad,
		 tree bg, color sunny, color shadow):
    rep (tm_new<lazy_ornament_rep> (env, par, ip, w, xpad, ypad,
				bg, sunny, shadow)) {
      rep->ref_count= 1; }
};
EXTEND_NULL_CODE(lazy,lazy_ornament);

format
lazy_ornament_rep::query (lazy_type request, format fm) {
  if ((request == LAZY_BOX) && (fm->type == QUERY_VSTREAM_WIDTH)) {
    format body_fm= par->query (request, fm);
    format_width fmw= (format_width) body_fm;
    return make_format_width (fmw->width + 2 * (w + xpad));
  }
  return lazy_rep::query (request, fm);
}

lazy
lazy_ornament_rep::produce (lazy_type request, format fm) {
  if (request == type) return this;
  if (request == LAZY_VSTREAM || request == LAZY_BOX) {
    format bfm= fm;
    if (request == LAZY_VSTREAM) {
      format_vstream fvs= (format_vstream) fm;
      bfm= make_format_width (fvs->width - 2 * (w + xpad));
    }
    box b = (box) par->produce (LAZY_BOX, bfm);
    box hb= highlight_box (ip, b, w, xpad, ypad, bg, sunny, shadow);
    // FIXME: this dirty hack ensures that shoving is correct
    hb= move_box (decorate (ip), hb, 1, 0);
    hb= move_box (decorate (ip), hb, -1, 0);
    // End dirty hack
    if (request == LAZY_BOX) return make_lazy_box (hb);
    else {
      array<page_item> l;
      l << page_item (hb);
      return lazy_vstream (ip, "", l, stack_border ());
    }
  }
  return lazy_rep::produce (request, fm);
}

lazy
make_lazy_ornament (edit_env env, tree t, path ip) {
  SI    w     = env->get_length (ORNAMENT_BORDER);
  SI    xpad  = env->get_length (ORNAMENT_HPADDING);
  SI    ypad  = env->get_length (ORNAMENT_VPADDING);
  tree  bg    = env->read       (ORNAMENT_COLOR);
  color sunny = env->get_color  (ORNAMENT_SUNNY_COLOR);
  color shadow= env->get_color  (ORNAMENT_SHADOW_COLOR);
  lazy  par   = make_lazy (env, t[0], descend (ip, 0));
  return lazy_ornament (env, par, ip, w, xpad, ypad, bg, sunny, shadow);
}
