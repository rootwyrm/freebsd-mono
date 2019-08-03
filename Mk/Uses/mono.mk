# Provide a DEFAULT_VERSIONS mechanism for mono
# Feature:		mono
# Usage:		USES=mono or USES=mono:args
# Valid ARGS:	<version>
#
# version		If no version is given (by the maintainer via the port), use
#				the default version defined by DEFAULT_VERSIONS+=mono

.if !defined(_INCLUDE_USES_MONO_MK)
_INCLUDE_USES_MONO_MK=	yes

.if !empty(mono_ARGS)
.undef _WANT_MONO_VER
_WANT_MONO_VER=		${_MONO_ARGS}
.endif

.if defined(DEFAULT_MONO_VER)
WARNING+=	"DEFAULT_MONO_VER is defined, consider using DEFAULT_VERSIONS=mono=${DEFAULT_MONO_VER} instead"
.endif

DEFAULT_MONO_VER?=		${MONO_DEFAULT}

.if defined(WITH_MONO_VER) && ${WITH_MONO_VER} != ${_WANT_MONO_VER}
IGNORE=		cannot install: the port wants ${_WANT_MONO_VER} and you are using mono ${WITH_MONO_VER}
.endif

MONO_VER=		${_WANT_MONO_VER}
.elif defined(WITH_MONO_VER)
MONO_VER=		${WITH_MONO_VER}
.else
.if defined(_MONO_VER)
MONO_VER=		${_MONO_VER}
.else
MONO_VER=		${DEFAULT_MONO_VER}
.endif
