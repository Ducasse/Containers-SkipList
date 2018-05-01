public
testRemove
	"tests size after removing element"
	"self run:#testRemove"
	
	| s |
	s := CTSkipList new.
	s add: 1.
	self assert: s size = 1.
	self
		should: [s remove: 2]
		raise: Exception.
	s remove: 1.
	self assert: s size = 0
