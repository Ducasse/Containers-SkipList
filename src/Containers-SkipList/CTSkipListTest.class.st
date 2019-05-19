"
A SkipListTest is tests basic functionality of SkipList

Instance Variables: none

"
Class {
	#name : #CTSkipListTest,
	#superclass : #ClassTestCase,
	#category : 'Containers-SkipList-Tests'
}

{ #category : #coverage }
CTSkipListTest >> classToBeTested [

	^ CTSkipList
]

{ #category : #implementationTests }
CTSkipListTest >> testAdd [
	"tests size after adding element"
	
	"self run:#testAdd"
	| s |
	s := CTSkipList new.
	s add: 1.
	self assert: s size = 1

]

{ #category : #implementationTests }
CTSkipListTest >> testAddIfPresent [
	"adds an already existing element. Decides to add another one in the
	ifPresent block"
	
	| s |
	s := CTSkipList new.
	s add: 1.
	self
		shouldnt: [s
					add: 1
					ifPresent: [s add: 2]]
		raise: Exception.
	self assert: s size = 2

]

{ #category : #public }
CTSkipListTest >> testAt [
	"self run: #testAt"
	"self debug: #testAt"

	| sk |
	sk := CTSkipList new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk at: 3 put: '666'.
	self assert: (sk at: 7) = '77777'.
	self assert: (sk includes: 7). 
	self assert: (sk at: 3) = '3333'.
	self assert: (sk includes: 3). 
	self assert: (sk size) = 3

	
]

{ #category : #public }
CTSkipListTest >> testAtPutAlreadyPresent [
	"self run: #testAtPutAlreadyPresent"
	"self debug: #testAtPutAlreadyPresent"

	| sk |
	sk := CTSkipList new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk at: 3 put: '666'.
	
	self assert: (sk at: 7) = '77777'.
	self assert: (sk includes: 7). 
	
	self assert: (sk at: 3) = '3333'.
	
	self assert: (sk includes: 3). 
	self assert: (sk size) = 3

	
]

{ #category : #public }
CTSkipListTest >> testCopy [
	"This is a non regression test for http://bugs.squeak.org/view.php?id=6778"
	
    | original copy |
    original := CTSkipList new.
    original at: 3 put: '3333'.
    copy := original copy.
    copy remove: 3.
    self assert: (original includes: 3)
		description: 'changing the copy should not change the original'
]

{ #category : #public }
CTSkipListTest >> testCreation [
	"self run: #testCreation"
	"self debug: #testCreation"

	| sk |
	sk := CTSkipList new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	self assert: (sk at: 7) = '77777'.
	self assert: (sk includes: 7). 

	
]

{ #category : #public }
CTSkipListTest >> testIfAbsent [
	"self run: #testIfAbsent"
	"self debug: #testIfAbsent"

	| sk temp |
	sk := CTSkipList new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk add: 7 ifPresent: [sk at: 8 put: '88'].
	temp := sk at: 9 ifAbsent: [sk at: 8].
	self assert: (temp = '88')
	
	

	
]

{ #category : #public }
CTSkipListTest >> testIfPresent [
	"self run: #testIfPresent"
	"self debug: #testIfPresent"

	| sk |
	sk := CTSkipList new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk add: 7 ifPresent: [sk at: 8 put: '88'].
	self assert: (sk at: 7) = '77777'.
	self assert: (sk at: 8) = '88'.
	

	
]

{ #category : #public }
CTSkipListTest >> testIsEqualTo [
	"self run: #testIsEqualTo"
	"self debug: #testIsEqualTo"

	| sk sk2 |
	sk := CTSkipList new.
	sk2 := CTSkipList new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk at: 9 put: '3333'.
	
	sk2 at: 3 put: '3333'.
	sk2 at: 5 put: '3333'.
	self assert: (sk is: (sk at: 3) equalTo: (sk at: 9)).
	self assert: (sk is: (sk at: 3) equalTo: (sk2 at: 3)).
	self assert: (sk is: (sk at: 3) equalTo: (sk2 at: 5))
	
	
	

	
]

{ #category : #implementationTests }
CTSkipListTest >> testMaxLevel [
	"No node should have a level greater than the skiplist maxLevel"
	"self run: #testMaxLevel"
	| s |
	s := CTSkipList new.
	s add: 12.
	s add: 53.
	s add: 14.
	s
		nodesDo: [:n | 
			      self
   					assert: n level <= s maxLevel]
]

{ #category : #implementationTests }
CTSkipListTest >> testNavigation [
	"self run: #testNavigation"
	| node1 node2 node3 node4 skip |
	node1 := CTSkipListNode
				key: 1
				value: 3
				level: 1.
	node2 := CTSkipListNode
				key: 2
				value: 7
				level: 2.
	node3 := CTSkipListNode
				key: 3
				value: 11
				level: 1.
	node4 := CTSkipListNode
				key: 4
				value: 23
				level: 2.
	node1 atForward: 1 put: node2.
	node2 atForward: 1 put: node3.
	node2 atForward: 2 put: node4.
	node4 atForward: 1 put: nil.
	skip := CTSkipList new.
	skip atForward: 1 put: node1.
	skip atForward: 2 put: node2.
	self assert: skip first = node1.
	self
		assert: (skip at: 2) = node2 value
]

{ #category : #implementationTests }
CTSkipListTest >> testRandomLevel [
	"a randomLevel should not be greater than maxLevel"
	"self run: #testRandomLevel"
	| s |
	s := CTSkipList new.
	s maxLevel: 5.
	self assert: s randomLevel <= 5
]

{ #category : #public }
CTSkipListTest >> testRemove [
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

]
