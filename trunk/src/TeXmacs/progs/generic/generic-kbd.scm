
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : generic-kbd.scm
;; DESCRIPTION : general keyboard shortcuts for all modes
;; COPYRIGHT   : (C) 1999  Joris van der Hoeven
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-module (generic generic-kbd)
  (:use
    (utils edit variants)
    (utils edit auto-close)
    (utils library cursor)
    (generic generic-edit)
    (source source-edit)))

(kbd-map
  ("space" " ")
  ("space tab" (make 'nbsp))
  ("return" (kbd-return))
  ("backspace" (kbd-remove #f))
  ("delete" (kbd-remove #t))
  ("tab" (kbd-tab))
  ("S-space" (insert " "))
  ("S-return" (kbd-shift-return))
  ("S-backspace" (kbd-remove #f))
  ("S-delete" (kbd-remove #t))
  ("C-*" (hidden-variant))
  ("C-backspace" (remove-structure-upwards))
  ("C-delete" (remove-structure-upwards))
  ("C-tab" (variant-circulate #t))
  ("C-S-tab" (variant-circulate #f))
  ("A-*" (toggle-number))
  ("A-space" (make-space "0.2spc"))
  ("A-S-space" (make-space "-0.2spc"))
  ("A-backspace" (structured-remove #f))
  ("A-delete" (structured-remove #t))
  ("A-tab" (make-htab "5mm"))
  ("M-space" (make-space "0.2spc"))
  ("M-S-space" (make-space "-0.2spc"))
  ("M-backspace" (positioning-default))
  ("M-delete" (positioning-default))
  ("M-tab" (make-htab "5mm"))
  ("escape tab" (noop) (make-htab "5mm"))

  ("left" (kbd-left))
  ("right" (kbd-right))
  ("up" (kbd-up))
  ("down" (kbd-down))
  ("home" (kbd-start-line))
  ("end" (kbd-end-line))
  ("pageup" (kbd-page-up))
  ("pagedown" (kbd-page-down))
  ("S-left" (kbd-select kbd-left))
  ("S-right" (kbd-select kbd-right))
  ("S-up" (kbd-select kbd-up))
  ("S-down" (kbd-select kbd-down))
  ("S-home" (kbd-select kbd-start-line))
  ("S-end" (kbd-select kbd-end-line))
  ("S-pageup" (kbd-select kbd-page-up))
  ("S-pagedown" (kbd-select kbd-page-down))
  ("C-left" (traverse-left))
  ("C-right" (traverse-right))
  ("C-up" (traverse-up))
  ("C-down" (traverse-down))
  ("C-home" (traverse-first))
  ("C-end" (traverse-last))
  ("C-pageup" (traverse-previous))
  ("C-pagedown" (traverse-next))
  ("C-section" (traverse-previous-section-title))
  ("C-S-left" (kbd-select traverse-left))
  ("C-S-right" (kbd-select traverse-right))
  ("C-S-up" (kbd-select traverse-up))
  ("C-S-down" (kbd-select traverse-down))
  ("C-S-home" (kbd-select traverse-first))
  ("C-S-end" (kbd-select traverse-last))
  ("C-S-pageup" (kbd-select traverse-previous))
  ("C-S-pagedown" (kbd-select traverse-next))
  ("A-left" (structured-insert #f))
  ("A-right" (structured-insert #t))
  ("A-up" (structured-insert-up))
  ("A-down" (structured-insert-down))
  ("A-home" (structured-insert-start))
  ("A-end" (structured-insert-end))
  ("A-pageup" (structured-insert-top))
  ("A-pagedown" (structured-insert-bottom))
  ("M-left" (positioning-left))
  ("M-right" (positioning-right))
  ("M-up" (positioning-up))
  ("M-down" (positioning-down))
  ("M-home" (positioning-start))
  ("M-end" (positioning-end))
  ("M-pageup" (positioning-top))
  ("M-pagedown" (positioning-bottom))
  ("H-left" (structured-left))
  ("H-right" (structured-right))
  ("H-up" (structured-up))
  ("H-down" (structured-down))
  ("H-home" (structured-first))
  ("H-end" (structured-last))
  ("H-pageup" (structured-top))
  ("H-pagedown" (structured-bottom))
  ("H-(" (structured-exit-left))
  ("H-)" (structured-exit-right))
  ("H-S-left" (kbd-select structured-left))
  ("H-S-right" (kbd-select structured-right))
  ("H-S-up" (kbd-select structured-up))
  ("H-S-down" (kbd-select structured-down))
  ("H-S-home" (kbd-select structured-first))
  ("H-S-end" (kbd-select structured-last))
  ("H-S-pageup" (kbd-select structured-top))
  ("H-S-pagedown" (kbd-select structured-bottom))

  ("<" "<less>")
  (">" "<gtr>")
  ("(" (make-bracket-open "(" ")"))
  (")" (make-bracket-close ")" "("))
  ("[" (make-bracket-open "[" "]"))
  ("]" (make-bracket-close "]" "["))
  ("{" (make-bracket-open "{" "}"))
  ("}" (make-bracket-close "}" "{"))
  ("\\" (if (or (inside? 'hybrid) (in-prog?))
	    (insert "\\")
	    (make-hybrid)))
  ("M-\\" (make-hybrid))
  ("C-<" (cursor-history-backward))
  ("C->" (cursor-history-forward))
  ("accent:hat" "^")
  ("accent:deadhat" "^")
  ("accent:tilde" "~")
  ("accent:acute" "'")
  ("accent:grave" "`")
  ("symbol \\" "\\")
  ("symbol \"" "\"")
  ("symbol $" "$")
  ("symbol &" "&")
  ("symbol #" "#")
  ("symbol �" "�")
  ("symbol %" "%")
  ("symbol _" "_")
  ("symbol ^" "^")
  ("symbol \"" "\""))

(kbd-map ;; inserting tables
  ("table N t" (make 'tabular))
  ("table N T" (make 'tabular*))
  ("table N b" (make 'block))
  ("table N B" (make 'block*)))
