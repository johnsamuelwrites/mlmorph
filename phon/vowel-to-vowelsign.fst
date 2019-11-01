#include "../symbols.fst"

ALPHABET = [#AAsym#]

% Delete Vowels and replace it by its vowel sign when the second word start with Vowel
$vowel-to-vowelsign-map$ = {അ}:{<del>} |\
	{ആ}:{ാ} | {ഇ}:{ി} | {ഈ}:{ീ} | {ഉ}:{ു} | {ഊ}: {ൂ} | {ഋ}:{ൃ} |\
	{എ}:{െ} | {ഏ}:{േ} | {ഐ}:{ൈ} | {ഒ}:{ൊ} | {ഓ}:{ോ} | {ഔ}:{ൗ}

$vowel-to-vowelsign$ = $vowel-to-vowelsign-map$ ^-> ( [#Letters#]+ [#POS##BM##Numbers##TMP##infl##compounds##Lsym#]+ __ )

$tests$ =<>:<BoW>പൂവ<n><>:<RB><>:<EoW><>:<BoW>ആയിരം<n><>:<RB><>:<EoW> | \
	<>:<BoW>പൂവ<n><>:<RB><>:<EoW><>:<BoW>അമ്പലം<n><>:<RB><>:<EoW> | \
	<>:<BoW>ഭാഷ<ninfl>ആ<sanskrit>:<RB><>:<EoW><>:<BoW>അന്തരം<n><>:<RB><>:<EoW>

% Uncomment below line for testing

$tests$ || $vowel-to-vowelsign$ >> "v2v.test.a"

$vowel-to-vowelsign$
