#!/bin/bash
#
# Copyright (C) 2018 The MoKee Open Source Project
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

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

MK_ROOT="$MY_DIR"/../../..

HELPER="$MK_ROOT"/vendor/mk/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

SRC=$1
SRC_QC=$2

if [ -z "$SRC" ]; then
    SRC=adb
fi

# Initialize the helper
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$MK_ROOT" true "$CLEAN_VENDOR"

extract "$MY_DIR"/proprietary-files.txt "$SRC" "$SECTION"
extract "$MY_DIR"/proprietary-files-qc.txt "$SRC_QC" "$SECTION"

if [ -s "$MY_DIR"/../$DEVICE/proprietary-files.txt ]; then
    # Reinitialize the helper for device
    setup_vendor "$DEVICE" "$VENDOR" "$MK_ROOT" false "$CLEAN_VENDOR"

    extract "$MY_DIR"/../$DEVICE/proprietary-files.txt "$SRC" "$SECTION"
fi

"$MY_DIR"/setup-makefiles.sh

BLOB_ROOT="$MK_ROOT"/vendor/"$VENDOR"/"$DEVICE_COMMON"/proprietary

# Camera
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/bin/mm-qcamera-daemon
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera2_cpp_module.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera2_iface_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera2_imglib_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera2_mct.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera2_pproc_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera2_sensor_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera2_stats_algorithm.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera2_stats_modules.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_dbg.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_hvx_grid_sum.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_hvx_zzHDR.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_imglib.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_isp_mesh_rolloff44.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_pdaf.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_pdafcamif.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_tintless_algo.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_tintless_bg_pca_algo.so
sed -i 's|/data/misc/camera|/data/vendor/qcam|g' $BLOB_ROOT/vendor/lib/libmmcamera_tuning.so

# Fingerprint
sed -i 's|\x00fpc_fingerprint\x00|\x00fingerprint\x00\x00\x00\x00\x00|' $BLOB_ROOT/vendor/lib64/hw/fingerprint.fpc.so
sed -i 's|\x00gxfingerprint\x00|\x00fingerprint\x00\x00\x00|' $BLOB_ROOT/vendor/lib64/hw/fingerprint.goodix.so
