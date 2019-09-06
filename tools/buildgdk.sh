#!/bin/bash
set -eo pipefail

GDKBUILD=${BUILDROOT}/gdk-${GDKVERSION}
GDKVENV=${GDKBUILD}/venv

if [ ! -d ${BUILDROOT} ]; then
    echo "BUILDROOT needs to be set to a valid directory"
    exit 1
fi

if [ -f ${GDKBUILD}/build.done ]; then
    exit 0
fi

echo "GDK: building..."

mkdir -p ${GDKBUILD}

git clone --quiet --depth 1 $PWD/gdk ${GDKBUILD}/src > ${GDKBUILD}/build.log 2>&1

cd ${GDKBUILD}/src

if [ ! -f ${GDKVENV}/build.done ]; then
    virtualenv -p python3 ${GDKVENV} >> ${GDKBUILD}/build.log 2>&1
    source ${GDKVENV}/bin/activate >> ${GDKBUILD}/build.log 2>&1
    pip install -r tools/requirements.txt >> ${GDKBUILD}/build.log 2>&1
    touch ${GDKVENV}/build.done
fi

source ${GDKVENV}/bin/activate >> ${GDKBUILD}/build.log 2>&1
tools/build.sh --gcc --lto=true >> ${GDKBUILD}/build.log 2>&1
touch ${GDKBUILD}/build.done
