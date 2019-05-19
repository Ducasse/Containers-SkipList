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

	| s |
	s := self classToBeTested new.
	s add: 1.
	self assert: s size equals: 1
]

{ #category : #implementationTests }
CTSkipListTest >> testAddIfPresent [
	"adds an already existing element. Decides to add another one in the ifPresent block"

	| s |
	s := self classToBeTested new.
	s add: 1.
	self shouldnt: [ s add: 1 ifPresent: [ s add: 2 ] ] raise: Exception.
	self assert: s size equals: 2
]

{ #category : #public }
CTSkipListTest >> testAt [

	| sk |
	sk := self classToBeTested new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk at: 3 put: '666'.
	self assert: (sk at: 7) equals: '77777'.
	self assert: (sk includes: 7).
	self assert: (sk at: 3) equals: '3333'.
	self assert: (sk includes: 3).
	self assert: sk size equals: 3
]

{ #category : #public }
CTSkipListTest >> testAtPutAlreadyPresent [

	| sk |
	sk := self classToBeTested new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk at: 3 put: '666'.
	self assert: (sk at: 7) equals: '77777'.
	self assert: (sk includes: 7).
	self assert: (sk at: 3) equals: '3333'.
	self assert: (sk includes: 3).
	self assert: sk size equals: 3
]

{ #category : #public }
CTSkipListTest >> testCopy [

	| original copy |
	original := self classToBeTested new.
	original at: 3 put: '3333'.
	copy := original copy.
	copy remove: 3.
	self
		assert: (original includes: 3)
		description: 'changing the copy should not change the original'
]

{ #category : #public }
CTSkipListTest >> testCreation [

	| sk |
	sk := self classToBeTested new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	self assert: (sk at: 7) equals: '77777'.
	self assert: (sk includes: 7)
]

{ #category : #public }
CTSkipListTest >> testIfAbsent [
	"self run: #testIfAbsent"

	"self debug: #testIfAbsent"

	| sk temp |
	sk := self classToBeTested new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk add: 7 ifPresent: [ sk at: 8 put: '88' ].
	temp := sk at: 9 ifAbsent: [ sk at: 8 ].
	self assert: temp equals: '88'
]

{ #category : #public }
CTSkipListTest >> testIfPresent [
	"self run: #testIfPresent"

	| sk |
	sk := self classToBeTested new.
	sk at: 11 put: '111111'.
	sk at: 3 put: '3333'.
	sk at: 7 put: '77777'.
	sk add: 7 ifPresent: [ sk at: 8 put: '88' ].
	self assert: (sk at: 7) equals: '77777'.
	self assert: (sk at: 8) equals: '88'
]

{ #category : #public }
CTSkipListTest >> testIsEqualTo [
	"self run: #testIsEqualTo"

	| sk sk2 |
	sk := self classToBeTested new.
	sk2 := self classToBeTested new.
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
CTSkipListTest >> testNavigation [
	"self run: #testNavigation"

	| node1 node2 node3 node4 skip |
	node1 := CTSkipListNode key: 1 value: 3 level: 1.
	node2 := CTSkipListNode key: 2 value: 7 level: 2.
	node3 := CTSkipListNode key: 3 value: 11 level: 1.
	node4 := CTSkipListNode key: 4 value: 23 level: 2.
	node1 atForward: 1 put: node2.
	node2 atForward: 1 put: node3.
	node2 atForward: 2 put: node4.
	node4 atForward: 1 put: nil.
	skip := self classToBeTested new.
	skip atForward: 1 put: node1.
	skip atForward: 2 put: node2.
	self assert: skip first equals: node1.
	self assert: (skip at: 2) equals: node2 value
]

{ #category : #implementationTests }
CTSkipListTest >> testNoNodeShouldHaveLevelGreaterThanMaxLevel [
	"No node should have a level greater than the skiplist maxLevel"

	| s |
	s := self classToBeTested new.
	s add: 12.
	s add: 53.
	s add: 14.
	s nodesDo: [ :n | self assert: n level <= s maxLevel ]
]

{ #category : #implementationTests }
CTSkipListTest >> testRandomLevelShouldNotBeGreaterThanMaxLevel [
	"a randomLevel should not be greater than maxLevel"

	| s |
	s := self classToBeTested new.
	s maxLevel: 5.
	self assert: s randomLevel <= 5
]

{ #category : #public }
CTSkipListTest >> testRemove [
	"tests size after removing element"

	| s |
	s := self classToBeTested new.
	s add: 1.
	self assert: s size equals: 1.
	self should: [ s remove: 2 ] raise: Exception.
	s remove: 1.
	self assert: s size isZero
]
