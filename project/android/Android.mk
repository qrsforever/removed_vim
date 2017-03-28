LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

src_dirs : src
res_dirs : res
aidl_dirs: java

# 选择什么情况下编译 user, eng, tests, optional(所有版本)
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(call all-java-files-under, $(src_dirs)) 

LOCAL_RESOURCE_DIR := $(addprefix $(LOCAL_PATH)/, $(res_dirs))
			
# 指定AIDL的路径
LOCAL_AIDL_INCLUDES := 

# 依赖的共享库
LOCAL_JAVA_LIBRARIES :=

# 依赖的静态库
LOCAL_STATIC_JAVA_LIBRARIES :=


LOCAL_PACKAGE_NAME :=

# 签名类型testkey, platform, shared, media
LOCAL_CERTIFICATE := platform

# 使能混淆
LOCAL_PROGUARD_ENABLED := full

# 指定混淆配置
LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_DEX_PREOPT := false

# 不是标准的java库
# LOCAL_NO_STANDARD_LIBRARIES := true

include $(BUILD_PACKAGE)

# include $(BUILD_JAVA_LIBRARY)

# Use the folloing include to make our test apk.
include $(call all-makefiles-under,$(LOCAL_PATH))
