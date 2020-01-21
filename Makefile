ifeq ($(shell uname -o), Msys)
DLLSUF=.dll
EXESUF=.exe
else
DLLSUF=.so
EXESUF=
endif

all: libcallf$(DLLSUF)

test: test$(EXESUF)

clean:
	-rm -f libcallf$(DLLSUF) test$(EXESUF) *.o

.PHONY: all test clean

libcallf$(DLLSUF): callf.s.o callf.c.o
	ar r $@ $^

callf.s.o: callf.s
	as -o $@ $<

callf.c.o: callf.c callf.h
	gcc -c -o $@ $<

test$(EXESUF): test.c.o libcallf$(DLLSUF)
	gcc -o $@ $< -L. -lcallf

test.c.o: test.c callf.h
	gcc -c -o $@ $<