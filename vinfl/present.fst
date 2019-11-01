#include "../symbols.fst"


ALPHABET = [#Letters##POS##BM##TMP##infl#]

% അടിക്കുക - അടിക്കുന്നു. കരയുക - കരയുന്നു.
$present-tense-1$ = {ുക}:{ുന്നു} <>:<infl_marker>   ^-> ([#Consonants#]+ __ [#POS##BM##TMP#]+ <present>)

$present-tense$ = $present-tense-1$

$present-tense$
