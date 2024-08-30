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
    rpm-build

# rpmbuild > /usr/lib/rpm/macros.d/macros.meson are missing here ...
RUN python3 -m pip install --upgrade pip && python3 -m pip install meson ninja
RUN curl https://raw.githubusercontent.com/mesonbuild/meson/master/data/macros.meson -o /usr/lib/rpm/macros.d/macros.meson
# rpm build expects meson in /usr/bin/meson
RUN ln -s /usr/local/bin/meson /usr/bin/meson
