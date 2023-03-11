BUILDDIR = .build

TARGETS = motion.pdf
DEPENDS = $(BUILDDIR)/skold-color.pdf $(BUILDDIR)/Makefile
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

$(BUILDDIR)/Makefile: $(BUILDDIR) /usr/bin/wget
	/usr/bin/wget $(MAKEFILEURL) -O $@ --no-clobber --quiet || :

$(BUILDDIR)/skold-color.pdf: $(BUILDDIR) /usr/bin/wget
	/usr/bin/wget $(SKOLDURL) -O $@ --no-clobber --quiet || :

$(BUILDDIR)/%.tex: %.tex $(BUILDDIR)
	cp $< $@

$(BUILDDIR)/%.pdf: $(DEPENDS) $(BUILDDIR)/%.tex
	make $(notdir $@) -C $(BUILDDIR) 

%.pdf: $(BUILDDIR)/%.pdf
	cp $(BUILDDIR)/$@ .
