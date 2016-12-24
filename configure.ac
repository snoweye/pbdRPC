dnl Process this file with autoconf to produce a configure script
AC_INIT(DESCRIPTION)

dnl Determine R_HOME.
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi
R_SCMD="${R_HOME}/bin/Rscript -e"

dnl Check ssh in path.
AC_CHECK_PROG(SSH, ssh, ssh, "F")
if test "X${SSH}" = "XF"; then
  HAS_SSH="F"
else
  HAS_SSH="T"
fi

dnl All AC_ARG_ENABLE
ENABLE_PLINK=FASLE
AC_ARG_ENABLE(plink,
  AC_HELP_STRING([--enable-plink], [Enable plink, default no.]),
                 [ENABLE_PLINK=TRUE], [ENABLE_PLINK=FALSE])

dnl Get build_bin
SYS_NAME=`${R_SCMD} "source('./R/get_conf.r');get.conf('SYS_NAME')"`
OS_TYPE=`${R_SCMD} "source('./R/get_conf.r');get.conf('OS_TYPE')"`
# if test "X${SYS_NAME}" = "XSunOS" -o "X${SYS_NAME}" = "XDarwin"; then
if test "X${SYS_NAME}" = "XSunOS"; then
  BUILD_BIN=""
else
  BUILD_BIN="plink"
fi
if test "X${SYS_NAME}" = "XWindows" -o "X${HAS_SSH}" = "XF" -o "X${ENABLE_PLINK}" = "XTRUE"; then
  BUILD_BIN="plink"
else
  BUILD_BIN=""
fi

dnl Report
echo " "
echo "******************* Results of pbdRPC package configure *****************"
echo " "
echo ">> SYS_NAME = ${SYS_NAME}"
echo ">> OS_TYPE = ${OS_TYPE}"
echo ">> HAS_SSH = ${HAS_SSH}"
echo ">> ENABLE_PLINK = ${ENABLE_PLINK}"
echo ">> BUILD_BIN = ${BUILD_BIN}"
echo " "
echo "*************************************************************************"
echo " "

dnl Start to substitute templates
AC_SUBST(HAS_SSH)
AC_SUBST(BUILD_BIN)
AC_OUTPUT(src/Makevars)

