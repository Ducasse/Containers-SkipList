public
testCopy
	"This is a non regression test for http://bugs.squeak.org/view.php?id=6778"
	
    | original copy |
    original := CTSkipList new.
    original at: 3 put: '3333'.
    copy := original copy.
    copy remove: 3.
    self assert: (original includes: 3)
		description: 'changing the copy should not change the original'