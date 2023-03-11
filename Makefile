BUILDDIR = .build
IMAGESWILDCARD = $(wildcard *.png) $(wildcard *.jpg) $(wildcard *.jpeg) $(wildcard *.gif)

TARGETS = $(subst .tex,.pdf,$(wildcard *.tex))
DEPENDS = $(BUILDDIR)/skold-color.pdf $(BUILDDIR)/Makefile image_move
DIRECTORIES = $(BUILDDIR)

MAKEFILEVERSION = dd5c1a0b1aef81daf05b62d951daec644e74b6bc
MAKEFILEURL = https://raw.githubusercontent.com/shiblon/latex-makefile/$(MAKEFILEVERSION)/Makefile

SKOLDVERSION = b745112309bff2579b565ca098c2db1147a60bd5
SKOLDURL = https://github.com/datasektionen/UI/raw/$(SKOLDVERSION)/Delta_Shield/pdf/skold-color.pdf

TEXLIVEDEPENDS = fontaxes lastpage lato xcolor babel-swedish fancyhdr lastpage latex

all: $(TARGETS)

clean:
	rm -rf $(DIRECTORIES) $(TARGETS)

$(BUILDDIR):
	mkdir ./$@

$(BUILDDIR)/Makefile: $(BUILDDIR)
	wget $(MAKEFILEURL) -O $@ --no-clobber --quiet || :

$(BUILDDIR)/skold-color.pdf: $(BUILDDIR)
	wget $(SKOLDURL) -O $@ --no-clobber --quiet || :

$(BUILDDIR)/%.tex: %.tex $(BUILDDIR)
	cp $< $@

image_move:
	cp $(IMAGESWILDCARD) $(BUILDDIR) || :

$(BUILDDIR)/%.pdf: $(DEPENDS) $(BUILDDIR)/%.tex
	make $(notdir $@) -C $(BUILDDIR) 

%.pdf: $(BUILDDIR)/%.pdf
	cp $(BUILDDIR)/$@ .

install_texlive_depends:
	$(foreach pkg,$(TEXLIVEDEPENDS),tlmgr info --only-installed | grep $(pkg) || tlmgr install $(pkg);)
	
remove_texlive_depends:
	tlmgr remove $(TEXLIVEDEPENDS)
