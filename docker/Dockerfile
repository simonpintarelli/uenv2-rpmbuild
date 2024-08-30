FROM opensuse/leap:15.5

RUN zypper install -y       \
    make                    \
    gcc12                   \
    gcc12-c++               \
    curl                    \
    tar                     \
    bzip2                   \
    python3                 \
    python3-pip             \
    git                     \
    libopenssl-devel        \
    bubblewrap              \
    rpm-build
# slurm-uenv-mount
# install python
RUN curl -O https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz \
&& tar xzvf Python-3.10.11.tgz \
&& cd Python-3.10.11 \
&& ./configure \
&& make install -j \
&& cd ../ && rm -r Python-3.10.11

# rpmbuild > /usr/lib/rpm/macros.d/macros.meson are missing here ...
RUN python3 -m pip install --upgrade pip && python3 -m pip install meson ninja
RUN curl https://raw.githubusercontent.com/mesonbuild/meson/master/data/macros.meson -o /usr/lib/rpm/macros.d/macros.meson
# rpm build expects meson in /usr/bin/meson
RUN ln -s /usr/local/bin/meson /usr/bin/meson

# rpmbuild > /usr/lib/rpm/macros.d/macros.meson are missing here ...
RUN curl https://raw.githubusercontent.com/mesonbuild/meson/master/data/macros.meson -o /usr/lib/rpm/macros.d/macros.meson
