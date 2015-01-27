TARGET = bin/target

SRC =	main.cpp

OBJ = $(patsubst %.cpp,./src/%.o,$(SRC))
DEPENDENCIES := $(OBJ:.o=.d)

INCLUDES = -I./includes
CXXFLAGS = -MMD -W -Werror -Wall -std=c++14 $(INCLUDES)
LDFLAGS = $(CXXFLAGS)
LDLIBS = -lsfml-graphics -lsfml-window -lsfml-system -lGL
CXX = g++


.PHONY: all debug clean fclean re mk_target_dir

debug: CXXFLAGS += -g3 -D__DEBUG__
debug: LDFLAGS += -g3 -D__DEBUG__
debug: $(TARGET)

all: CXXFLAGS += -O3 
all: LDFLAGS += -O3
all: $(TARGET)

-include $(DEPENDENCIES)

$(TARGET): $(OBJ) mk_target_dir
	$(CXX) $(LDFLAGS) $(OBJ) -o $(TARGET) $(LDLIBS)

clean:
	$(RM) $(OBJ)
	$(RM) $(DEPENDENCIES)

fclean: clean
	$(RM) $(TARGET)

re: fclean debug

release: fclean all

mk_target_dir:
	mkdir -p bin
