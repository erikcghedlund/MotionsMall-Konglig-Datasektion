BUILDDIR = .build
IMAGESWILDCARD = $(wildcard *.png) $(wildcard *.jpg) $(wildcard *.jpeg) $(wildcard *.gif)

TARGETS = $(subst .tex,.pdf,$(wildcard *.tex))
DEPENDS = $(BUILDDIR)/skold-color.pdf $(BUILDDIR)/Makefile texlive_depends image_move
DIRECTORIES = $(BUILDDIR)

MAKEFILEVERSION = dd5c1a0b1aef81daf05b62d951daec644e74b6bc
MAKEFILEURL = https://raw.githubusercontent.com/shiblon/latex-makefile/$(MAKEFILEVERSION)/Makefile

SKOLDVERSION = b745112309bff2579b565ca098c2db1147a60bd5
SKOLDURL = https://github.com/datasektionen/UI/raw/$(SKOLDVERSION)/Delta_Shield/pdf/skold-color.pdf

all: $(TARGETS)

clean:
	rm -rf $(DIRECTORIES) $(TARGETS)

$(BUILDDIR):
	mkdir ./$@

echo:
	echo $(T)

$(BUILDDIR)/Makefile: $(BUILDDIR) /usr/bin/wget
	/usr/bin/wget $(MAKEFILEURL) -O $@ --no-clobber --quiet || :

$(BUILDDIR)/skold-color.pdf: $(BUILDDIR) /usr/bin/wget
	/usr/bin/wget $(SKOLDURL) -O $@ --no-clobber --quiet || :

$(BUILDDIR)/%.tex: %.tex $(BUILDDIR)
	cp $< $@

image_move:
	mv $(IMAGESWILDCARD) $(BUILDDIR) || :

$(BUILDDIR)/%.pdf: $(DEPENDS) $(BUILDDIR)/%.tex
	make $(notdir $@) -C $(BUILDDIR) 

%.pdf: $(BUILDDIR)/%.pdf
	cp $(BUILDDIR)/$@ .

texlive_depends: /usr/bin/tlmgr
	tlmgr info --only-installed | grep fontaxes || tlmgr install fontaxes
	tlmgr info --only-installed | grep lastpage || tlmgr install lastpage
	tlmgr info --only-installed | grep lato     || tlmgr install lato
