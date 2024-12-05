CC = gcc
GG = g++
SRC_DIR = ./../cpp
INCLUDES = -I../include/dynamixel_sdk -I../include/HPS3D -I../include/lidar -I../include/nlohmann -I../include/unitree_lidar_sdk
LIB_DIR = ../lib/cpp/arm64
CFLAGS = -Wall -O -g $(INCLUDES)
TARGET = ./blocked_working

%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $@
%.o:%.cpp
	$(GG) $(CFLAGS) -c $< -o $@

SOURCES = $(SRC_DIR)/blocked_working.cpp #$(wildcard *.c *.cpp)
LIBRARIES = -l unitree_legged_sdk -l HPS3DSDK -l dxl_x64_cpp -l unitree_lidar_sdk
OBJS = $(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(SOURCES)))

$(TARGET):$(OBJS)
	$(GG) $(OBJS) $(INCLUDES) -o $(TARGET) -Wl,-rpath=../lib/cpp/arm64 -L$(LIB_DIR) -pthread $(LIBRARIES)
	chmod a+x $(TARGET)
 
clean:
	rm -rf *.o $(TARGET)
