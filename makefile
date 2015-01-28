# your executable to be built
TARGET = target

# fill here your cpp files
SRC := main.cpp

# the path where to find your files
# here your target will be generated
BIN_DIR := ./bin/
# every intermediate files go there
OBJ_DIR := ./obj/
# write your sources inside
SRC_DIR := ./src/
# your headers go here (you can have multiple path here)
INC_DIR := ./include/

# add or remove any system library you required
SYS_LIBS := sfml-graphics sfml-window sfml-system GL
# your own dependencies or ones you have near you must go here
DEP_DIR :=
DEP_LIBS :=

OBJ := $(patsubst %.cpp,$(OBJ_DIR)%.o,$(SRC))
DEPENDENCIES := $(OBJ:.o=.d)

INCLUDES := $(addprefix -I,$(INC_DIR))
CXXFLAGS := -MMD -W -Werror -Wall -std=c++14 $(INCLUDES)
LDFLAGS := -W -Wall -Werror
LDLIBS := $(addprefix -L,$(DEP_DIR)) $(addprefix -l,$(DEP_LIBS)) $(addprefix -l,$(SYS_LIBS))
CXX := g++

.PHONY: all debug clean fclean re

debug: CXXFLAGS += -g3
debug: CPPFLAGS += -D__DEBUG__
debug: LDFLAGS += -g3 -D__DEBUG__
debug: $(TARGET)

all: CXXFLAGS += -O3 
all: LDFLAGS += -O3
all: $(TARGET)

$(OBJ_DIR)%.o: $(SRC_DIR)%.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

$(BIN_DIR):
	mkdir -p $@

$(OBJ_DIR):
	mkdir -p $@

-include $(DEPENDENCIES)

$(TARGET): $(BIN_DIR)$(TARGET)

$(BIN_DIR)$(TARGET): $(OBJ) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(LDLIBS)

$(OBJ): | $(OBJ_DIR)

clean:
	$(RM) $(OBJ)
	$(RM) $(DEPENDENCIES)

fclean: clean
	$(RM) $(BIN_DIR)$(TARGET)

re: fclean debug

release: fclean all

