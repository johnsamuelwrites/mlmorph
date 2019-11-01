% --------------------------------------------------------------------------------
% ==== Promissive Mood Forms ====
% Ref: A Grammar of Malayalam - Ravisankar S Nair
% --------------------------------------------------------------------------------

#include "../../symbols.fst"

ALPHABET = [#Letters##POS##BM##TMP##infl#]

$past-tense$ = "<../past.a>"

% We need to wrap the verb into past form first. For that, fake a past tag and pass
% it through the past.a. Only when the input has <promissive-mood> at end.
$fake-past$ = {<RB>}:{<past>} ^-> ([#verbs#]+ __ [<promissive-mood>])
$remove-past$ = <past>:<RB> ^-> ([#verbs#]+ __ [<promissive-mood>])

% വരാം, സഹായിക്കാം, ഓടാം, പാടാം, പറയാം
$verb-suffix-map$ = {ുക}:{ാം}
$promissive-mood-1$ = $verb-suffix-map$ <>:<infl_marker> ^-> ([#Consonants#]+ __ [#POS##BM##TMP#]+ <promissive-mood>)

% A stronger degree of promise is indicated by the suffix –eek + -aam added to the past
% tense stem of the verb. വന്നേക്കാം, പോയേക്കാം

$verb-suffix-map-1$ = {ു<infl_marker>}:{േക്കാം<infl_marker>} | {ു<infl_marker>}:{േയ്ക്കാം<infl_marker>} | {ി<infl_marker>} : {ിയേക്കാം<infl_marker>}

% Similar in force are the constructions using –ool + -aam with the past tense stem.
% പോയിക്കോളാം, വന്നോളാം, ഓടിക്കോളാം

$verb-suffix-map-2$ = {ു<infl_marker>}:{ോളാം<infl_marker>} | {ി<infl_marker>} : {ിക്കോളാം<infl_marker>}

% Meaning of certainty is conveyed through the suffix –irikk + -um added to the past tense
% stem. പോയിരിക്കും, വന്നിരിക്കും

$verb-suffix-map-3$ = {ു<infl_marker>}:{ിരിയ്ക്കും<infl_marker>} | {ി<infl_marker>} : {ിയിരിയ്ക്കും<infl_marker>} |  {ി<infl_marker>} : {ിയിരിക്കും<infl_marker>}
$verb-suffix-map$ = $verb-suffix-map-1$ | $verb-suffix-map-2$ | $verb-suffix-map-3$
$promissive-mood-2$ = $verb-suffix-map$ ^-> ([#Consonants#]+ __ [#BM##TMP##verbs#<past>]+ <promissive-mood>)

$promissive-mood$ = $promissive-mood-1$ | \
	( $fake-past$ || $past-tense$ || $promissive-mood-2$ || $remove-past$ )
$promissive-mood$
