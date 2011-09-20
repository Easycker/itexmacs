
/******************************************************************************
* MODULE     : tree_traverse.cpp
* DESCRIPTION: abstract cursor movement and tree traversal
* COPYRIGHT  : (C) 2005  Joris van der Hoeven
*******************************************************************************
* This software falls under the GNU general public license version 3 or later.
* It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
* in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
******************************************************************************/

#include "tree_traverse.hpp"
#include "drd_std.hpp"
#include "analyze.hpp"
#include "hashset.hpp"
#include "Scheme/object.hpp"

/******************************************************************************
* Accessability
******************************************************************************/

int
minimal_arity (tree t) {
  return the_drd->get_minimal_arity (L(t));
}

int
maximal_arity (tree t) {
  return the_drd->get_maximal_arity (L(t));
}

bool
correct_arity (tree t, int n) {
  return the_drd->correct_arity (L(t), n);
}

int
insert_point (tree t, int i) {
  return the_drd->insert_point (L(t), i, N(t));
}

bool
is_dynamic (tree t) {
  return the_drd->is_dynamic (t, false);
}

bool
is_accessible_child (tree t, int i) {
  return the_drd->is_accessible_child (t, i);
}

array<tree>
accessible_children (tree t) {
  array<tree> a;
  int i, n= N(t);
  for (i=0; i<n; i++)
    if (the_drd->is_accessible_child (t, i))
      a << t[i];
  return a;
}

bool
all_accessible (tree t) {
  if (is_atomic (t)) return false;
  return the_drd->all_accessible (L(t));
}

bool
none_accessible (tree t) {
  if (is_atomic (t)) return false;
  return the_drd->none_accessible (L(t));
}

/******************************************************************************
* Further properties
******************************************************************************/

string
get_name (tree t) {
  return the_drd->get_name (L(t));
}

string
get_long_name (tree t) {
  return the_drd->get_long_name (L(t));
}

string
get_child_name (tree t, int i) {
  return the_drd->get_child_name (t, i);
}

string
get_child_long_name (tree t, int i) {
  return the_drd->get_child_long_name (t, i);
}

string
get_child_type (tree t, int i) {
  return drd_decode_type (the_drd->get_type_child (t, i));
}

/******************************************************************************
* Traversal of a tree
******************************************************************************/

static path
move_any (tree t, path p, bool forward) {
  path q = path_up (p);
  int  l = last_item (p);
  tree st= subtree (t, q);
  if (is_atomic (st)) {
    string s= st->label;
    ASSERT (l >= 0 && l <= N(s), "out of range");
    if (forward) {
      if (l<N(s)) {
	tm_char_forwards (s, l);
	return q * l;
      }
    }
    else {
      if (l>0) {
	tm_char_backwards (s, l);
	return q * l;
      }
    }
  }
  else if ((forward && l==0) || (!forward && l==1)) {
    int i, n= N(st);
    if (forward) {
      for (i=0; i<n; i++)
	if (the_drd->is_accessible_child (st, i))
	  return q * path (i, 0);
    }
    else {
      for (i=n-1; i>=0; i--)
	if (the_drd->is_accessible_child (st, i))
	  return q * path (i, right_index (st[i]));
    }
    return q * (1-l);
  }
  else if (is_nil (q)) return p;

  l = last_item (q);
  q = path_up (q);
  st= subtree (t, q);
  int i, n= N(st);
  if (forward) {
    for (i=l+1; i<n; i++)
      if (the_drd->is_accessible_child (st, i))
	return q * path (i, 0);
  }
  else {
    for (i=l-1; i>=0; i--)
      if (the_drd->is_accessible_child (st, i)) {
	return q * path (i, right_index (st[i]));
    }
  }
  return q * (forward? 1: 0);
}

path next_any (tree t, path p) {
  return move_any (t, p, true); }
path previous_any (tree t, path p) {
  return move_any (t, p, false); }

/******************************************************************************
* Traversal of a valid cursor positions inside a tree
******************************************************************************/

static path
move_valid (tree t, path p, bool forward) {
  ASSERT (is_inside (t, p), "invalid cursor");
  path q= p;
  while (true) {
    path r= move_any (t, q, forward);
    if (r == q) return p;
    if (valid_cursor (t, r)) return r;
    q= r;
  }
}

path next_valid (tree t, path p) {
  return move_valid (t, p, true); }
path previous_valid (tree t, path p) {
  return move_valid (t, p, false); }

