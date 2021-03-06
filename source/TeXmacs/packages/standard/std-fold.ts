<TeXmacs|1.0.7.7>

<style|<tuple|source|std>>

<\body>
  <active*|<\src-title>
    <src-package|std-fold|1.0>

    <\src-purpose>
      Macros for folding and switches.
    </src-purpose>

    <src-copyright|1998--2005|Joris van der Hoeven>

    <\src-license>
      This software falls under the <hlink|GNU general public license,
      version 3 or later|$TEXMACS_PATH/LICENSE>. It comes WITHOUT ANY
      WARRANTY WHATSOEVER. You should have received a copy of the license
      which the software. If not, see <hlink|http://www.gnu.org/licenses/gpl-3.0.html|http://www.gnu.org/licenses/gpl-3.0.html>.
    </src-license>
  </src-title>>

  <\active*>
    <\src-comment>
      Rendering folding tags.
    </src-comment>
  </active*>

  <assign|render-folded-std|<\macro|button|body>
    <with|par-left|<plus|<value|par-left>|1.5fn>|<style-with|src-compact|none|<\surround|<with|par-first|-1.5fn|<yes-indent>><arg|button>|<hflush>>
      <arg|body>
    </surround>>>
  </macro>>

  <assign|default-padded-normal|<value|padded-normal>>

  <assign|folded-padded-normal|<macro|before|after|body|<\surround|<vspace*|<arg|before>>|<htab|0fn|first><vspace|<arg|after>>>
    <\with|padded-normal|<value|default-padded-normal>>
      <arg|body>
    </with>
  </surround>>>

  <assign|render-folded-env|<\macro|button|body>
    <\surround|<with|par-first|-1.5fn|<yes-indent><arg|button>>|<right-flush>>
      <\with|default-padded-normal|<value|padded-normal>|padded-normal|<value|folded-padded-normal>>
        <arg|body>
      </with>
    </surround>
  </macro>>

  <assign|render-folded-explain|<\macro|title|body>
    <\surround|<no-indent><vspace*|0.5fn>|<vspace|0.5fn><right-flush>>
      <with|font-series|bold|<arg|title>><vspace|0.5fn>

      <arg|body>
    </surround>
  </macro>>

  <assign|render-folded-documentation|<\macro|button|body>
    <\surround||<right-flush><vspace|0.5fn>>
      <arg|body> <arg|button>
    </surround>
  </macro>>

  <assign|render-unfolded-documentation|<\macro|button|body>
    <\surround||<right-flush><arg|button><vspace|0.5fn>>
      <arg|body>
    </surround>
  </macro>>

  <assign|render-folded-grouped|<\macro|button|body>
    <\with|old-color|<value|color>|color|blue>
      <tabular|<tformat|<twith|table-width|1par>|<twith|table-hmode|exact>|<cwith|1|1|2|2|cell-hpart|1>|<cwith|1|1|1|1|cell-lsep|0ln>|<cwith|1|1|1|1|cell-rsep|0ln>|<cwith|1|1|1|1|cell-bsep|0ln>|<cwith|1|1|1|1|cell-tsep|0ln>|<cwith|1|1|1|1|cell-width|20ln>|<cwith|1|1|1|1|cell-hmode|exact>|<cwith|1|1|2|2|cell-hyphen|t>|<table|<row|<cell|<subtable|<tformat|<cwith|1|-1|1|-1|cell-background|pastel
      blue>|<cwith|2|2|2|2|cell-background|>|<cwith|1|-1|1|1|cell-lborder|0.5ln>|<cwith|1|1|1|-1|cell-tborder|0.5ln>|<cwith|3|3|1|-1|cell-bborder|0.5ln>|<cwith|3|3|2|2|cell-rborder|0.5ln>|<cwith|3|3|2|2|cell-tborder|0.5ln>|<cwith|1|1|2|2|cell-rborder|0.5ln>|<cwith|1|1|2|2|cell-bborder|0.5ln>|<cwith|2|2|1|1|cell-rborder|0.5ln>|<cwith|1|-1|2|2|cell-width|6ln>|<cwith|1|-1|2|2|cell-hmode|exact>|<cwith|1|-1|1|-1|cell-lsep|0ln>|<cwith|1|-1|1|-1|cell-rsep|0ln>|<cwith|1|-1|1|-1|cell-bsep|0ln>|<cwith|1|-1|1|-1|cell-tsep|0ln>|<cwith|2|2|1|1|cell-halign|l>|<cwith|1|-1|1|-1|cell-vcorrect|n>|<cwith|2|2|1|-1|cell-vpart|1>|<cwith|1|-1|2|2|cell-hpart|1>|<cwith|1|-1|1|1|cell-width|6ln>|<cwith|1|-1|1|1|cell-hmode|exact>|<cwith|3|3|1|-1|cell-height|6ln>|<cwith|3|3|1|-1|cell-vmode|exact>|<cwith|1|1|1|-1|cell-height|6ln>|<cwith|1|1|1|-1|cell-vmode|exact>|<cwith|1|-1|1|-1|cell-valign|c>|<table|<row|<cell|<arg|button>>|<cell|<arg|button>>>|<row|<cell|<arg|button>>|<cell|<arg|button>>>|<row|<cell|<arg|button>>|<cell|<arg|button>>>>>>>|<\cell>
        <\with|color|<value|old-color>>
          <arg|body>
        </with>
      </cell>>>>>
    </with>
  </macro>>

  <\active*>
    <\src-comment>
      Tags for folding and unfolding.
    </src-comment>
  </active*>

  <assign|folded-plain|<\macro|x|y>
    <\surround||<right-flush>>
      <arg|x>

      <hidden|<arg|y>>
    </surround>
  </macro>>

  <assign|unfolded-plain|<\macro|x|y>
    <\surround||<right-flush>>
      <arg|x>

      <arg|y>
    </surround>
  </macro>>

  <assign|folded-std|<\macro|x|y>
    <\render-folded-std|<action|<resize|<active*|<with|mode|math|<op|\<circ\>>>>|||<maximum|1r|1.5fn>|>|(mouse-unfold)|<arg|x>>>
      <arg|x>

      <hidden|<arg|y>>
    </render-folded-std>
  </macro>>

  <assign|unfolded-std|<\macro|x|y>
    <\render-folded-std|<action|<resize|<active*|<with|mode|math|\<bullet\>>>|||<maximum|1r|1.5fn>|>|(mouse-fold)|<arg|x>>>
      <arg|x>

      <arg|y>
    </render-folded-std>
  </macro>>

  <assign|folded-env|<\macro|x|y>
    <\render-folded-env|<action|<resize|<specific|screen|<active*|<with|mode|math|<op|\<circ\>>>>>|||<maximum|1r|1.5fn>|>|(mouse-unfold)|<arg|x>>>
      <arg|x>

      <hidden|<arg|y>>
    </render-folded-env>
  </macro>>

  <assign|unfolded-env|<\macro|x|y>
    <\render-folded-env|<action|<resize|<specific|screen|<active*|<with|mode|math|\<bullet\>>>>|||<maximum|1r|1.5fn>|>|(mouse-fold)|<arg|x>>>
      <arg|x>

      <arg|y>
    </render-folded-env>
  </macro>>

  <assign|folded-explain|<\macro|x|y>
    <\render-folded-explain|<with|color*|<value|color>|<action|<with|color|<value|color*>|<arg|x>>|(mouse-unfold)|<arg|x>>>>
      <hidden|<arg|y>>
    </render-folded-explain>
  </macro>>

  <assign|unfolded-explain|<\macro|x|y>
    <\render-folded-explain|<with|color*|<value|color>|<action|<with|color|<value|color*>|<arg|x>>|(mouse-fold)|<arg|x>>>>
      <arg|y>
    </render-folded-explain>
  </macro>>

  <assign|folded-documentation|<\macro|x|y>
    <\render-folded-documentation|<action|<with|color|#336666|<strong|<large|<math|<op|\<ldots\>>>>>>|(mouse-unfold)|<arg|x>>>
      <strong|<large|<arg|x>>><hidden|<arg|y>>
    </render-folded-documentation>
  </macro>>

  <assign|unfolded-documentation|<\macro|x|y>
    <\render-unfolded-documentation|<action|<with|color|#336666|<strong|<math|<op|\<Leftarrow\>>>>>|(mouse-fold)|<arg|x>>>
      <strong|<large|<arg|x>>>

      <arg|y>
    </render-unfolded-documentation>
  </macro>>

  <assign|folded-grouped|<\macro|x|y>
    <\render-folded-grouped|<action| |(mouse-unfold)|<arg|x>>>
      <arg|x>

      <hidden|<arg|y>>
    </render-folded-grouped>
  </macro>>

  <assign|unfolded-grouped|<\macro|x|y>
    <\render-folded-grouped|<action| |(mouse-fold)|<arg|x>>>
      <arg|x>

      <arg|y>
    </render-folded-grouped>
  </macro>>

  <assign|folded|<value|folded-std>>

  <assign|unfolded|<value|unfolded-std>>

  \;

  <drd-props|folded-plain|arity|2|accessible|0|hidden|1>

  <drd-props|folded-std|arity|2|accessible|0|hidden|1>

  <drd-props|folded-env|arity|2|accessible|0|hidden|1>

  <drd-props|folded-explain|arity|2|accessible|0|hidden|1>

  <drd-props|folded-documentation|arity|2|accessible|0|hidden|1>

  <drd-props|folded-grouped|arity|2|accessible|0|hidden|1>

  <drd-props|folded|arity|2|accessible|0|hidden|1>

  <\active*>
    <\src-comment>
      Tags for toggling between summarized and detailed text.
    </src-comment>
  </active*>

  <assign|summarized-plain|<\macro|x|y>
    <\surround||<right-flush>>
      <arg|x>
    </surround>
  </macro>>

  <assign|detailed-plain|<\macro|x|y>
    <\surround||<right-flush>>
      <arg|y>
    </surround>
  </macro>>

  <assign|summarized-std|<\macro|x|y>
    <\render-folded-std|<action|<resize|<specific|screen|<active*|<with|mode|math|<op|\<circ\>>>>>|||<maximum|1r|1.5fn>|>|(mouse-unfold)|<arg|x>>>
      <arg|x>
    </render-folded-std>
  </macro>>

  <assign|detailed-std|<\macro|x|y>
    <\render-folded-std|<action|<resize|<specific|screen|<active*|<with|mode|math|\<bullet\>>>>|||<maximum|1r|1.5fn>|>|(mouse-fold)|<arg|x>>>
      <arg|y>
    </render-folded-std>
  </macro>>

  <assign|summarized-env|<\macro|x|y>
    <\render-folded-env|<action|<resize|<specific|screen|<active*|<with|mode|math|<op|\<circ\>>>>>|||<maximum|1r|1.5fn>|>|(mouse-unfold)|<arg|x>>>
      <arg|x>
    </render-folded-env>
  </macro>>

  <assign|detailed-env|<\macro|x|y>
    <\render-folded-env|<action|<resize|<specific|screen|<active*|<with|mode|math|\<bullet\>>>>|||<maximum|1r|1.5fn>|>|(mouse-fold)|<arg|x>>>
      <arg|y>
    </render-folded-env>
  </macro>>

  <assign|summarized-grouped|<\macro|x|y>
    <\render-folded-grouped|<action| |(mouse-unfold)|<arg|x>>>
      <arg|x>
    </render-folded-grouped>
  </macro>>

  <assign|detailed-grouped|<\macro|x|y>
    <\render-folded-grouped|<action| |(mouse-fold)|<arg|x>>>
      <arg|y>
    </render-folded-grouped>
  </macro>>

  <assign|summarized-documentation|<\macro|x|y>
    <\render-folded-documentation|<action|<with|color|#336666|<strong|<large|<math|<op|\<ldots\>>>>>>|(mouse-unfold)|<arg|x>>>
      <strong|<large|<arg|x>>>
    </render-folded-documentation>
  </macro>>

  <assign|detailed-documentation|<\macro|x|y>
    <\render-unfolded-documentation|<action|<with|color|#336666|<strong|<math|<op|\<Leftarrow\>>>>>|(mouse-fold)|<arg|x>>>
      <arg|y>
    </render-unfolded-documentation>
  </macro>>

  <assign|summarized-raw|<macro|x|y|<arg|x>>>

  <assign|detailed-raw|<macro|x|y|<arg|y>>>

  <assign|unfold-summarized|<macro|x|<action|<arg|x>|(mouse-unfold)|<arg|x>>>>

  <assign|fold-detailed|<macro|x|<action|<arg|x>|(mouse-fold)|<arg|x>>>>

  <assign|summarized-tiny|<macro|x|y|<action|<arg|x>|(mouse-unfold)|<arg|x>>>>

  <assign|detailed-tiny|<macro|x|y|<arg|y>>>

  <assign|summarized|<value|summarized-env>>

  <assign|detailed|<value|detailed-env>>

  \;

  <drd-props|summarized-plain|arity|2|accessible|0|hidden|1>

  <drd-props|summarized-std|arity|2|accessible|0|hidden|1>

  <drd-props|summarized-env|arity|2|accessible|0|hidden|1>

  <drd-props|summarized-grouped|arity|2|accessible|0|hidden|1>

  <drd-props|summarized-tiny|arity|2|accessible|0|hidden|1>

  <drd-props|summarized|arity|2|accessible|0|hidden|1>

  <drd-props|detailed-plain|arity|2|accessible|1|hidden|0>

  <drd-props|detailed-std|arity|2|accessible|1|hidden|0>

  <drd-props|detailed-env|arity|2|accessible|1|hidden|0>

  <drd-props|detailed-grouped|arity|2|accessible|1|hidden|0>

  <drd-props|detailed-tiny|arity|2|accessible|1|hidden|0>

  <drd-props|detailed|arity|2|accessible|1|hidden|0>

  <\active*>
    <\src-comment>
      Tags for switches.
    </src-comment>
  </active*>

  <assign|document-block|<\xmacro|switch-args>
    <surround||<right-flush>|<\quasi>
      <unquote*|<quote-arg|switch-args>>
    </quasi>>
  </xmacro>>

  <assign|tiny-block|<xmacro|switch-args|<map-args|identity|concat|switch-args>>>

  <assign|slide|<\macro|body>
    <\surround||<right-flush><new-page>>
      <arg|body>
    </surround>
  </macro>>

  <assign|slides-block|<\xmacro|switch-args>
    <surround||<right-flush>|<\quasi>
      <unquote*|<map|slide|<quote-arg|switch-args>>>
    </quasi>>
  </xmacro>>

  \;

  <assign|switch|<value|document-block>>

  <assign|screens|<value|document-block>>

  <assign|tiny-switch|<value|tiny-block>>

  <assign|unroll|<value|document-block>>

  <assign|expanded|<value|document-block>>

  <assign|slides|<value|slides-block>>

  \;

  <drd-props|switch|arity|<tuple|repeat|1|1>|accessible|all>

  <drd-props|screens|arity|<tuple|repeat|1|1>|accessible|all|border|no>

  <drd-props|tiny-switch|arity|<tuple|repeat|1|1>|accessible|all>

  <drd-props|unroll|arity|<tuple|repeat|1|1>|accessible|all>

  <drd-props|expanded|arity|<tuple|repeat|1|1>|accessible|all>

  <drd-props|slides|arity|<tuple|repeat|1|1>|accessible|all>

  \;

  <assign|traversed|<value|identity>>

  <assign|fold-back|<value|identity>>

  <assign|keep-unfolded|<value|identity>>

  <\active*>
    <\src-comment>
      Parts of documents.
    </src-comment>
  </active*>

  <assign|show-preamble|<\macro|body>
    <with|mode|src|preamble|true|par-first|0fn|par-par-sep|0.5fn|<arg|body>>
  </macro>>

  <assign|hide-preamble|<\macro|body>
    <hidden|<arg|body>>
  </macro>>

  <assign|show-part|<\macro|id|active|inactive>
    <set-part|<arg|id>|<arg|active>>
  </macro>>

  <assign|hide-part|<\macro|id|active|inactive>
    <hidden|<set-part|<arg|id>|<if|<sectional-short-style>|<arg|active>|<arg|inactive>>>>
  </macro>>

  <drd-props|show-preamble|border|no>

  <drd-props|hide-preamble|border|no>

  <drd-props|show-part|border|no>

  <drd-props|hide-part|border|no|arity|3|hidden|1>

  <\active*>
    <\src-comment>
      Different versions of parts of documents.
    </src-comment>
  </active*>

  <assign|render-old|<macro|old|<with|color|dark red|<arg|old>>>>

  <assign|render-new|<macro|new|<with|color|dark green|<arg|new>>>>

  <assign|version-old|<macro|old|new|<render-old|<arg|old>>>>

  <assign|version-new|<macro|old|new|<render-new|<arg|new>>>>

  <assign|version-both-small|<macro|old|new|<render-old|<arg|old>><render-new|<arg|new>>>>

  <assign|version-both-big|<\macro|old|new>
    <render-old|<arg|old>>

    <surround||<right-flush>|<render-new|<arg|new>>>
  </macro>>

  <assign|version-both|<macro|old|new|<compound|<if|<equal|<get-label|<arg|old>>|document>|version-both-big|version-both-small>|<arg|old>|<arg|new>>>>

  <assign|version-suppressed|<macro|<math|<op|\<times\>>>>>
</body>

<\initial>
  <\collection>
    <associate|preamble|true>
  </collection>
</initial>