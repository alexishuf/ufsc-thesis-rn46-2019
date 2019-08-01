SRC_FILES = $(wildcard *.tex)

all: $(SRC_FILES:.tex=.pdf)

%.pdf: %.tex
	latexmk -interaction=nonstopmode -shell-escape -pdf -use-make -cd $<

clean:
	latexmk -cd -CA $(SRC_FILES)