static path
move_accessible (tree t, path p, bool forward) {
  ASSERT (is_inside (t, p), "invalid cursor");
  path q= p;
  while (true) {
    path r= move_any (t, q, forward);
    if (r == q) return p;
    if (is_accessible_cursor (t, r)) return r;
    q= r;
  }
}

path next_accessible (tree t, path p) {
  return move_accessible (t, p, true); }
path previous_accessible (tree t, path p) {
  return move_accessible (t, p, false); }

/******************************************************************************
* Word based traversal of a tree
******************************************************************************/

static inline bool
is_iso_alphanum (char c) {
  return is_iso_alpha (c) || is_digit (c);
}

static bool
at_border (tree t, path p, bool forward) {
  tree st= subtree (t, path_up (p));
  int l= last_item (p), n= N(st);
  if (!is_concat (st) && !is_document (st)) return true;
  if ((forward && l!=n-1) || (!forward && l!=0)) return false;
  return at_border (t, path_up (p), forward);
}

static bool
next_is_word (tree t, path p) {
  tree st= subtree (t, path_up (p));
  int l= last_item (p), n= N(st);
  if (!is_concat (st) || l+1 >= n) return false;
  if (is_compound (st[l+1])) return true;
  return st[l+1] != "" && is_iso_alphanum (st[l+1]->label[0]);
}

static path
move_word (tree t, path p, bool forward) {
  while (true) {
    path q= move_valid (t, p, forward);
    int l= last_item (q);
    if (q == p) return p;
    tree st= subtree (t, path_up (q));
    if (is_atomic (st)) {
      string s= st->label;
      int n= N(s);
      if (s == "") return q;
      if (forward && l>0 &&
	  (is_iso_alphanum (s[l-1]) ||
	   (l==n && at_border (t, path_up (q), forward))) &&
	  (l==n || !is_iso_alphanum (s[l])))
	return q;
      if (!forward && l<n &&
	  (is_iso_alphanum (s[l]) ||
	   (l==0 && at_border (t, path_up (q), forward))) &&
	  (l==0 || !is_iso_alphanum (s[l-1])))
	return q;
      if (!forward && l==n && next_is_word (t, path_up (q)))
	return q;
    }
    else {
      if (forward && l==1) return q;
      if (!forward && l==0) return q;
      if (!forward && next_is_word (t, path_up (q)))
	return q;
    }
    p= q;
  }
}

path next_word (tree t, path p) {
  return move_word (t, p, true); }
path previous_word (tree t, path p) {
  return move_word (t, p, false); }

/******************************************************************************
* Node based traversal of a tree
******************************************************************************/

static path
move_node (tree t, path p, bool forward) {
  tree st= subtree (t, path_up (p));
  if (is_atomic (st)) {
    if (forward) p= path_up (p) * N (st->label);
    else p= path_up (p) * 0;
  }
  return move_valid (t, p, forward);
}

path next_node (tree t, path p) {
  return move_node (t, p, true); }
path previous_node (tree t, path p) {
  return move_node (t, p, false); }

/******************************************************************************
* Tag based traversal of a tree
******************************************************************************/

static int
tag_border (tree t, path p) {
  if (none_accessible (subtree (t, path_up (p)))) {
    if (last_item (p) == 0) return -1;
    if (last_item (p) == 1) return 1;
  }
  return 0;
}

static bool
distinct_tag_or_argument (tree t, path p, path q, hashset<int> labs) {
  path c= common (p, q);
  path r= path_up (q);
  if (labs->contains ((int) L (subtree (t, r))) && tag_border (t, q) != 0)
    return true;
  while (!is_nil (r) && (r != c)) {
    r= path_up (r);
    if (labs->contains ((int) L (subtree (t, r)))) return true;
  }
  return false;
}

static bool
acceptable_border (tree t, path p, path q, hashset<int> labs) {
  if (tag_border (t, q) == 0) return true;
  if (!labs->contains ((int) L (subtree (t, path_up (q))))) return true;
  if (tag_border (t, q) < 0) return false;
  return tag_border (t, p) != 0;
}

static int
tag_index (tree t, path p, hashset<int> labs) {
  p= path_up (p);
  while (!is_nil (p)) {
    if (labs->contains ((int) L (subtree (t, path_up (p)))))
      return last_item (p);
    else p= path_up (p);
  }
  return -1;
}

static path
move_tag (tree t, path p, hashset<int> labs, bool forward, bool preserve) {
  path q= p;
  while (true) {
    path r= move_node (t, q, forward);
    if (r == q) return p;
    if (distinct_tag_or_argument (t, p, r, labs) &&
        acceptable_border (t, p, r, labs) &&
	(!preserve || tag_index (t, r, labs) == tag_index (t, p, labs)))
      return r;
    q= r;
  }
}

