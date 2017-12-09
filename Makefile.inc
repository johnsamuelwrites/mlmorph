DISTNAME=mlmorph-`cat VERSION`
FSTC ?= sfst
ifeq ($(FSTC),hfst)
%.a: %.fst
	hfst-sfstpl2fst -f openfst-tropical -v -i $< -o $@
else
%.a: %.fst
	hfst-compiler-utf8 $< $@
endif

%.dot: %.a
	hfst-fst2txt -D -f dot -i $< -o $@
