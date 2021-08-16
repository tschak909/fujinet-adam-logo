TARGET_EXEC ?= eos

BUILD_DIR ?= ./build
SRC_DIRS ?= ./src

CC=zcc
AS=z88dk-z80asm

SRCS := $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c -or -name *.s)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

CFLAGS=+coleco -subtype=adam
LDFLAGS=+coleco -subtype=adam -ofujinet-logo -create-app -leos

INC_DIRS := $(shell find $(SRC_DIRS) -type d)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS)

# c source
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

.PHONY: clean

clean:
	$(RM) -r fujinet-logo* $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p