static hashset<int>
get_labels (scheme_tree t) {
  hashset<int> labs;
  if (is_atomic (t))
    labs->insert ((int) as_tree_label (t->label));
  else {
    int i, n= N(t);
    for (i=0; i<n; i++)
      if (is_atomic (t[i]))
	labs->insert ((int) as_tree_label (t[i]->label));
  }
  return labs;
}

path next_tag (tree t, path p, scheme_tree which) {
  return move_tag (t, p, get_labels (which), true, false); }
path previous_tag (tree t, path p, scheme_tree which) {
  return move_tag (t, p, get_labels (which), false, false); }

path next_tag_same_argument (tree t, path p, scheme_tree which) {
  return move_tag (t, p, get_labels (which), true, true); }
path previous_tag_same_argument (tree t, path p, scheme_tree which) {
  return move_tag (t, p, get_labels (which), false, true); }

/******************************************************************************
* Traverse the children of a node
******************************************************************************/

static path
move_argument (tree t, path p, bool forward) {
  path q = path_up (p);
  int  l = last_item (p);
  tree st= subtree (t, q);
  int i, n= N(st);
  if (forward) {
    for (i=l+1; i<n; i++)
      if (the_drd->is_accessible_child (st, i))
	return start (t, q * i);
  }
  else {
    for (i=l-1; i>=0; i--)
      if (the_drd->is_accessible_child (st, i))
	return end (t, q * i);
  }
  return path ();
}

path next_argument (tree t, path p) {
  return move_argument (t, p, true); }
path previous_argument (tree t, path p) {
  return move_argument (t, p, false); }

/******************************************************************************
* Other routines
******************************************************************************/

static path
search_upwards (tree t, path p, tree_label which) {
  if (is_nil (p) || L (subtree (t, p)) == which) return p;
  else return search_upwards (t, path_up (p), which);
}

bool
inside_same (tree t, path p, path q, tree_label which) {
  return
    search_upwards (t, path_up (p), which) ==
    search_upwards (t, path_up (q), which);
}

bool
more_inside (tree t, path p, path q, tree_label which) {
  return
    search_upwards (t, path_up (q), which) <=
    search_upwards (t, path_up (p), which);
}

/******************************************************************************
* Find sections in document
******************************************************************************/

hashset<tree_label> section_traverse_tags;
hashset<tree_label> section_tags;

void
init_sections () {
  if (N(section_traverse_tags) == 0) {
    section_traverse_tags= hashset<tree_label> ();
    section_traverse_tags->insert (DOCUMENT);
    section_traverse_tags->insert (CONCAT);
    section_traverse_tags->insert (as_tree_label ("ignore"));
    section_traverse_tags->insert (as_tree_label ("show-part"));
    section_traverse_tags->insert (as_tree_label ("hide-part"));
  }
  if (N(section_tags) == 0) {
    eval ("(use-modules (text std-text-drd))");
    object l= eval ("(append (section-tag-list) (section*-tag-list))");
    while (!is_null (l)) {
      section_tags->insert (as_tree_label (as_symbol (car (l))));
      l= cdr (l);
    }
  }
}

path
previous_section_impl (tree t, path p) {
  if (is_atomic (t)) return path ();
  else if (N(t) == 1 && section_tags->contains (L(t)))
    return p * 0;
  else if (section_traverse_tags->contains (L(t))) {
    int i= is_nil (p)? N(t)-1: p->item;
    for (; i>=0; i--) {
      if (!is_nil (p) && i == p->item) {
	path r= previous_section_impl (t[i], p->next);
	if (!is_nil (r)) return path (i, r);
      }
      else {
	path r= previous_section_impl (t[i], path ());
	if (!is_nil (r)) return path (i, r);
      }
    }
  }
  return path ();
}

path
previous_section (tree t, path p) {
  init_sections ();
  path r= previous_section_impl (t, p);
  if (is_nil (r)) return p;
  return path_up (r);
}

void
search_sections (array<tree>& a, tree t) {
  if (is_atomic (t)) return;
  else if (N(t) == 1 && section_tags->contains (L(t))) a << t;
  else if (section_traverse_tags->contains (L(t)))
    for (int i=0; i<N(t); i++)
      search_sections (a, t[i]);
}

array<tree>
search_sections (tree t) {
  init_sections ();
  array<tree> a;
  search_sections (a, t);
  return a;
}