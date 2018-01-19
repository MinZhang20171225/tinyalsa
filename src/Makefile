CC = gcc
CFLAGS = -Wall -lasound
OBJS = tinyplay.o mixer.o pcm.o

all: tinyplay

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

tinyplay: $(OBJS)
	$(CC) -o $@ $(OBJS)

clean:
	rm -f rbcfg *.o tinyplay tinymix
