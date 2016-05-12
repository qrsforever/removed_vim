LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := eng
LOCAL_MODULE := XxxDemo
JNI_RES_PATH := $(LOCAL_PATH)

$(info "Build ${LOCAL_MODULE})

LOCAL_SRC_FILES	 += XxxDemo.cpp

LOCAL_C_INCLUDES += ${JNI_RES_PATH}/include 

LOCAL_CPPFLAGS   += -DDEBUG -DHAVE_ANDROID_OS  -DHAVE_SYS_UIO_H

# 编译条件以及第三方库: -lxml2
LOCAL_LDFLAGS += -L${JNI_RES_PATH}/libs -O2

# 系统库
LOCAL_LDLIBS += -lcutils -lutils

# 动态库模块, 如果列出的库不存在会去编译 eg. libxxx
LOCAL_SHARED_LIBRARIES += 

# ALL_DEFAULT_INSTALLED_MODULES += $(LOCAL_MODULE)

# 目标输出类型
include $(BUILD_EXECUTABLE)
# include $(BUILD_STATIC_LIBRARY)
# include $(BUILD_SHARED_LIBRARY)
