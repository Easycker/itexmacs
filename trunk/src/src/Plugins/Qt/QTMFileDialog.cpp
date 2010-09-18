
/******************************************************************************
* MODULE     : QTMFileDialog.cpp
* DESCRIPTION: QT file choosers
* COPYRIGHT  : (C) 2009 David MICHEL
*******************************************************************************
* This software falls under the GNU general public license version 3 or later.
* It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
* in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
******************************************************************************/

#include "QTMFileDialog.hpp"
#include <QPainter>
#include <QLineEdit>
#include <QIntValidator>
#include "file.hpp"
#include "sys_utils.hpp"
#include "qt_utilities.hpp"
#include "analyze.hpp"
#include "dictionary.hpp"
#include "image_files.hpp"

QTMFileDialog::QTMFileDialog (QWidget * parent, const QString & caption, const QString & directory, const QString & filter)
  : QDialog (parent) {
  setWindowTitle (caption);
  hbox= new QHBoxLayout (this);
  hbox->setContentsMargins (0, 0, 0, 0);
  file= new QMyFileDialog (0, caption, directory, filter);
  hbox->addWidget (file);
  setLayout (hbox);
  connect(file, SIGNAL(accepted()), this, SLOT(accept()));
  connect(file, SIGNAL(finished(int)), this, SLOT(done(int)));
  connect(file, SIGNAL(rejected()), this, SLOT(reject()));
}

static QWidget*
simple_input (string s, QLineEdit* ledit, QWidget* parent= 0) {
  QWidget* widget= new QWidget (parent);
  QHBoxLayout* layout= new QHBoxLayout (widget);
  layout->setContentsMargins (0, 0, 0, 0);
//  string in_lan= get_input_language ();
//  string out_lan= get_output_language ();
//  QLabel* label= new QLabel (to_qstring (tm_var_encode (translate (s, in_lan, out_lan))), parent);
  QLabel* label= new QLabel (to_qstring_utf8 (qt_translate (s)), parent);
  layout->addWidget (label);
  layout->addWidget (ledit);
  widget->setLayout (layout);
  return widget;
}

QTMImagePreview::QTMImagePreview (QWidget* parent)
  : QWidget (parent) {
  QVBoxLayout* vbox= new QVBoxLayout (this);
  vbox->addStretch ();
  image= new QLabel (this);
  image->setMinimumWidth (100);
  image->setAlignment (Qt::AlignCenter);
  vbox->addWidget (image);
  vbox->addSpacing (10);
  wid= new QLineEdit (this);
  vbox->addWidget (simple_input ("Width:", wid, this));
  hei= new QLineEdit (this);
  vbox->addWidget (simple_input ("Height:", hei, this));
  leb= new QLineEdit (this);
  vbox->addWidget (simple_input ("Left border:", leb, this));
  lob= new QLineEdit (this);
  vbox->addWidget (simple_input ("Lower border:", lob, this));
  rib= new QLineEdit (this);
  vbox->addWidget (simple_input ("Right border:", rib, this));
  upb= new QLineEdit (this);
  vbox->addWidget (simple_input ("Upper border:", upb, this));
  vbox->addStretch ();
  vbox->addStretch ();
  setLayout (vbox);
  setMinimumWidth (175);
  setMaximumWidth (225);
  setImage (0);
}

void
QTMImagePreview::setImage (const QString& file) {
  QImage img;
  leb->setText ("");
  lob->setText ("");
  rib->setText ("");
  upb->setText ("");
  if (file.endsWith (".ps") || file.endsWith (".eps")  || file.endsWith (".pdf")) {
    url temp= url_temp (".png");
    url image_url= url_system (scm_unquote (from_qstring (file)));
    int w_pt, h_pt;
    double w, h;
    image_size (image_url, w_pt, h_pt);
    if (w_pt > h_pt) {
      w= 98;
      h= h_pt*98/w_pt;
      if ((int)h < h) h= (int)h+1; else h= (int)h;
    } else {
      w= w_pt*98/h_pt;
      if ((int)w < w) w= (int)w+1; else w= (int)w;
      h= 98;
    }
    wid->setText (to_qstring (as_string (w_pt) * "pt"));
    hei->setText (to_qstring (as_string (h_pt) * "pt"));
    image_to_png (image_url, temp, w, h);
    img.load (to_qstring (as_string (temp)));
    remove (temp);
  } else {
    img.load (file);
    if (!img.isNull()) {
      wid->setText (QString::number (img.width ()) + "px");
      hei->setText (QString::number (img.height ()) + "px");
    } else {
      wid->setText ("");
      hei->setText ("");
    }
  }
  if (img.isNull()) {
    QImage vide (100, 100, QImage::Format_RGB32);
    QPainter painter;
    painter.begin (&vide);
    painter.fillRect (0, 0, 100, 100, Qt::white);
    QPen ThinBlack (Qt::black);
    ThinBlack.setWidth (0);
    ThinBlack.setStyle (Qt::SolidLine);
    painter.setPen (ThinBlack);
    painter.drawLine (0, 0, 99, 99);
    painter.drawLine (0, 99, 99, 0);
    painter.drawRect (0, 0, 99, 99);
    painter.end ();
    image->setPixmap(QPixmap::fromImage(vide));
  } else {
    image->setPixmap(QPixmap::fromImage(img.scaled (98, 98, Qt::KeepAspectRatio, Qt::FastTransformation)));
  }
}

QTMImageDialog::QTMImageDialog (QWidget* parent, const QString& caption, const QString& directory, const QString& filter)
  : QTMFileDialog (parent, caption, directory, filter)
{
  preview= new QTMImagePreview (this);
  hbox->insertWidget(0, preview);
  connect(file, SIGNAL(currentChanged (const QString&)), preview, SLOT(setImage(const QString&)));
}

string
QTMImageDialog::getParamsAsString () {
  string params;
  params << "\"" << from_qstring (preview->wid->text ()) << "\" ";
  params << "\"" << from_qstring (preview->hei->text ()) << "\" ";
  params << "\"" << from_qstring (preview->leb->text ()) << "\" ";
  params << "\"" << from_qstring (preview->lob->text ()) << "\" ";
  params << "\"" << from_qstring (preview->rib->text ()) << "\" ";
  params << "\"" << from_qstring (preview->upb->text ()) << "\"";
  return params;
}
