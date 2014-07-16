NAME         := ffmpeg
VERSION      := 2.2.4
SOURCE_URL   := http://ffmpeg.org/releases/$(NAME)-$(VERSION).tar.bz2
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libass4" "libfreetype6" "libgpac2" "libsdl1.2debian" \
                "libtheora0" "libva1" "libvdpau1" "libvorbis0a" "libvorbisenc2" \
                "libx11-6" "libxext6" "libxfixes3" "zlib1g" "libmp3lame0" \
                "libopus0" "libpulse0" "libxvidcore4" "libssl1.0.0"
BUILDDEPENDS := autoconf automake build-essential libass-dev libfreetype6-dev \
                libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev \
                libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev \
                pkg-config texi2html zlib1g-dev yasm libmp3lame-dev libopus-dev \
                libpulse-dev libxvidcore-dev libssl-dev clang

PACKAGE_URL := http://ffmpeg.org
PACKAGE_DESCRIPTION := FFmpeg is a complete, cross-platform solution to \
                       record, convert and stream audio and video

include ../include/base.mk

CFLAGS := -O2 -g
CXX_FLAGS := -O2 -g
export CFLAGS
export CXX_FLAGS

DEPS_INSTALL_DIR := $(BUILDDIR)/ffmpeg-libs

$(DEPS_INSTALL_DIR): $(BUILDDIR)
	mkdir '$@'

X264_URL := http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
X264_FILE := $(CACHEDIR)/last_x64.tar.bz2
X264_BUILDDIR := $(BUILDDIR)/x264
X264_LIB := $(DEPS_INSTALL_DIR)/lib/libx264.a

$(X264_FILE): $(CACHEDIR)/.keep
	curl -L -f -o $@ '$(X264_URL)'

$(X264_BUILDDIR): $(X264_FILE) $(BUILDDIR)/.keep
	rm -rf '$@'
	mkdir '$@'
	tar -C '$@' --strip-components=1 -xf '$<'

build_x264: $(X264_LIB)
$(X264_LIB):
	$(MAKE) $(X264_BUILDDIR)
	cd $(X264_BUILDDIR) && \
		./configure --prefix="$(DEPS_INSTALL_DIR)" --enable-static
	$(MAKE) -C '$(X264_BUILDDIR)' -j8 install

.PRECIOUS: $(X264_FILE)
.PHONY: build_x264

FDK_AAC_URL := https://github.com/mstorsjo/fdk-aac/archive/master.tar.gz
FDK_AAC_FILE := $(CACHEDIR)/fdk_aac_master.tar.gz
FDK_AAC_BUILDDIR := $(BUILDDIR)/fdk-aac
FDK_AAC_LIB := $(DEPS_INSTALL_DIR)/lib/libfdk-aac.a

$(FDK_AAC_FILE): $(CACHEDIR)/.keep
	curl -L -f -o $@ '$(FDK_AAC_URL)'

$(FDK_AAC_BUILDDIR): $(FDK_AAC_FILE) $(BUILDDIR)/.keep
	rm -rf '$@'
	mkdir '$@'
	tar -C '$@' --strip-components=1 -xf '$<'

build_fdk_aac: $(FDK_AAC_LIB)
$(FDK_AAC_LIB):
	$(MAKE) $(FDK_AAC_BUILDDIR)
	cd '$(FDK_AAC_BUILDDIR)' && autoreconf -fiv && \
		./configure --prefix="$(DEPS_INSTALL_DIR)" --enable-static --disable-shared && \
	$(MAKE) -C '$(FDK_AAC_BUILDDIR)' -j8 install

.PRECIOUS: $(FDK_AAC_FILE)
.PHONY: build_fdk_aac

LIBVPX_URL := http://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2
LIBVPX_FILE := $(CACHEDIR)/libvpx-v1.3.0.tar.bz2
LIBVPX_BUILDDIR := $(BUILDDIR)/libvpx
LIBVPX_LIB := $(DEPS_INSTALL_DIR)/lib/libvpx.a

$(LIBVPX_FILE): $(CACHEDIR)/.keep
	curl -L -f -o $@ '$(LIBVPX_URL)'

$(LIBVPX_BUILDDIR): $(LIBVPX_FILE) $(BUILDDIR)/.keep
	rm -rf '$@'
	mkdir '$@'
	tar -C '$@' --strip-components=1 -xf '$<'

build_libvpx: $(LIBVPX_LIB)
# g++ segfaults here. Use clang instead
$(LIBVPX_LIB):
	$(MAKE) $(LIBVPX_BUILDDIR)
	cd $(LIBVPX_BUILDDIR) && CXX=clang++ CC=clang \
		./configure --prefix="$(DEPS_INSTALL_DIR)" --enable-static --disable-shared --disable-examples
	$(MAKE) -C '$(LIBVPX_BUILDDIR)' -j8 install

.PRECIOUS: $(LIBVPX_FILE)
.PHONY: build_libvpx

fetch: standard_fetch
	$(MAKE) $(X264_FILE) $(FDK_AAC_FILE) $(LIBVPX_FILE)

extract: standard_extract
	$(MAKE) $(X264_BUILDDIR) $(FDK_AAC_BUILDDIR) $(LIBVPX_BUILDDIR)

build_x264 build_fdk_aac build_libvpx: extract install_builddepends

# use clang because gcc crashes
# it still crashes for me in the linking phase
# just go to /tmp/build/ffmpeg-XXX and run make and then continue
# or try removing -j8 below
build: build_x264 build_fdk_aac build_libvpx
	cd $(SBUILDDIR) && \
		PKG_CONFIG_PATH='$(DEPS_INSTALL_DIR)/lib/pkgconfig' ./configure \
		--cc=clang \
		--cxx=clang++ \
		--extra-cflags="-I$(DEPS_INSTALL_DIR)/include" \
		--extra-ldflags="-L$(DEPS_INSTALL_DIR)/lib" \
		--extra-libs="-ldl" \
		--enable-gpl \
		--enable-version3 \
		--enable-nonfree \
		--enable-libass \
		--enable-libfdk-aac \
		--enable-libfreetype \
		--enable-libmp3lame \
		--enable-libopus \
		--enable-libtheora \
		--enable-libvorbis \
		--enable-libvpx \
		--enable-libx264 \
		--enable-libxvid \
		--enable-openssl \
		--enable-libpulse \
		--enable-pthreads \
		--enable-x11grab \
		--enable-avresample \
		--enable-hardcoded-tables
	$(MAKE) -j8 -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'

package: standard_package

clean: clean_extra
clean_extra:
	rm -rf '$(LIBVPX_BUILDDIR)' '$(FDK_AAC_BUILDDIR)' '$(X264_BUILDDIR)' '$(DEPS_INSTALL_DIR)'
