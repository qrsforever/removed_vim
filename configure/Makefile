# 通用 Makefile 
 
# $(info "######## Makefile #######")

# 其他变量
OPTIMIZE := -O2
WARNINGS := -Wall -Wno-unused -Wno-format
DEFS     := -DDEBUG

# 初始化编译工具以及编译选项
CROSS_COMPILE = 
GCC 	:= $(CROSS_COMPILE)gcc
CXX 	:= $(CROSS_COMPILE)g++
CC		:=
AR		:= $(CROSS_COMPILE)ar
CFLAGS  := $(OPTIMIZE) $(WARNINGS) $(DEFS)
CPPFLAGS:= 
LDFLAGS := -lpthread
INCLUDE :=

# 源文件可能的后缀
SRCEXTS := c C cc cpp CPP c++ cxx cp
HDREXTS := h H hh hpp HPP h++ hxx hp

# 指定源文件目录, 以及目标文件生成目录
SRC_DIR = . src
INC_DIR = . src
OBJ_DIR = out/target

# 额外增加的源文件或者排除不编译的源文件
SPECIAL_SRC := 
EXCLUDE_SRC := 

# 设置目标类型(app, ar, so), 及目标名字
TARGET_TYPE := app
TARGET_TYPE := $(strip $(TARGET_TYPE))
TARGET_NAME := out/mqttc

ifeq ($(TARGET_TYPE), so)
	TARGET_NAME := out/lib$(shell basename $(PWD).so)
else
	ifeq ($(TARGET_TYPE), ar)
		TARGET_NAME := out/lib$(shell basename $(PWD).a)
	endif
endif

# 追加搜索目录
SRC_DIR	+= $(dir $(SPECIAL_SRC))
INC_DIR += $(SRC_DIR)

# 源文件, 头文件, 链接文件
SOURCES = $(filter-out $(EXCLUDE_SRC), $(foreach d, $(SRC_DIR), $(wildcard $(addprefix $(d)/*., $(SRCEXTS)))))
HEADERS = $(foreach d, $(INC_DIR), $(wildcard $(addprefix $(d)/*., $(HDREXTS))))
OBJECTS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(basename $(notdir $(SOURCES)))))

# 配置编译选项
INCLUDE += $(foreach d, $(sort $(INC_DIR)), -I$d)
ifeq ($(TARGET_TYPE), so)
	CFLAGS  += -fpic -shared
	LDFLAGS += -shared
endif

# 定义伪目标
PHONY = all .mkdir clean

all: .mkdir $(TARGET_NAME)

# 函数: 添加%.x依赖文件的路径
define add_vpath
$1

endef

# 函数: 生成中间文件
define gen_o_cmd
$2/%.o: %.$1
	$(CXX) $(INCLUDE) -Wp,-MT,$$@ -Wp,-MMD,$$@.d $(CFLAGS) $(CPPFLAGS) -c -o $$@ $$<

endef

# 执行函数, make会将函数里的内容当Makefile解析, 注意$$符号
# $(eval $(foreach i, $(SRCEXTS), $(foreach d, $(SRC_DIR), $(call add_vpath,vpath %.$i $d))))
$(eval $(foreach i, $(SRCEXTS), $(call gen_o_cmd,$i,$(OBJ_DIR))))

# 静态, 动态, 可执行
ifeq ($(TARGET_TYPE), ar)
$(TARGET_NAME): $(OBJECTS)
	rm -f $@
	$(AR) rcvs $@ $(OBJECTS)
else 
$(TARGET_NAME): LD=$(if $(filter-out %.c %.C, $(SOURCES)),$(CXX),$(GCC))
$(TARGET_NAME): $(OBJECTS)
	$(LD) $(OBJECTS) -o $@ $(LDFLAGS) 
endif

.mkdir:
	@if [ ! -d $(OBJ_DIR) ]; then mkdir -p $(OBJ_DIR); fi

clean:
	rm -rf $(OBJ_DIR) $(TARGET_NAME)

run:$(TARGET_NAME)
	@$(TARGET_NAME)
	

.PHONY: $(PHONY) 
