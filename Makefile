# Adapted from Makefile for Dingux by Rikku2000

include config.mak

TARGET = sdlpal

HOST =

ADPLUG_C_FILES = adplug/fmopl.c

ADPLUG_CXX_FILES = adplug/rix.cpp adplug/player.cpp adplug/binio.cpp \
	adplug/fprovide.cpp adplug/binfile.cpp adplug/dosbox_opl.cpp \
	adplug/surroundopl.cpp adplug/emuopl.cpp

LIBMAD_C_FILES = libmad/bit.c libmad/decoder.c libmad/fixed.c libmad/frame.c \
	libmad/huffman.c libmad/layer12.c libmad/layer3.c libmad/music_mad.c \
	libmad/stream.c libmad/synth.c libmad/timer.c

C_FILES = text.c font.c itemmenu.c scene.c palcommon.c script.c \
	util.c play.c getopt.c input.c uibattle.c game.c magicmenu.c map.c \
	ending.c uigame.c rngplay.c ui.c global.c main.c fight.c \
	video.c palette.c sound.c res.c battle.c yj1.c

CXX_FILES = rixplay.cpp

C_FILES += $(ADPLUG_C_FILES)
C_FILES += $(LIBMAD_C_FILES)
CXX_FILES += $(ADPLUG_CXX_FILES)

C_OBJS = $(C_FILES:%.c=%.o)
OBJS = $(C_OBJS)

CXX_OBJS = $(CXX_FILES:%.cpp=%.o)
OBJS += $(CXX_OBJS)

CFLAGS += -g -Wall -O2 -fno-strict-aliasing -fno-aggressive-loop-optimizations
LDFLAGS += -lm

CC = $(HOST)gcc
CXX = $(HOST)g++

# FIXME: check %.h
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.cpp
	$(CXX) $(CFLAGS) -c -o $@ $<

$(TARGET): $(OBJS)
	$(CXX) -o $(TARGET) $^ $(LDFLAGS)

clean:
	@rm -f $(TARGET) $(OBJS)
