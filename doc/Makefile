SRC_FILES = $(wildcard *.tex)

all: $(SRC_FILES:.tex=.pdf)

%.pdf: %.tex
	latexmk -interaction=nonstopmode -shell-escape -pdf -use-make -cd $<

clean:
	latexmk -cd -CA $(SRC_FILES)
	cd "$(1)" && latexmk -cd -CA
	cd "$(1)" && rm -f main.pdf *.dvi *.bbl *.nav *.ilg *.idx *.64 main-logo.pdf
	cd "$(1)" && rm -fr auto _minted-*
