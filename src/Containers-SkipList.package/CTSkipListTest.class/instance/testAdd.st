implementationTests
testAdd
	"tests size after adding element"
	
	"self run:#testAdd"
	| s |
	s := CTSkipList new.
	s add: 1.
	self assert: s size = 1
