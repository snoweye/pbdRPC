dnl Process this file with autoconf to produce a configure script
AC_INIT(DESCRIPTION)

dnl Determine R_HOME.
: ${R_HOME=`R RHOME`}
if test -z "${R_HOME}"; then
  echo "could not determine R_HOME"
  exit 1
fi
R_SCMD="${R_HOME}/bin/Rscript -e"

dnl Get build_bin
SYS_NAME=`${R_SCMD} "source('./R/get_conf.r');get.conf('SYS_NAME')"`
OS_TYPE=`${R_SCMD} "source('./R/get_conf.r');get.conf('OS_TYPE')"`
# if test "${SYS_NAME}" = "SunOS" -o "${SYS_NAME}" = "Darwin"; then
#   BUILD_BIN=""
# else
#   BUILD_BIN="plink"
# fi
if test "${SYS_NAME}" = "Windows"; then
  BUILD_BIN="plink"
else
  BUILD_BIN=""
fi

dnl Check ssh in path.
AC_CHECK_PROG(SSH, ssh, ssh, "F")
if test "${SSH}" = "F"; then
  HAS_SSH="F"
else
  HAS_SSH="T"
fi

dnl Report
echo " "
echo "******************* Results of pbdRPC package configure *****************"
echo " "
echo ">> SYS_NAME = ${SYS_NAME}"
echo ">> OS_TYPE = ${OS_TYPE}"
echo ">> HAS_SSH = ${HAS_SSH}"
echo ">> BUILD_BIN = ${BUILD_BIN}"
echo " "
echo "*************************************************************************"
echo " "

dnl Start to substitute templates
AC_SUBST(HAS_SSH)
AC_SUBST(BUILD_BIN)
AC_OUTPUT(src/Makevars)

