PORTNAME=	libgdiplus-devel
CATEGORIES=	x11-toolkits
DISTVERSION=	5.6.2

USE_GITHUB=	yes
GH_ACCOUNT=	mono
GH_PROJECT=	libgdiplus
GH_TAGNAME=	91f3b96

MAINTAINER=	prj@rootwyrm.com
COMMENT=	GDI+ API for System.Windows.Forms in Mono

LICENSE=	GPLv3
LICENSE_FILE=	${WRKSRC}/COPYING

LIB_DEPENDS=	libtiff.so:graphics/tiff \
		libgif.so:graphics/giflib \
		libpng.so:graphics/png \
		libpango-1.0.so:x11-toolkits/pango \
		libfreetype.so:print/freetype2 \
		libexif.so:graphics/libexif \
		libfontconfig.so:x11-fonts/fontconfig

GNU_CONFIGURE=	yes
USES=		autoreconf cpe gettext-runtime gmake gnome jpeg libtool:keepla pathfix pkgconfig
USE_LDCONFIG=	yes
CPPFLAGS+=	-I${LOCALBASE}/include
LDFLAGS+=	-L${LOCALBASE}/lib
INSTALL_TARGET=	install-strip
CPE_VENDOR=	mono-project

OPTIONS_DEFINE=	X11
OPTIONS_DEFAULT=X11

X11_USE=	XORG=x11,xrender
X11_CONFIGURE_OFF=	--without-x11

PLIST_FILES=	lib/libgdiplus.a \
		lib/libgdiplus.la \
		lib/libgdiplus.so \
		lib/libgdiplus.so.0 \
		lib/libgdiplus.so.0.0.0 \
		libdata/pkgconfig/libgdiplus.pc

.include <bsd.port.mk>
