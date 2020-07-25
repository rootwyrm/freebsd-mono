# Created by: Yukihiro Nakai <nakai@FreeBSD.org>
# $FreeBSD: head/lang/mono/Makefile 529063 2020-03-24 19:54:57Z antoine $

PORTNAME=	mono
PORTVERSION=	6.8.0.123
CATEGORIES=	lang
MASTER_SITES=	https://download.mono-project.com/sources/mono/
DISTFILES=	${PORTNAME}-${PORTVERSION}${EXTRACT_SUFX}

MAINTAINER=	prj+ports@rootwyrm.com
COMMENT=	Open source implementation of .NET Development Framework

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

.if defined(QEMU_EMULATING) && "${QEMU_EMULATING}" == "1"
BROKEN=		fails to build under qemu: Roslyn requires more functional POSIX implementation
.endif
NOT_FOR_ARCHS=	armeb riscv64 riscv64sf sparc64

BUILD_DEPENDS=	p5-XML-Parser>=0:textproc/p5-XML-Parser \
		bash:shells/bash \
		cmake>0:devel/cmake
LIB_DEPENDS=	libinotify.so:devel/libinotify \
		libiconv.so:converters/libiconv
RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pillow>=0:graphics/py-pillow@${PY_FLAVOR} \
		ca_root_nss>=0:security/ca_root_nss \
		sqlite3>0:databases/sqlite3 \
		zip>=0:archivers/zip

CONFLICTS_INSTALL=	czmq-3*

USES=	autoreconf bison compiler:c11 cpe gmake iconv libtool \
	pathfix perl5 python:3.6+ shebangfix tar:xz
USE_PERL5=	build

CONFIGURE_SCRIPT=	autogen.sh
GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes

SHEBANG_FILES=  scripts/mono-package-runtime scripts/mono-heapviz mono/mini/genmdesc.py \
	mono/tests/test_lldb.py mono/tests/gc-descriptors/gen-descriptor-tests.py \
	scripts/mono-find-provides.in scripts/mono-find-requires.in
BINARY_ALIAS=   python=${PYTHON_CMD}

CONFIGURE_ARGS_aarch64= --with-csc=mcs
CONFIGURE_ARGS= ${CONFIGURE_ARGS_${ARCH}} --disable-dtrace
# Do not remove - this is needed to work around automake's lack of hinting
CONFIGURE_ENV+= ac_cv_header_sys_inotify_h=yes

MAKE_ENV=	MONO_SHARED_DIR="${WRKDIR}" \
		INSTALL_STRIP_FLAG="${STRIP}"

TEST_ARGS=	-k
TEST_TARGET=	check

PORTSCOUT=	limit:^\d+\.\d+\.[1-9]\d*

LOCALBASE?=	/usr/local
.if !exists(${LOCALBASE}/bin/mcs)
OPTIONS_SLAVE=	MONOLITE
.endif

MONOLITE_DESC=          Use monolite to bootstrap mcs (otherwise use installed mcs)
MONOLITE_DISTFILES=     monolite-linux-${MONOLITE_VERSION}-latest.tar.gz:monolite
MONOLITE_MASTER_SITES=  http://download.mono-project.com/monolite/:monolite
# DO NOT ALTER OR REMOVE. DANGER, CASE-SENSITIVE!
# monolite 2020-01-13 @ 1798d23b
MONOLITE_VERSION=       1798d23b-3dbc-4161-b3f4-6bb00134ee4e

.include <bsd.port.options.mk>

OPTIONS_DEFINE=		MONOLITE BIGARRAY NINJA NLS ODBC SPECTRE X11 MONODEV
OPTIONS_DEFAULT=	MONOLITE NLS X11
OPTIONS_SUB=	yes

BIGARRAY_DESC=	Enable allocating arrays greater than Int32.MaxValue
BIGARRAY_CONFIGURE_ENABLE=	big-arrays

NINJA_DESC=	Use ninja to build wherever possible
NINJA_CONFIGURE_ON=	ninja
NINJA_BUILD_DEPENDS=	ninja>0:devel/ninja

NLS_DESC=	NLS Localization Support
NLS_CONFIGURE_OFF=	--disable-nls
NLS_USES=	gettext

ODBC_DESC=	System.Data: support for unixODBC
ODBC_BUILD_DEPENDS=	unixODBC>0:databases/unixODBC
ODBC_LIB_DEPENDS=	libodbc.so:databases/unixODBC

X11_USES=	display:test
X11_CONFIGURE_WITH=	x
X11_RUN_DEPENDS=	pango>0:x11-toolkits/pango \
	libgdiplus>0:x11-toolkits/libgdiplus

MONODEV_DESC=	Build for Mono development (disables crash privacy)
.if ${PORT_OPTIONS:MMONODEV}
CONFIGURE_ARGS+=--enable-icall-symbol-map --enable-icall-export --with-crash_privacy=no
.endif

SPECTRE_DESC=	Enable internal Mono Spectre mitigations (SEE pkg-descr)
.if ${PORT_OPTIONS:MSPECTRE}
CONFIGURE_ARGS+=--with-spectre-mitigation=yes
.endif

post-patch:
	# Needed to force regeneration due to tarball packaging
	${RM} ${WRKSRC}/configure ${WRKSRC}/Makefile \
		${WRKSRC}/mono/Makefile \
		${WRKSRC}/mono/native/Makefile 

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/mono

.include <bsd.port.pre.mk>

.if ${ARCH} == "powerpc64" || ${ARCH} == "powerpc"
PLIST+= ${.CURDIR}/pkg-plist.powerpc
.endif

.include <bsd.port.post.mk>
