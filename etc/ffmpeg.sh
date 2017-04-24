apt-get update
apt-get -y install \
    autoconf \
    automake \
    build-essential \
    libtool \
    pkg-config \
    texinfo \
    yasm \
    cmake \
    mercurial \
    nasm \
    wget \
    xz-utils \
    zlib1g-dev

mkdir ffmpeg
cd ffmpeg

wget http://johnvansickle.com/ffmpeg/release-source/freetype-2.6.1.tar.xz
tar xfv freetype-2.6.1.tar.xz
cd freetype-2.6.1
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
cd -

wget http://fribidi.org/download/fribidi-0.19.7.tar.bz2
tar xfv fribidi-0.19.7.tar.bz2
cd fribidi-0.19.7
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
cd -

wget http://downloads.sourceforge.net/project/expat/expat/2.1.1/expat-2.1.1.tar.bz2
tar xfv expat-2.1.1.tar.bz2
cd expat-2.1.1
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
cd -

wget http://johnvansickle.com/ffmpeg/release-source/fontconfig-2.11.0.tar.xz
tar xfv fontconfig-2.11.0.tar.xz
cd fontconfig-2.11.0
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
cd -

wget http://johnvansickle.com/ffmpeg/release-source/libass-git.tar.xz
tar xfv libass-git.tar.xz
cd libass-git
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
cd -

wget http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.xz
tar xfv libogg-1.3.2.tar.xz
cd libogg-1.3.2
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
cd -

wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2
tar xfv libtheora-1.1.1.tar.bz2
cd libtheora-1.1.1
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
cd -

wget http://johnvansickle.com/ffmpeg/release-source/libvorbis-1.3.4.tar.xz
tar xfv libvorbis-1.3.4.tar.xz
cd libvorbis-1.3.4
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-static
make
make install
cd -

wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
tar xjvf last_x264.tar.bz2
cd x264-snapshot*
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
PATH="$HOME/bin:$PATH" make
make install
cd -

hg clone https://bitbucket.org/multicoreware/x265
cd x265/build/linux
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install
cd -

wget -O fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master
tar xzvf fdk-aac.tar.gz
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
cd -

wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix="$HOME/ffmpeg_build" --enable-nasm --disable-shared
make
make install
cd -

wget http://downloads.xiph.org/releases/opus/opus-1.1.tar.gz
tar xzvf opus-1.1.tar.gz
cd opus-1.1
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
cd -

wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2
tar xjvf libvpx-1.5.0.tar.bz2
cd libvpx-1.5.0
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests --disable-shared
PATH="$HOME/bin:$PATH" make
make install
cd -

cd $HOME/ffmpeg_build/lib
ln -s `g++ -print-file-name=libstdc++.a`
ln -s `g++ -print-file-name=libm.a`
ln -s `g++ -print-file-name=librt.a`
ln -s `g++ -print-file-name=libz.a`
cd -

wget http://johnvansickle.com/ffmpeg/release-source/ffmpeg-3.0.2.tar.xz
tar xvf ffmpeg-3.0.2.tar.xz
cd ffmpeg-3.0.2*
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include --static" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib --static" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree \
  --enable-static \
  --disable-shared
PATH="$HOME/bin:$PATH" make
make install
