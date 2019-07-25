PORTNAME=	mono
## 6.0.0 STABLE
PORTVERSION=	6.0.0.313
PORTREVISION=	1
CATEGORIES=	lang
MASTER_SITES=	https://download.mono-project.com/sources/mono/
DISTFILES=	${PORTNAME}-${PORTVERSION}${EXTRACT_SUFX}

MAINTAINER=	prj@rootwyrm.com
COMMENT=	Open source implementation of .NET Development Framework

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

ONLY_FOR_ARCHS=		amd64 armv6 armv7 i386 powerpc64 aarch64

BUILD_DEPENDS=	p5-XML-Parser>=0:textproc/p5-XML-Parser \
		bash:shells/bash \
		cmake>0:devel/cmake 
LIB_DEPENDS=	libiconv.so:converters/libiconv
RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pillow>=0:graphics/py-pillow@${PY_FLAVOR} \
		ca_root_nss>=0:security/ca_root_nss \
		iconv>=0:converters/iconv

CONFLICTS_INSTALL=	czmq-3*

OPTIONS_DEFINE=		MONOLITE INOTIFY NINJA NLS ODBC SQLITE X11
OPTIONS_DEFAULT=	MONOLITE INOTIFY ODBC SQLITE X11
OPTIONS_SUB=	yes

MONOLITE_DESC=		Use monolite to bootstrap mcs (otherwise use installed mcs)
MONOLITE_DISTFILES=	monolite-linux-${MONOLITE_VERSION}-latest.tar.gz:monolite
MONOLITE_MASTER_SITES=	http://download.mono-project.com/monolite/:monolite
## 2018-07-22	1051700033
MONOLITE_VERSION=	1051700033

INOTIFY_DESC= Use libinotify to provide inotify support
INOTIFY_CONFIGURE_OFF=	--disable-inotify
INOTIFY_LIB_DEPENDS=	libnotify.so:devel/libinotify

NINJA_DESC=	Use ninja to build wherever possible (EXPERIMENTAL!)
NINJA_CONFIGURE_OFF=	--disable-ninja
NINJA_BUILD_DEPENDS=	ninja>0:devel/ninja

NLS_CONFIGURE_OFF=	--disable-nls
NLS_USES=	gettext

ODBC_DESC=	System.Data: support for unixODBC
ODBC_BUILD_DEPENDS=	unixODBC>0:databases/unixODBC
ODBC_LIB_DEPENDS=	libodbc.so:databases/unixODBC

SQLITE_DESC=	System.Data: support for SQLite3
SQLITE_RUN_DEPENDS=	sqlite3>0:databases/sqlite3

X11_USES=	display:test

USES=	autoreconf bison compiler:c11 cpe gmake iconv libtool \
	pathfix perl5 python:3.6 shebangfix tar:xz
USE_PERL5=	build
GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes
SHEBANG_FILES=	scripts/mono-package-runtime scripts/mono-heapviz mono/mini/genmdesc.py mono/tests/test_lldb.py mono/tests/gc-descriptors/gen-descriptor-tests.py
BINARY_ALIAS=	python=${PYTHON_CMD}

CONFIGURE_ARGS=	--disable-dtrace --disable-boehm --disable-btls
CONFIGURE_ENV=	ac_cv_header_sys_inotify_h=no

MAKE_ENV=	MONO_SHARED_DIR="${WRKDIR}" \
		INSTALL_STRIP_FLAG="${STRIP}" \
		TZ=UTC

TEST_ARGS=	-k
TEST_TARGET=	check

PORTSCOUT=	limit:^\d+\.\d+\.[1-9]\d*

LOCALBASE?=	/usr/local
.if !exists(${LOCALBASE}/bin/mcs)
OPTIONS_SLAVE=	MONOLITE
.endif

post-extract-MONOLITE-on:
	${MKDIR} ${WRKSRC}/mcs/class/lib/monolite-linux
	${MV} ${WRKDIR}/monolite-linux-${MONOLITE_VERSION}-latest ${WRKSRC}/mcs/class/lib/monolite-linux/${MONOLITE_VERSION}

post-patch:
	${REINPLACE_CMD} -e 's|^#!/bin/bash|#!/usr/bin/env bash|g' \
		${WRKSRC}/scripts/mono-find-provides.in \
		${WRKSRC}/scripts/mono-find-requires.in \
		${WRKSRC}/scripts/mono-test-install
	${FIND} ${WRKSRC} -name '*.sh' | ${XARGS} ${REINPLACE_CMD} \
		-e 's|^#!/bin/bash|#!/bin/sh|g'
	${SED} 's/tarball/${PORTVERSION}/' ${WRKSRC}/mono/mini/Makefile.am.in \
		> ${WRKSRC}/mono/mini/Makefile.am
	${REINPLACE_CMD} -e 's|/usr/share|${PREFIX}|g' \
		${WRKSRC}/mcs/class/corlib/System/Environment.cs \
		${WRKSRC}/external/corefx/src/System.Runtime.Extensions/src/System/Environment.Unix.cs
	${REINPLACE_CMD} -e 's|/usr/share/.mono|${PREFIX}/share/mono|g' \
		${WRKSRC}/man/mono-configuration-crypto.1 \
		${WRKSRC}/man/mono.1 \
		${WRKSRC}/man/mozroots.1

post-configure:
	${REINPLACE_CMD} -e 's|share\/man|man|g' \
		${WRKSRC}/mcs/jay/Makefile

post-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/mono

.include <bsd.port.mk>
