
#include "symbols.fst"

$NSTEM$ = "<lexicon/nouns.a>"
$SANSKRIT$ = "<lexicon/nouns-sanskrit.a>"
$PRONOUN$ = "<lexicon/pronouns.a>"
$PROPERNOUN$ = "<lexicon/proper-nouns.a>"
$CONJUNCTION$ = "<lexicon/conjunctions.a>"
$QUANTIFIERS$ = "<lexicon/quantifiers.a>"
$POSTPOSITIONS$ = "<lexicon/postpositions.a>"
$INDECLINABLE$ = "<lexicon/indeclinables.a>"
$ABBREV$ = "<lexicon/abbreviations.a>"
$DEM$ = "<lexicon/demonstratives.a>"
$VSTEM$ = "<lexicon/verbs.a>"
$BORROWED$ = "<lexicon/borrowed-words.a>"
$PLURAL$ = "<ninfl/plural.a>"
$NINFL$ = "<ninfl/ninfl.a>"
$ADJECTIVE$ = "<lexicon/adjectives.a>"
$POLARITY$ = "<lexicon/polarity.a>"
$NUMBER$ = "<num.a>"
$VERB$ = "<verb.a>"

% Derived Nouns
$NOUNFROMVERB$ = "<deriv/noun-from-verb.a>"
$NOUNFROMNOUN$ = "<deriv/noun-from-noun.a>"
$NOUNFROMADVERB$ = "<deriv/noun-from-adverb.a>"

$DERIVEDNOUNS$ = (($VERB$ <n> <deriv> ) || $NOUNFROMVERB$) |\
	( "<verb-adverbs.a>" <n> <deriv> || $NOUNFROMADVERB$ ) |\
	( ($NSTEM$ [<masculine><feminine><neutral>] <n> <deriv>) || $NOUNFROMNOUN$)

$ordinal_forms$= ({}:{ആം}|{}:{ആമത്തെ}|{}:{ആമത്}|{}:{ആമതു്}) <ordinal>
$NUMBERIC$ = $NUMBER$ $ordinal_forms$?

% Agglutination
$ALL_NOUNS$ = $NSTEM$ | $PROPERNOUN$ | $NUMBER$ | $SANSKRIT$
$AGGLUTINATED_NOUN$ = ( ($NSTEM$ | $NUMBER$ | $SANSKRIT$) <adj> )* ( $NSTEM$ | $PROPERNOUN$ | $SANSKRIT$) % വിശേഷണവിശേഷ്യങ്ങൾ
$COORDINATIVE_NOUN$ = $NSTEM$ <coordinative> $NSTEM$ % ദ്വന്ദസമാസം - ആനകുതിര, അച്ഛനമ്മ..
$COMPOUND_NSTEM$ = $AGGLUTINATED_NOUN$ | $COORDINATIVE_NOUN$

$SINGULAR_NOUN$ = $COMPOUND_NSTEM$ | $PRONOUN$ | $ABBREV$ | $BORROWED$ | $DERIVEDNOUNS$ | $NUMBERIC$
$PLURAL_NOUN$ = $SINGULAR_NOUN$ <pl> || $PLURAL$

$SUFFIXES$ = $POSTPOSITIONS$ | $CONJUNCTION$ | $POLARITY$ | $QUANTIFIERS$
$SUFFIXES$ = $SUFFIXES$? $SUFFIXES$ % Atmost 2 times

$NOUN$ = $DEM$ |\
	( $DEM$? $ADJECTIVE$? ( $SINGULAR_NOUN$ | ( $PLURAL_NOUN$ <EoW><RB> ) ) [#ninfl#]? $SUFFIXES$? )

$NOUN$ = $NOUN$ || $NINFL$

% Derive standalone adjective form for the noun. But do it only if the noun ends with virama or anuswara.
% To avoid conjunctions ഉം posing as standalone adjective ഉ, demand at least two letters before virama or vowel.
$ADJ_CANDIDATES_FILTER_1$ = [#AAsym#]+ [#Letters#]+ [#Letters#] [ം്] [#POS##Numbers##infl##TMP##BM#]+
$ADJ_CANDIDATES_FILTER_2$ = [#AAsym#]+ [#Letters#]+ <sanskrit> [#POS##Numbers##infl##TMP##BM#]+
$ADJ_CANDIDATES_FILTER$ = $ADJ_CANDIDATES_FILTER_1$ | $ADJ_CANDIDATES_FILTER_2$
$ADJ_CANDIDATES$ = $NOUN$ || $ADJ_CANDIDATES_FILTER$
$ADJ_PART$ = ( $ADJ_CANDIDATES$ <adj>) || "<ninfl/standalone-adjective.a>"
$NOUN$ = $NOUN$ | $ADJ_PART$

$test$ = വഴി<n><RB><locative>കൂടി<cnj><RB> | വഴി<n><RB> | വഴി<n><RB><locative> | \
	ആശ<sanskrit><RB> | ആശ<sanskrit><RB><adj> | ആശ<sanskrit><RB><adj>ദീപം<n><RB> | \
	ആശ<sanskrit><RB><adj>ദീപം<n><RB><adj>

$test$ || $NOUN$ >> "noun.test.a"
% $ADJ_PART$ >> "adj.parts.a"

$VERB$ <n> <deriv> >> "verb-noun-deriv.a"

$NOUN$ $INDECLINABLE$?
