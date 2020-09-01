verify: checker.mm
	metamath "read checker.mm" "verify proof *" "exit"

checker.mm: checker.md
	pandoc --from markdown --to pandoc-tangle/tangle.lua --metadata=code:.mm checker.md > checker.mm
