main: src/lexer.mll src/parser.mly src/convert.ml src/main.ml
	ocamllex src/lexer.mll
	ocamlyacc src/parser.mly
	ocamlc -c src/convert.ml
	ocamlfind ocamlc -c src/parser.mli -package Convert -linkpkg src/convert.ml
	ocamlc -c src/lexer.ml
	ocamlc -c src/parser.ml
	ocamlc -c src/main.ml
	ocamlc -o bin/main src/lexer.cmo src/convert.cmo src/parser.cmo src/main.cmo

clean:
	-$(RM) src/*.cmi src/*.cmo src/main
