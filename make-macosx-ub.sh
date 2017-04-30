#!/bin/sh
APPBUNDLE=Tremfusion.app
BINARY=tremulous.x86_64
DEDBIN=tremded.x86_64
TTYBIN=tremulous-tty.x86_64
PKGINFO=APPLTREMFUSION
ICNS=misc/Tremfusion.icns
DESTDIR=build/release-darwin-ub
BASEDIR=base

BIN_OBJ="
	build/release-darwin-x86_64/tremulous.x86_64
"
BIN_DEDOBJ="
	build/release-darwin-x86_64/tremded.x86_64
"
BIN_TTYOBJ="
	build/release-darwin-x86_64/tremulous-tty.x86_64
"
BASE_OBJ="
	build/release-darwin-x86_64/$BASEDIR/uix86_64.dylib
"

cd `dirname $0`
if [ ! -f Makefile ]; then
	echo "This script must be run from the Tremfusion build directory";
	exit 1
fi

Q3_VERSION=`grep '^VERSION=' Makefile | sed -e 's/.*=\(.*\)/\1/'`

echo "Creating .app bundle $DESTDIR/$APPBUNDLE"
if [ ! -d $DESTDIR/$APPBUNDLE/Contents/MacOS/$BASEDIR ]; then
	mkdir -p $DESTDIR/$APPBUNDLE/Contents/MacOS/$BASEDIR || exit 1;
fi
if [ ! -d $DESTDIR/$APPBUNDLE/Contents/MacOS/$MPACKDIR ]; then
	mkdir -p $DESTDIR/$APPBUNDLE/Contents/MacOS/$MPACKDIR || exit 1;
fi
if [ ! -d $DESTDIR/$APPBUNDLE/Contents/Resources ]; then
	mkdir -p $DESTDIR/$APPBUNDLE/Contents/Resources
fi
cp $ICNS $DESTDIR/$APPBUNDLE/Contents/Resources/Tremfusion.icns || exit 1;
echo $PKGINFO > $DESTDIR/$APPBUNDLE/Contents/PkgInfo
echo "
	<?xml version=\"1.0\" encoding=\"UTF-8\"?>
	<!DOCTYPE plist
		PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\"
		\"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
	<plist version=\"1.0\">
	<dict>
		<key>CFBundleDevelopmentRegion</key>
		<string>English</string>
		<key>CFBundleExecutable</key>
		<string>$BINARY</string>
		<key>CFBundleGetInfoString</key>
		<string>$Q3_VERSION</string>
		<key>CFBundleIconFile</key>
		<string>Tremfusion.icns</string>
		<key>CFBundleIdentifier</key>
		<string>net.tremfusion</string>
		<key>CFBundleInfoDictionaryVersion</key>
		<string>6.0</string>
		<key>CFBundleName</key>
		<string>Tremfusion</string>
		<key>CFBundlePackageType</key>
		<string>APPL</string>
		<key>CFBundleShortVersionString</key>
		<string>$Q3_VERSION</string>
		<key>CFBundleSignature</key>
		<string>$PKGINFO</string>
		<key>CFBundleVersion</key>
		<string>$Q3_VERSION</string>
		<key>NSExtensions</key>
		<dict/>
		<key>NSPrincipalClass</key>
		<string>NSApplication</string>
	</dict>
	</plist>
	" > $DESTDIR/$APPBUNDLE/Contents/Info.plist

cp $BIN_OBJ $DESTDIR/$APPBUNDLE/Contents/MacOS/
cp $BIN_DEDOBJ $DESTDIR/$APPBUNDLE/Contents/MacOS/
cp $BIN_TTYOBJ $DESTDIR/$APPBUNDLE/Contents/MacOS/
cp $BASE_OBJ $DESTDIR/$APPBUNDLE/Contents/MacOS/$BASEDIR/
cp src/libs/macosx/*.dylib $DESTDIR/$APPBUNDLE/Contents/MacOS/
