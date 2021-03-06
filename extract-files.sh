#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

DEVICE=rolex
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

LINEAGE_ROOT="$MY_DIR"/../../..

HELPER="$LINEAGE_ROOT"/vendor/lineage/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

while [ "$1" != "" ]; do
    case $1 in
        -n | --no-cleanup )     CLEAN_VENDOR=false
                                ;;
        -s | --section )        shift
                                SECTION=$1
                                CLEAN_VENDOR=false
                                ;;
        * )                     SRC=$1
                                ;;
    esac
    shift
done

if [ -z "$SRC" ]; then
    SRC=adb
fi

# Initialize the helper for common device
setup_vendor "$DEVICE" "$VENDOR" "$LINEAGE_ROOT" false "$CLEAN_VENDOR"

extract "$MY_DIR"/proprietary-files.txt "$SRC" "$SECTION"

"$MY_DIR"/setup-makefiles.sh

# Define blobs path for the following hax
BLOB_ROOT="$LINEAGE_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary

# Hax for camera configs
CAMERA2_SENSOR_MODULES="$LINEAGE_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary/vendor/lib/libmmcamera2_sensor_modules.so
sed -i "s|/system/etc/camera/|/vendor/etc/camera/|g" "$CAMERA2_SENSOR_MODULES"

# Hax for disable colorspace
sed -i "s|EGL_KHR_gl_colorspace|DIS_ABL_ED_colorspace|g" $BLOB_ROOT/vendor/lib/egl/eglSubDriverAndroid.so
sed -i "s|EGL_KHR_gl_colorspace|DIS_ABL_ED_colorspace|g" $BLOB_ROOT/vendor/lib/egl/eglsubAndroid.so
sed -i "s|EGL_KHR_gl_colorspace|DIS_ABL_ED_colorspace|g" $BLOB_ROOT/vendor/lib/egl/libRBEGL_adreno.so
sed -i "s|EGL_KHR_gl_colorspace|DIS_ABL_ED_colorspace|g" $BLOB_ROOT/vendor/lib64/egl/eglSubDriverAndroid.so
sed -i "s|EGL_KHR_gl_colorspace|DIS_ABL_ED_colorspace|g" $BLOB_ROOT/vendor/lib64/egl/eglsubAndroid.so
sed -i "s|EGL_KHR_gl_colorspace|DIS_ABL_ED_colorspace|g" $BLOB_ROOT/vendor/lib64/egl/libRBEGL_adreno.so
