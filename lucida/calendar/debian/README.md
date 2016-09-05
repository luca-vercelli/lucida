Build and install
-----------------
You need java 8, wich is currently in Debian/unstable:
https://packages.debian.org/jessie-backports/openjdk-8-jdk
https://packages.debian.org/jessie-backports/openjdk-8-jdk-headless

build with:
    dpkg-buildpackage
(missing required packages will be shown)
(advanced users may prefer debuild or sbuild)

install the .deb package generated via GUI or with:
    dpkg -i lucida*.deb
    apt-get install -f
 
