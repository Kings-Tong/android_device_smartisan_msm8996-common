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

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    camera_shim.cpp

LOCAL_SHARED_LIBRARIES := \
    libgui \
    libui

LOCAL_C_INCLUDES := \
    frameworks/native/include

LOCAL_MODULE := libshim_camera
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32

LOCAL_VENDOR_MODULE := true

include $(BUILD_SHARED_LIBRARY)

