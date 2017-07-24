CXX = g++
CXXFLAGS = -g -O3
LDFLAGS = -g -static

OBJECTS = scrambler.o \
	  parser.o \
	  lexer.o

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

scrambler: $(OBJECTS)
	$(CXX) $(OBJECTS) $(LDFLAGS) -o $@


scrambler.cpp: parser.cpp

parser.cpp: parser.y lexer.cpp
	bison -o $@ $<

lexer.cpp: lexer.l
	flex --header-file="lexer.h" -o $@ $<

clean:
	rm -f $(OBJECTS) lexer.cpp lexer.h parser.cpp parser.h scrambler
