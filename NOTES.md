Language
=========
Newly formulated rules: https://docs.google.com/document/d/1yWi67PO7EUHgak7lNI8_U6JF-Typo9qGFQ4Op2t4vGs/edit#
Cross check with Keralapanineeyam and have test coverage matching its examples.

Lexicon
=======
1. Nouns with അ is taken from ml.wiktionary.org വർഗ്ഗം:മലയാളം നാമങ്ങൾ. Others need to add.
2. Abbreviations not integrated well

TODO
=====

1. Expand lexicon
2. More proper nouns - places, people where to get?
3. Verbs
4. Documentation
5. Expand number to cover all edge cases.
6. Abbreviations
7. Standardize POS tags and document
8. Exception dictionary
9. Use names for variables that are not confusing
10. include #infl# in the vowel to vowel sign context - as possible tag in the word joining position.
11. Avoid proper nouns like place names, person names agglutinating with another proper names.


Ideas
=====
1. A grapheme to phoneme transcription utility, try extending with stress markers
2. Date parser that accepts strings like നവമ്പർ മാസം പത്താം തീയതി and gives Nov 10. The date in machine readable format.
3. Same as above for time. വൈകീട്ട് മൂന്നരമണി, രാവിലെ ആറേ മുക്കാൽ. നാളെ രാത്രി പന്ത്രണ്ടരമണി...
4. IPA transliteration/transcription
5. Spell checker
6. Hyphenation
7. Syllabalzer


Working with HFST
=================
To compile:

`FSTC=HFST make`

Generate 10 random strings the FST can produce:

`hfst-fst2strings malayalam.a  -r 10`

Lookup:

`echo "നീല<n><pl>" | hfst-lookup malayalam.a`

Optimize the FST

`hfst-fst2fst -S -i malayalam.a -o malayalam.ao`

Using fst-proc:
```
$ echo "നീല<n><pl>" | hfst-proc -a malayalam.ao
^നീല<n><pl>/നീലകൾ$
```


Using with HFST
---------------
It can also be compiled with [Helsinki Finite-State Transducer Technology (HFST) ](http://www.ling.helsinki.fi/kieliteknologia/tutkimus/hfst/). To compile using HFST tools, set
FSTC envirionment to 'hfst', a command like ```FSTC=hfst make``` should do
the trick. The resulting FSA will be usable with the HFST tools.  



Ruby
-----
There is a ruby wrapper for SFST: https://github.com/mlj/ruby-sfst
To install gem install ruby-sfst.
Sample code:
```ruby
require "sfst"

fst = SFST::RegularTransducer.new("malayalam.a")
analyse=fst.analyse('നീലത്താമര')
puts analyse

```
and running it like
```bash
$ruby test.rb
```
gives

`നീല<n>താമര<n>`
Nodejs
------
No known bindings. Worth to write one from scratch?


Debugging
=========
sfst tools are useful for debugging. Here is an example.
To debug accusative.fst, it is better to test that file individually. Compiling the whole system and making modifications is very time consuming.

Add the following lines towards the end of the file.
```
$tests$ = മഴ<n><RB><accusative> | മുറ്റം<n><RB><accusative> |  കിളി<n><RB><accusative> | താൻ<prn><RB><accusative>
$tests$ || $accusative$ >> "accusative-test.a"
```

Compile the file using sfst: ```fst-compiler-utf8 accusative.fst accusative.a```

Then generate all strings the fst can generate using ```fst-generate accusative.a```. Make sure this list is correct and does not output random values. Producing unwanted items in output will cause bigger time for compositions in other parts of system.

You can keep the above test lines in FST as commented lines after debugging.

ദ്വിത്വസന്ധി
=========
Duplication is more complicated than what is implemented now. Current implmentation is purely a
phonological one. But actually, duplication is conditional on the characteristics of participating
words.
1. The duplication of കചടതപശ is when the first word is adjective. So it should happen only at
word<n><adj>+word<n>
2. Duplication also happens after demonstratives. അക്കാര്യം, ഇത്തല, ഇവ്വണ്ണം. But in this case even weak consonants get duplicated - ഇ + വണ്ണം = ഇവ്വണ്ണം, ഈവിധം. Also, elongation of demonstratives is
suggested for the weak consontants - ഈവിധം
3. In case of ദ്വന്ദസമാസം - no duplication happens- ആനകുതിര
4. മുൻവിനയെച്ചം, ആധാരികാഭാസം, ഇൽ, കൽ പ്രത്യയങ്ങൾ -ഇവയ്ക്കപ്പുറം ഇരട്ടിക്കും. പക്ഷേ തന്നുപോയി എന്നതിൽ എങ്ങനെ പ ഇരട്ടിക്കില്ല എന്നതിനു നിയമമില്ല?
