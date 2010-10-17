
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : table-kbd.scm
;; DESCRIPTION : keyboard shortcuts for tables
;; COPYRIGHT   : (C) 1999  Joris van der Hoeven
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-module (table table-kbd)
  (:use (generic generic-kbd)
	(table table-edit)))

(kbd-map
  (:mode in-table?)
  ("table S" (make-subtable))
  ("table H l" (table-set-halign "l"))
  ("table H c" (table-set-halign "c"))
  ("table H r" (table-set-halign "r"))
  ("table H L" (table-set-halign "L"))
  ("table H C" (table-set-halign "C"))
  ("table H R" (table-set-halign "R"))
  ("table H O" (table-set-halign "O"))
  ("table H a" (table-set-automatic-width))
  ("table H p" (table-set-exact-width "1par"))
  ("table H w" (interactive table-set-exact-width))
  ("table H m" (interactive table-set-minimal-width))
  ("table H M" (interactive table-set-maximal-width))
  ("table V b" (table-set-valign "b"))
  ("table V c" (table-set-valign "c"))
  ("table V t" (table-set-valign "t"))
  ("table V f" (table-set-valign "f"))
  ("table V B" (table-set-valign "B"))
  ("table V C" (table-set-valign "C"))
  ("table V T" (table-set-valign "T"))
  ("table V O" (table-set-valign "O"))
  ("table V h" (table-interactive-set "table-height"))
  ("table P =" (interactive table-set-padding))
  ("table P l" (table-interactive-set "table-lsep"))
  ("table P r" (table-interactive-set "table-rsep"))
  ("table P b" (table-interactive-set "table-bsep"))
  ("table P t" (table-interactive-set "table-tsep"))
  ("table B =" (interactive table-set-border))
  ("table B l" (table-interactive-set "table-lborder"))
  ("table B r" (table-interactive-set "table-rborder"))
  ("table B b" (table-interactive-set "table-bborder"))
  ("table B t" (table-interactive-set "table-tborder"))
  ("table O r" (table-interactive-set "table-row-origin"))
  ("table O c" (table-interactive-set "table-col-origin"))
  ("table L r" (table-interactive-set "table-min-rows"))
  ("table L c" (table-interactive-set "table-min-cols"))
  ("table L R" (table-interactive-set "table-max-rows"))
  ("table L C" (table-interactive-set "table-max-cols"))
  ("table home" (table-format-center))
  ("table *" (table-disactivate))
  ("table t" (table-test))

  ("table m c" (set-cell-mode "cell"))
  ("table m h" (set-cell-mode "row"))
  ("table m v" (set-cell-mode "column"))
  ("table m t" (set-cell-mode "table"))
  ("table delete" (cell-del-format ""))
  ("table backspace" (cell-del-format ""))
  ("table h l" (cell-set-halign "l"))
  ("table h L" (cell-set-halign "L"))
  ("table h c" (cell-set-halign "c"))
  ("table h C" (cell-set-halign "C"))
  ("table h r" (cell-set-halign "r"))
  ("table h R" (cell-set-halign "R"))
  ("table h ." (cell-set-halign "L."))
  ("table h ," (cell-set-halign "L,"))
  ("table h o" (cell-set-halign "o"))
  ("table h p" (cell-interactive-set "cell-hpart"))
  ("table h a" (cell-set-automatic-width))
  ("table h m" (interactive cell-set-minimal-width))
  ("table h w" (interactive cell-set-exact-width))
  ("table h M" (interactive cell-set-maximal-width))
  ("table h up" (table-insert-row #f))
  ("table h down" (table-insert-row #t))
  ("table h backspace" (table-remove-row #f))
  ("table h delete" (table-remove-row #t))
  ("table v b" (cell-set-valign "b"))
  ("table v B" (cell-set-valign "B"))
  ("table v c" (cell-set-valign "c"))
  ("table v C" (cell-set-valign "C"))
  ("table v t" (cell-set-valign "t"))
  ("table v T" (cell-set-valign "T"))
  ("table v o" (cell-set-valign "o"))
  ("table v p" (cell-interactive-set "cell-vpart"))
  ("table v a" (cell-set-automatic-height))
  ("table v m" (interactive cell-set-minimal-height))
  ("table v h" (interactive cell-set-exact-height))
  ("table v M" (interactive cell-set-maximal-height))
  ("table v left" (table-insert-column #f))
  ("table v right" (table-insert-column #t))
  ("table v backspace" (table-remove-column #f))
  ("table v delete" (table-remove-column #t))
  ("table p =" (interactive cell-set-padding))
  ("table p l" (cell-interactive-set "cell-lsep"))
  ("table p r" (cell-interactive-set "cell-rsep"))
  ("table p b" (cell-interactive-set "cell-bsep"))
  ("table p t" (cell-interactive-set "cell-tsep"))
  ("table b =" (interactive cell-set-border))
  ("table b l" (cell-interactive-set "cell-lborder"))
  ("table b r" (cell-interactive-set "cell-rborder"))
  ("table b b" (cell-interactive-set "cell-bborder"))
  ("table b t" (cell-interactive-set "cell-tborder"))
  ("table b left" (table-column-decoration #f))
  ("table b right" (table-column-decoration #t))
  ("table b up" (table-row-decoration #f))
  ("table b down" (table-row-decoration #t))
  ("table s" (interactive cell-set-span)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; extra iTeXmacs keymaps
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(kbd-map
  (:mode in-table?)
  ("A-left" (table-insert-column #f))
  ("A-right" (table-insert-column #t))
  ("A-up" (table-insert-row #f))
  ("A-down" (table-insert-row #t))
 )
 