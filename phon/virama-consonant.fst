#include "../symbols.fst"

ALPHABET = [#AAsym#]

% Virama get replaced by u sign if followed by consonant

$virama-consonant$ = {[#Virama#]} : {ു} ^-> ([#Consonants#] __ [#POS##BM##Numbers##TMP##compounds#]+ [#Consonants#] )
$samvruthokaram-consonant$ = {[#Virama#]} : <> ^-> ([ു] __ [#POS##BM##Numbers##TMP##compounds#]+ [#Consonants#] )

% ട് എന്നതിലവസാനിക്കുന്ന വാക്കുകൾക്ക് ട്ടു എന്നു ഇരട്ടിക്കുന്ന സ്വഭാവം കാണുന്നുണ്ട്: നാട്ടുവെളിച്ചം, കൂട്ടൂപക്ഷി, വീട്ടുമൃഗം, മാട്ടുപ്പൊങ്കൽ
$ta-virama-consonant$ = {ട്} : {ട്ടു} ^-> ([#VowelSigns#] __ [#POS##BM##Numbers##TMP#]+ [#Consonants#] )

$tests$ =<>:<BoW>പൂവ്<n><>:<RB><>:<EoW><>:<BoW>മണം<n><>:<RB><>:<EoW> \
<>:<BoW>ഇരുപത്<tens><num><RB><>:<EoW><>:<BoW>രൂപ<n><>:<RB><>:<EoW>
% Uncomment below line for testing
% $tests$ ||\
% NOTE: Below order of composition is very important.

$ta-virama-consonant$ || $virama-consonant$ || $samvruthokaram-consonant$
