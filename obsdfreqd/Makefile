PREFIX?=/usr/local
LDFLAGS  = -lm

CFLAGS  += -pedantic -Wall -Wextra -Wmissing-prototypes \
           -Wunused-function -Wshadow -Wstrict-overflow -fno-strict-aliasing \
           -Wunused-variable -Wstrict-prototypes -Wwrite-strings \
		   -Os

obsdfreqd: main.c
	${CC} ${CFLAGS} ${LDFLAGS} main.c -o $@

all: obsdfreqd

clean:
	rm obsdfreqd

install: obsdfreqd
	install -o root -g wheel -m 555 obsdfreqd ${PREFIX}/sbin/obsdfreqd
	install -o root -g wheel -m 444 obsdfreqd.1 ${PREFIX}/man/man1/obsdfreqd.1
