
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : init-mathemagix.scm
;; DESCRIPTION : Initialize mathemagix plugin
;; COPYRIGHT   : (C) 1999  Joris van der Hoeven
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-modes
  (in-mathemagix% (== (get-env "prog-language") "mathemagix"))
  (in-prog-mathemagix% #t in-prog% in-mathemagix%)
  (in-mathemagix-math% #t in-mathemagix% in-math%))

(lazy-keyboard (mathemagix-edit) in-prog-mathemagix?)

(kbd-map
  (:mode in-mathemagix-math?)
  ;;("'" "'")
  ("\"" "\""))

(define (mathemagix-initialize)
  (import-from (utils plugins plugin-convert))
  (lazy-input-converter (mathemagix-input) mathemagix))

(define (mathemagix-serialize lan t)
  (import-from (utils plugins plugin-cmd))
  (with u (pre-serialize lan t)
    (with v (texmacs->verbatim (stree->tree u))
      (with w (string-replace v "\n" "/{CR}/")
	(string-append (escape-verbatim w) "\n")))))

(plugin-configure mathemagix
  (:require (url-exists-in-path? "mmx-light"))
  (:serializer ,mathemagix-serialize)
  (:initialize (mathemagix-initialize))
  (:launch "mmx-light --texmacs")
  (:session "Mathemagix"))
