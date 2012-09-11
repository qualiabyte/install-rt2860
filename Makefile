VERSION := 0.0.2
DIST := install-rt2860-$(VERSION)
DIST_FILES := \
	README.markdown \
	ralink-rt2860.patch \
	install-rt2860.sh \
	2010_07_16_RT2860_Linux_STA_v2.4.0.0.tar.gz

all: dist

fetch:
	./install-rt2860.sh --fetch-only

dist: fetch
	mkdir -p build/$(DIST)
	cp -a $(DIST_FILES) build/$(DIST)
	cd build \
	  && tar cvzf $(DIST).tar.gz $(DIST)

clean:
	-rm -fr build

.PHONY: all dist fetch clean
