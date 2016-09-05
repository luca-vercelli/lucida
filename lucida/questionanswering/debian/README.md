Build and install
-----------------
This package requires Java 8, currently available in Debian/unstable:
https://packages.debian.org/sid/openjdk-8-jdk
https://packages.debian.org/sid/openjdk-8-jdk-headless
https://packages.debian.org/sid/openjdk-8-jre
https://packages.debian.org/sid/openjdk-8-jre-headless


build with:
    dpkg-buildpackage
(missing required packages will be shown)
(advanced users may prefer debuild or sbuild)

install the .deb package generated via GUI or with:
    dpkg -i lucida*.deb
    apt-get install -f
 
