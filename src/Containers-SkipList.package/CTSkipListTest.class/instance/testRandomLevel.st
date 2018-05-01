implementationTests
testRandomLevel
	"a randomLevel should not be greater than maxLevel"
	"self run: #testRandomLevel"
	| s |
	s := CTSkipList new.
	s maxLevel: 5.
	self assert: s randomLevel <= 5