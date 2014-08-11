TARGET	= test
OBJS 	= data/test main

OBJECTS	= $(addsuffix .o, $(addprefix $(OBJECT_DIR),$(subst /,-,$(OBJS))))

SOURCE_DIR	= src/
INCLUDE_DIR	= src/
OBJECT_DIR	= objs/
DEPENDENCY_DIR	= dep/

COMPILER		= clang++
LINKER			= clang++
COMMON_FLAGS	= -O2 -std=c++11 -Wall -g -I$(INCLUDE_DIR)
COMPILE_FLAGS	= $(COMMON_FLAGS) -c
LINK_FLAGS		= $(COMMON_FLAGS) -g
DEP_FLAGS			= $(COMMON_FLAGS) -MM -MF $(DEPENDENCY_DIR)$$(addsuffix .d,$$(basename $$(subst /,-,$$<)))
COMPILE_CMD		= $(COMPILER) $(COMPILE_FLAGS) -o $$@ $$<
LINK_CMD		= $(LINKER) $(LINK_FLAGS) -o $@ $^
DEP_CMD			= $(COMPILER) $(DEP_FLAGS) $$<

$(TARGET) 	: $(OBJECTS)
	$(LINK_CMD)

define COMPILE_MACRO
$(OBJECT_DIR)$(subst /,-,$(1).o) 	: $(SOURCE_DIR)$(1).cpp
	$(COMPILE_CMD)
	@$(DEP_CMD)
	@sed -e  's#\s*[a-zA-Z/]*\.o#$$@#g'< $(DEPENDENCY_DIR)$$(addsuffix .d,$$(basename $$(subst /,-,$$<))) \
	   	> $(DEPENDENCY_DIR)$$(addsuffix .P,$$(basename $$(subst /,-,$$<)))
endef

$(foreach i,$(OBJS),$(eval $(call COMPILE_MACRO,$(i))))

-include $(DEPENDENCY_DIR)*.P

.PHONY	: clean

clean 	:
	rm -rf $(TARGET) $(OBJECTS) $(DEPENDENCY_DIR)*.d $(DEPENDENCY_DIR)*.P

