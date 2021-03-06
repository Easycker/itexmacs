
/******************************************************************************
* MODULE     : QTMWidget.hpp
* DESCRIPTION: QT Texmacs widget class
* COPYRIGHT  : (C) 2008 Massimiliano Gubinelli
*******************************************************************************
* This software falls under the GNU general public license version 3 or later.
* It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
* in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
******************************************************************************/

#ifndef QTMWIDGET_HPP
#define QTMWIDGET_HPP

#include "QTMScrollView.hpp"
#include "rectangles.hpp"
#include <QVariant>
#include <QTimer>
#include <QSet>
#include <QLabel>

class simple_widget_rep;
class basic_renderer_rep;

class QTMWidget: public QTMScrollView {
  Q_OBJECT

  rectangles invalid_regions;
  QPixmap backingPixmap;
  
public:

  static QSet<QTMWidget*> all_widgets;
  QPoint backing_pos;

  
  QLabel *imwidget;
  QPoint cursor_pos;
  
  QTMWidget(simple_widget_rep *_wid) ;
  ~QTMWidget();

  inline simple_widget_rep*
  tm_widget() {
    QVariant v= property("texmacs_widget");
    return (simple_widget_rep *)
      (v.canConvert<void*> ()? v.value<void*> (): NULL);
  }

  
  void invalidate_rect (int x1, int y1, int x2, int y2);
  void invalidate_all ();
  void repaint_invalid_regions ();

  void scrollContentsBy(int dx, int dy);
  void setCursorPos(QPoint pos) { cursor_pos = pos; };

protected:
  virtual void paintEvent (QPaintEvent* event);
  virtual void focusInEvent (QFocusEvent* event);
  virtual void focusOutEvent (QFocusEvent* event);
  virtual void keyPressEvent (QKeyEvent* event);
  virtual void inputMethodEvent (QInputMethodEvent* event);
  virtual void mousePressEvent (QMouseEvent* event);
  virtual void mouseReleaseEvent (QMouseEvent* event);
  virtual void mouseMoveEvent (QMouseEvent* event);
  virtual bool event (QEvent *event);
  virtual void resizeEvent (QResizeEvent *event);

  virtual QVariant inputMethodQuery ( Qt::InputMethodQuery query ) const ;
private:
  basic_renderer_rep *getRenderer();
};

#endif // QTMWIDGET_HPP
