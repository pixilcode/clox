# Use `gcc` to compile C code
CC := gcc

# The name of the target executable 
TARGET_EXEC := clox

# Build and source directories
BUILD_DIR := ./build
SRC_DIR := ./src

# All of the source files that we want to compile
SRCS := $(shell find $(SRC_DIR) -name '*.c')

# All of the object files that should be produced
OBJS := $(SRCS:%.c=$(BUILD_DIR)/%.o)

# Default is to build the executable
all: build

# Build the executable
build: $(BUILD_DIR)/$(TARGET_EXEC)

# Link together the object files
$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Build the object files
$(BUILD_DIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Run the executable
run: build
	@$(BUILD_DIR)/$(TARGET_EXEC)

debug: build
	@gdb $(BUILD_DIR)/$(TARGET_EXEC)

clean:
	rm -r $(BUILD_DIR)

.PHONY: all build run clean
