TANGLELUA=~/Workspace/pandoc-tangle/tangle.lua

verify: checker.mm
	metamath "read checker.mm" "verify proof *" "exit"

checker.mm: checker.md
	pandoc --from markdown --to $(TANGLELUA) --metadata=code:.mm checker.md > checker.mm

clean:
	rm checker.mm
