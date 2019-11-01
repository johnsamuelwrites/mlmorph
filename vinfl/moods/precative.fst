% --------------------------------------------------------------------------------
% ==== Precative Mood Forms ====
% The precative mood is used to express a wish in the form of a prayer or to implore.
% Ref: A Grammar of Malayalam - Ravisankar S Nair
% --------------------------------------------------------------------------------

#include "../../symbols.fst"

ALPHABET = [#Letters##POS##BM##TMP##infl#]

% The precative construction of verb root + anee is a contracted form of verb root+
% uka(infinitive) + veenam (defective verb) + -ee (emphatic particle).Forms like
% parayukaveenam ‘Must say’, kaanukaveenam ‘Must see’ are attested in classical poetry.
% Liturgical language still makes use of forms like vareenamee ‘May it come’,
% kaniyeenamee ‘May it give mercy’ etc. Present day spoken language uses only the
% contracted form.

$verb-suffix-map$ = {ുക}:{ണേ} | {ുക}:{േണമേ}
$precative-mood$ = $verb-suffix-map$ <>:<infl_marker> ^-> ([#Consonants#]+ __ [#POS##BM##TMP#]+ <precative-mood>)

% Negative precative mood
$verb-suffix-map$ = {ുക}:{രുതേ}
$precative-mood-neg$ = $verb-suffix-map$ <>:<infl_marker> ^-> ([#Consonants#]+ __ [#POS##BM##TMP#]+ <precative-neg-mood>)

$precative-mood$ | $precative-mood-neg$
