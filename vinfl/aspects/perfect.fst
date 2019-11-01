% --------------------------------------------------------------------------------
% ==== Perfect Aspect Forms ====
% The perfect aspect denotes the contemporary relevance of a past action.
% It can be of three types; simple perfect, contemporaneous perfect and remote perfect.
% Ref: A Grammar of Malayalam - Ravisankar S Nair
% --------------------------------------------------------------------------------

#include "../../symbols.fst"

ALPHABET = [#Letters##POS##BM##TMP##infl#]

$past-tense$ = "<../past.a>"
#perfect-aspects# = <simple-perfect-aspect><cont-perfect-aspect><remote-perfect-aspect>
% We need to wrap the verb into past form first. For that, fake a past tag and pass
% it through the past.a. Only when the input has #perfect-aspects# at end.
$fake-past$ = {<RB>}:{<past>} ^-> ([#verbs#]+ __ [#perfect-aspects#])

% --------------------------------------------------------------------------------
% == Simple perfect ==
% By adding –irunnu to the past stem of the verb, simple perfect forms are derived. They
% indicate a state that is different from the one denoted by the past.

$simple-perfect-aspect$ = {<simple-perfect-aspect>}:{ഇരുന്നു<infl_marker>}

$verb-suffix-map$ = {ുക}:{ാതിരുന്നു}
$simple-perfect-aspect-neg$ = $verb-suffix-map$ <>:<infl_marker> ^-> ([#Consonants#]+ __ [#POS##BM##TMP#]+ <simple-perfect-aspect-neg> )

% --------------------------------------------------------------------------------
% == Contemporaneous perfect ==

% Contemporaneous form is derived by adding –irikkunnu to the past stem. It is used to
% denote a state of affairs when the effect of the past action is still experienced or
% when the result of the past action is being expected.

$cont-perfect-aspect$ = {<cont-perfect-aspect>}:{ഇരിക്കുന്നു<infl_marker>} | \
	{<cont-perfect-aspect>}:{ഇരിയ്ക്കുന്നു<infl_marker>}


$verb-suffix-map$ = {ുക}:{ാതിരിയ്ക്കുന്നു} |  {ുക}:{ാതിരിക്കുന്നു}
$cont-perfect-aspect-neg$ = $verb-suffix-map$ <>:<infl_marker> ^-> ([#Consonants#]+ __ [#POS##BM##TMP#]+ <cont-perfect-aspect-neg> )

% --------------------------------------------------------------------------------
% == Remote perfect ==

% Remote perfect forms are derived by adding –ittu to the past stem. They denote an
% action which occurred only once or a few times (that is, not regular or habitual) or during
% an unspecified time in the past, far removed from the present.

$remote-perfect-aspect$ = {<remote-perfect-aspect>}:{ഇട്ട്<infl_marker>} |\
	{<remote-perfect-aspect>}:{ഇട്ടു്<infl_marker>} |\
	{<remote-perfect-aspect>}:{ഇട്ടു<infl_marker>}

$verb-suffix-map$ = {ുക}:{ാഞ്ഞിട്ട്} | {ുക}:{ാഞ്ഞിട്ടു്} | {ുക}:{ാഞ്ഞിട്ടു}
$remote-perfect-aspect-neg$ = $verb-suffix-map$ <>:<infl_marker> ^-> ([#Consonants#]+ __ [#POS##BM##TMP#]+ <remote-perfect-aspect-neg> )

% ----------

$perfect-aspects-forms$ = $simple-perfect-aspect$ | $cont-perfect-aspect$ | $remote-perfect-aspect$

$perfect-aspects$ = $perfect-aspects-forms$ ^-> ([<past>] __ )

$perfect-aspects$ = $fake-past$ || $past-tense$ || $perfect-aspects$

$perfect-aspects$ | $simple-perfect-aspect-neg$ | $cont-perfect-aspect-neg$ | $remote-perfect-aspect-neg$
