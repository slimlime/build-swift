#!/bin/bash
pushd `dirname $0` > /dev/null
WHERE_I_AM=`pwd`
ARCH=`arch`
popd > /dev/null
INSTALL_DIR=${WHERE_I_AM}/install
PACKAGE=${WHERE_I_AM}/swift.tar.gz
LSB_RELEASE=`lsb_release -rs  | tr -d .`
rm -rf $INSTALL_DIR $PACKAGE
if [[ $ARCH =~ armv7 ]]; then
echo "+ Building for ARM"
./swift/utils/build-script --build-subdir buildbot_linux -R --lldb --llbuild --xctest --swiftpm --foundation --libdispatch -- --install-libdispatch --install-foundation --install-swift --install-lldb --install-llbuild --install-xctest --install-swiftpm --install-prefix=/usr '--swift-install-components=autolink-driver;compiler;clang-builtin-headers;stdlib;swift-remote-mirror;sdk-overlay;dev' --build-swift-static-stdlib --build-swift-static-sdk-overlay --skip-test-lldb --install-destdir=${INSTALL_DIR} --installable-package=${PACKAGE}
#./swift/utils/build-script --preset=buildbot_linux_armv7 install_destdir=${INSTALL_DIR} installable_package=${PACKAGE}
else
echo "+ Building for x86"
./swift/utils/build-script --preset=buildbot_linux_${LSB_RELEASE} install_destdir=${INSTALL_DIR} installable_package=${PACKAGE}
fi
