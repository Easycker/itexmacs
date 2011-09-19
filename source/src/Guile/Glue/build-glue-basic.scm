
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : build-glue-basic.scm
;; DESCRIPTION : Building basic glue
;; COPYRIGHT   : (C) 1999  Joris van der Hoeven
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(output-copyright "build-glue-basic.scm")

(build
  ""
  "initialize_glue_basic"

  (texmacs-version-release texmacs_version (string string))
  (version-before? version_inf (bool string string))
  (os-win32? os_win32 (bool))
  (os-mingw? os_mingw (bool))
  (os-macos? os_macos (bool))
  (x-gui? gui_is_x (bool))
  (qt-gui? gui_is_qt (bool))
  (default-look-and-feel default_look_and_feel (string))
  (default-chinese-font default_chinese_font_name (string))
  (default-taiwanese-font default_taiwanese_font_name (string))
  (default-japanese-font default_japanese_font_name (string))
  (default-korean-font default_korean_font_name (string))
  (tm-output tm_output (void string))
  (tm-errput tm_errput (void string))
  (win32-display win32_display (void string))
  (cpp-error cpp_error (void))
  (scheme-dialect scheme_dialect (string))
  (get-texmacs-path get_texmacs_path (string))
  (plugin-list plugin_list (scheme_tree))
  (set-fast-environments set_fast_environments (void bool))
  (font-exists-in-tt? tt_font_exists (bool string))
  (eval-system eval_system (string string))
  (var-eval-system var_eval_system (string string))
  (get-locale-language get_locale_language (string))
  (texmacs-time texmacs_time (int))
  (texmacs-memory mem_used (int))
  (bench-print bench_print (void string))
  (bench-print-all bench_print (void))
  (system-wait system_wait (void string string))
  (set-bibtex-command set_bibtex_command (void string))
  (math-symbol-group math_symbol_group (string string))
  (math-group-members math_group_members (array_string string))
  (math-symbol-type math_symbol_type (string string))
  (object->command as_command (command object))
  (exec-delayed exec_delayed (void object))
  (exec-delayed-pause exec_delayed_pause (void object))
  (notify-preferences-loaded notify_preferences_loaded (void))
  (set-input-language set_input_language (void string))
  (get-input-language get_input_language (string))
  (set-output-language gui_set_output_language (void string))
  (get-output-language get_output_language (string))
  (translate translate (string content))
  (translate-from-to translate (string content string string))
  (tree-translate tree_translate (tree content))
  (tree-translate-from-to tree_translate (tree content string string))
  (color named_color (int string))
  (new-author new_author (double))
  (set-author set_author (void double))
  (get-author get_author (double))
  (debug-set debug_set (void string bool))
  (debug-get debug_get (bool string))
  (cout-buffer cout_buffer (void))
  (cout-unbuffer cout_unbuffer (string))
  (mark-new new_marker (double))

  ;; routines for images
  (image->psdoc image_to_psdoc (string url))

  ;; routines for trees
  (tree->stree tree_to_scheme_tree (scheme_tree tree))
  (stree->tree scheme_tree_to_tree (tree scheme_tree))
  (tree->string coerce_tree_string (string tree))
  (string->tree coerce_string_tree (tree string))
  (tm->tree tree (tree content))
  (tree-atomic? is_atomic (bool tree))
  (tree-compound? is_compound (bool tree))
  (tree-label L (tree_label tree))
  (tree-children A (array_tree tree))
  (tree-arity N (int tree))
  (tree-child-ref tree_ref (tree tree int))
  (tree-child-set! tree_set (tree tree int content))
  (tree-child-insert tree_child_insert (tree content int content))
  (tree-ip obtain_ip (path tree))
  (tree-active? tree_active (bool tree))
  (tree-eq? strong_equal (bool tree tree))
  (subtree subtree (tree tree path))
  (tree-range tree_range (tree tree int int))
  (tree-copy copy (tree tree))
  (tree-append tree_append (tree tree tree))
  (tree-right-index right_index (int tree))
  (tree-label-extension? is_extension (bool tree_label))
  (tree-multi-paragraph? is_multi_paragraph (bool tree))
  (tree-simplify simplify_correct (tree tree))
  (tree-minimal-arity minimal_arity (int tree))
  (tree-maximal-arity maximal_arity (int tree))
  (tree-possible-arity? correct_arity (bool tree int))
  (tree-insert_point insert_point (int tree int))
  (tree-is-dynamic? is_dynamic (bool tree))
  (tree-accessible-child? is_accessible_child (bool tree int))
  (tree-accessible-children accessible_children (array_tree tree))
  (tree-all-accessible? all_accessible (bool content))
  (tree-none-accessible? none_accessible (bool content))
  (tree-name get_name (string content))
  (tree-long-name get_long_name (string content))
  (tree-child-name get_child_name (string content int ))
  (tree-child-long-name get_child_long_name (string content int))
  (tree-child-type get_child_type (string content int))
  (tree-load-inclusion load_inclusion (tree url))
  (tree-as-string tree_as_string (string content))
  (tree-extents tree_extents (tree content))
  (tree-empty? is_empty (bool content))
  (tree-is-buffer? admits_edit_observer (bool tree))
  (tree-search-sections search_sections (array_tree tree))

  (tree-assign tree_assign (tree tree content))
  (tree-var-insert tree_insert (tree tree int content))
  (tree-remove tree_remove (tree tree int int))
  (tree-split tree_split (tree tree int int))
  (tree-join tree_join (tree tree int))
  (tree-assign-node tree_assign_node (tree tree tree_label))
  (tree-insert-node tree_insert_node (tree tree int content))
  (tree-remove-node tree_remove_node (tree tree int))

  (cpp-tree-correct-node correct_node (void tree))
  (cpp-tree-correct-downwards correct_downwards (void tree))
  (cpp-tree-correct-upwards correct_upwards (void tree))

  ;; extra routines for content
  (concat-tokenize-math concat_tokenize (array_tree content))
  (concat-decompose concat_decompose (array_tree content))
  (concat-recompose concat_recompose (tree array_tree))
  (with-like? is_with_like (bool content))
  (with-same-type? with_same_type (bool content content))
  (with-similar-type? with_similar_type (bool content content))
  (with-correct with_correct (tree content))
  (with-correct-superfluous superfluous_with_correct (tree content))
  (invisible-correct-superfluous superfluous_invisible_correct (tree content))
  (invisible-correct-missing missing_invisible_correct (tree content int))
  (automatic-correct automatic_correct (tree content string))
  (manual-correct manual_correct (tree content))
  (tree-upgrade-brackets upgrade_brackets (tree content string))
  (tree-upgrade-big upgrade_big (tree content))
  (tree-downgrade-brackets downgrade_brackets (tree content bool bool))
  (tree-downgrade-big downgrade_big (tree content))
  (math-status-print math_status_print (void))
  (math-status-reset math_status_reset (void))

  ;; paths
  (path-inf? path_inf (bool path path))
  (path-inf-eq? path_inf_eq (bool path path))
  (path-less? path_less (bool path path))
  (path-less-eq? path_less_eq (bool path path))
  (path-start start (path content path))
  (path-end end (path content path))
  (path-next next_valid (path content path))
  (path-previous previous_valid (path content path))
  (path-next-word next_word (path content path))
  (path-previous-word previous_word (path content path))
  (path-next-node next_node (path content path))
  (path-previous-node previous_node (path content path))
  (path-next-tag next_tag (path content path scheme_tree))
  (path-previous-tag previous_tag (path content path scheme_tree))
  (path-next-tag-same-argument next_tag_same_argument
			       (path content path scheme_tree))
  (path-previous-tag-same-argument previous_tag_same_argument
				   (path content path scheme_tree))
  (path-next-argument next_argument (path content path))
  (path-previous-argument previous_argument (path content path))
  (path-previous-section previous_section (path content path))

  ;; links
  (tree->ids get_ids (list_string tree))
  (id->trees get_trees (list_tree string))
  (vertex->links get_links (list_tree content))
  (tree->tree-pointer tree_pointer_new (observer tree))
  (tree-pointer-detach tree_pointer_delete (void observer))
  (tree-pointer->tree obtain_tree (tree observer))
  (current-link-types all_link_types (list_string))
  (get-locus-rendering get_locus_rendering (string string))
  (set-locus-rendering set_locus_rendering (void string string))
  (declare-visited declare_visited (void string))
  (has-been-visited? has_been_visited (bool string))

  ;; routines for strings
  (string-number? is_double (bool string))
  (string-search-forwards search_forwards (int string int string))
  (string-search-backwards search_backwards (int string int string))
  (string-replace replace (string string string string))
  (string-alpha? is_alpha (bool string))
  (string-locase-alpha? is_locase_alpha (bool string))
  (upcase-first upcase_first (string string))
  (locase-first locase_first (string string))
  (upcase-all upcase_all (string string))
  (locase-all locase_all (string string))
  (string-union string_union (string string string))
  (string-minus string_minus (string string string))
  (escape-generic escape_generic (string string))
  (escape-verbatim escape_verbatim (string string))
  (escape-shell escape_sh (string string))
  (string-convert convert (string string string string))
  (utf8->cork utf8_to_cork (string string))
  (cork->utf8 cork_to_utf8 (string string))
  (utf8->html utf8_to_html (string string))
  (tm->xml-name tm_to_xml_name (string string))
  (old-tm->xml-cdata old_tm_to_xml_cdata (string string))
  (tm->xml-cdata tm_to_xml_cdata (object string))
  (xml-name->tm xml_name_to_tm (string string))
  (old-xml-cdata->tm old_xml_cdata_to_tm (string string))
  (xml-unspace xml_unspace (string string bool bool))
  (integer->hexadecimal as_hexadecimal (string int))
  (integer->padded-hexadecimal as_hexadecimal (string int int))
  (hexadecimal->integer from_hexadecimal (int string))

  ;; routines for strings in the TeXmacs encoding
  (string->tmstring tm_encode (string string))
  (tmstring->string tm_decode (string string))
  (tmstring-length tm_string_length (int string))
  (tmstring-ref tm_forward_access (string string int))
  (tmstring-reverse-ref tm_backward_access (string string int))
  (tmstring->list tm_tokenize (array_string string))
  (list->tmstring tm_recompose (string array_string))
  (string-next tm_char_next (int string int))
  (string-previous tm_char_previous (int string int))

  ;; Packrat grammar and parsing tools
  (packrat-define packrat_define (void string string tree))
  (packrat-property packrat_property (void string string string string))
  (packrat-inherit packrat_inherit (void string string))
  (packrat-parse packrat_parse (path string string content))
  (packrat-correct? packrat_correct (bool string string content))
  (packrat-context packrat_context (object string string content path))

  ;; further conversion routines for trees and strings
  (parse-texmacs texmacs_document_to_tree (tree string))
  (serialize-texmacs tree_to_texmacs (string tree))
  (parse-texmacs-snippet texmacs_to_tree (tree string))
  (serialize-texmacs-snippet tree_to_texmacs (string tree))
  (texmacs->stm tree_to_scheme (string tree))
  (stm->texmacs scheme_document_to_tree (tree string))
  (stm-snippet->texmacs scheme_to_tree (tree string))
  (cpp-texmacs->verbatim tree_to_verbatim (string tree bool string))
  (cpp-verbatim-snippet->texmacs verbatim_to_tree (tree string bool string))
  (cpp-verbatim->texmacs verbatim_document_to_tree (tree string bool string))
  (parse-latex parse_latex (tree string))
  (parse-latex-document parse_latex_document (tree string))
  (latex->texmacs latex_to_tree (tree tree))
  (latex-document->texmacs latex_document_to_tree (tree string))
  (parse-xml parse_xml (scheme_tree string))
  (parse-html parse_html (scheme_tree string))
  (parse-bib parse_bib (tree string))
  (upgrade-tmml tmml_upgrade (tree scheme_tree))
  (upgrade-mathml upgrade_mathml (tree content))

  ;; routines for urls
  (string->url url (url string))
  (url url (url string string))
  (url-system url_system (url string))
  (url-none url_none (url))
  (url-any url_wildcard (url))
  (url-wildcard url_wildcard (url string))
  (url-parent url_parent (url))
  (url-append url_concat (url url url))
  (url-or url_or (url url url))
  (url->string as_string (string url))
  (url-none? is_none (bool url))
  (url-rooted-web? is_rooted_web (bool url))
  (url-concat? is_concat (bool url))
  (url-or? is_or (bool url))
  (url-ref url_ref (url url int))
  (url-tail tail (url url))
  (url-suffix suffix (string url))
  (url-glue glue (url url string))
  (url-unglue unglue (url url int))
  (url-relative relative (url url url))
  (url-expand expand (url url))
  (url-factor factor (url url))
  (url-delta delta (url url url))
  (url-secure? is_secure (bool url))
  (url-descends? descends (bool url url))

  (url-complete complete (url url string))
  (url-resolve resolve (url url string))
  (url-resolve-in-path resolve_in_path (url url))
  (url-exists? exists (bool url))
  (url-exists-in-path? exists_in_path (bool url))
  (url-exists-in-tex? exists_in_tex (bool url))
  (url-concretize concretize (string url))
  (url-materialize materialize (string url string))
  (url-test? is_of_type (bool url string))
  (url-regular? is_regular (bool url))
  (url-directory? is_directory (bool url))
  (url-link? is_symbolic_link (bool url))
  (url-newer? is_newer (bool url url))
  (url-last-modified last_modified (int url))
  (url-temp url_temp (url))
  (url-scratch url_scratch (url string string int))
  (url-scratch? is_scratch (bool url))
  (string-save string_save (void string url))
  (string-load string_load (string url))
  (system-move move (void url url))
  (system-copy copy (void url url))
  (system-remove remove (void url))
  (system-mkdir mkdir (void url))
  (system-search-score search_score (int url array_string))
  (system-1 system (void string url))
  (system-2 system (void string url url))

  ;; TeXmacs file system
  (tmfs-set tmfs_set (void string collection))
  (tmfs-reset tmfs_reset (void string collection))
  (tmfs-get tmfs_get (collection string))
  (tmfs-new-save tmfs_save (void string string))
  (tmfs-new-remove tmfs_remove (void string))
  (tmfs-new-load tmfs_load (string string))

  (tmfs-create-ressource tmfs_create_ressource (string))
  (tmfs-ressource-head tmfs_get_head (string string))
  (tmfs-ressource-versions tmfs_get_versions (collection string))
  (tmfs-save-ressource tmfs_save_ressource (void string string properties))
  (tmfs-load-ressource-file tmfs_load_ressource_file (string string))
  (tmfs-load-ressource-properties tmfs_load_ressource_properties
				  (properties string))

  (tmfs-create-user tmfs_create_user (string string))
  (tmfs-search-user tmfs_search_user (collection string))
  (tmfs-set-user tmfs_set_user (void string))
  (tmfs-get-user tmfs_get_user (string))
  (tmfs-allows? tmfs_allows (bool string string))
  (tmfs-set-attributes tmfs_set_attributes (void string properties))
  (tmfs-get-attributes tmfs_get_attributes (properties string))
  (tmfs-add-attributes tmfs_add_attributes (void string properties))
  (tmfs-remove-attributes tmfs_remove_attributes (void string properties))
  (tmfs-change-attributes tmfs_change_attributes (void string properties))
  (tmfs-query tmfs_query (solutions properties))
  (solutions->collection as_collection (collection solutions string))

  (tmfs-create-file tmfs_create_file (string string string))
  (tmfs-create-file-in tmfs_create_file (string string string string))
  (tmfs-search-file tmfs_search_file (collection string))
  (tmfs-save-file tmfs_save_file (void string string))
  (tmfs-load-file tmfs_load_file (string string))
  (tmfs-create-project tmfs_create_project (string string))
  (tmfs-search-project tmfs_search_project (collection string))
  (tmfs-get-file-projects tmfs_get_file_projects (collection string))
  (tmfs-get-project-files tmfs_get_project_files (collection string))
  (tmfs-create-branch tmfs_create_branch (string string string))

  (tmfs-set-root tmfs_set_root (void string url))
  (tmfs-get-root tmfs_get_root (url string))
  (tmfs-import tmfs_import (void url))
  (tmfs-export tmfs_export (void url))

  ;; TeXmacs servers and clients
  (server-start server_start (void))
  (server-stop server_stop (void))
  (server-read server_read (string int))
  (server-write server_write (void int string))
  (client-start client_start (void string))
  (client-stop client_stop (void))
  (client-read client_read (string))
  (client-write client_write (void string))
  (enter-secure-mode enter_secure_mode (void))

  ;; connections to extern systems
  (connection-start connection_start (string string string))
  (connection-status connection_status (int string string))
  (connection-write-string connection_write (void string string string))
  (connection-write connection_write (void string string content))
  (connection-cmd connection_cmd (tree string string string))
  (connection-eval connection_eval (tree string string content))
  (connection-interrupt connection_interrupt (void string string))
  (connection-stop connection_stop (void string string))

  ;; widgets
  (widget-printer printer_widget (widget command url))
  (widget-color-picker color_picker_widget (widget command bool array_tree))
  (widget-extend extend (widget widget array_widget))
  (widget-hmenu horizontal_menu (widget array_widget))
  (widget-vmenu vertical_menu (widget array_widget))
  (widget-tmenu tile_menu (widget array_widget int))
  (widget-minibar-menu minibar_menu (widget array_widget))
  (widget-separator menu_separator (widget bool))
  (widget-menu-group menu_group (widget string int))
  (widget-pulldown-button pulldown_button (widget widget promise_widget))
  (widget-pullright-button pullright_button (widget widget promise_widget))
  (widget-menu-button menu_button (widget widget command string string int))
  (widget-balloon balloon_widget (widget widget widget))
  (widget-empty empty_widget (widget))
  (widget-text text_widget (widget string int int bool))
  (widget-input input_text_widget
		(widget command string array_string int string))
  (widget-xpm xpm_widget (widget url))
  (widget-box box_widget (widget scheme_tree string int bool bool))
  (widget-glue glue_widget (widget bool bool int int))
  (widget-color glue_widget (widget content bool bool int int))
  (widget-hlist horizontal_list (widget array_widget))
  (widget-vlist vertical_list (widget array_widget))
  (object->promise-widget as_promise_widget (promise_widget object))

  ;; windows
  (window-handle window_handle (int))
  (window-create window_create (void int widget string bool))
  (window-delete window_delete (void int))
  (window-show window_show (void int))
  (window-hide window_hide (void int))

  ;; routines for BibTeX
  (bib-add-period bib_add_period (scheme_tree scheme_tree))
  (bib-upcase-first bib_upcase_first (scheme_tree scheme_tree))
  (bib-locase bib_locase (scheme_tree scheme_tree))
  (bib-upcase bib_upcase (scheme_tree scheme_tree))
  (bib-default bib_default (scheme_tree scheme_tree))
  (bib-purify bib_purify (string scheme_tree))
  (bib-text-length bib_text_length (int scheme_tree))
  (bib-prefix bib_prefix (string scheme_tree int))
  (bib-empty? bib_empty (bool scheme_tree string))
  (bib-field bib_field (scheme_tree scheme_tree string))
  (bib-abbreviate bib_abbreviate
		  (scheme_tree scheme_tree scheme_tree scheme_tree)))