"
A skiplist is a sorted data structure that allows one to search for any element in o(log n) time.

It also allows one to enumerate forward to the next element. Basically, its a tree-like algorithm, except it doesn't use trees.

The implementation here is similar to a Dictionary, in that it indexes (a subclass of) Associations. Thus, you can do    foo at: key put: value   You can also search for a key, if the key does not exist, it will report the first key greater than the search, or nil.

In computer science, a skip list is a data structure that allows fast search within an ordered sequence of elements. Fast search is made possible by maintaining a linked hierarchy of subsequences, each skipping over fewer elements. Searching starts in the sparsest subsequence until two consecutive elements have been found, one smaller and one larger than or equal to the element searched for. Via the linked hierarchy, these two elements link to elements of the next sparsest subsequence, where searching is continued until finally we are searching in the full sequence. The elements that are skipped over may be chosen probabilistically or deterministically, with the former being more common.

https://people.ksp.sk/~kuko/gnarley-trees/?page_id=51
http://opendatastructures.org/versions/edition-0.1e/ods-java/4_1_Basic_Structure.html

This package was originally developed by klc. 

"
Class {
	#name : #CTSkipList,
	#superclass : #Collection,
	#instVars : [
		'sortBlock',
		'pointers',
		'numElements',
		'level',
		'splice'
	],
	#classVars : [
		'Rand'
	],
	#category : 'Containers-SkipList-Structure'
}

{ #category : #examples }
CTSkipList class >> example [
	<sampleInstance>
	^ self new
		at: 11 put: '111111';
		at: 3 put: '3333';
		at: 7 put: '77777';
		at: 3 put: '666';
		yourself
]

{ #category : #'instance creation' }
CTSkipList class >> maxLevel: maxLevel [
	"
	SkipList maxLevel: 5
	"
	^ super new initialize: maxLevel
]

{ #category : #'instance creation' }
CTSkipList class >> maxLevel: anInteger sortBlock: aBlock [
	^ (self maxLevel: anInteger) sortBlock: aBlock
]

{ #category : #'instance creation' }
CTSkipList class >> new [
	"
	SkipList new
	"
	^ super new initialize: 10
]

{ #category : #'instance creation' }
CTSkipList class >> new: anInteger [
	^ self maxLevel: (anInteger log: 2) ceiling
]

{ #category : #'instance creation' }
CTSkipList class >> new: anInteger sortBlock: aBlock [
	^ (self new: anInteger) sortBlock: aBlock
]

{ #category : #'instance creation' }
CTSkipList class >> newFrom: aCollection [ 
	| skipList |
	skipList := self new: aCollection size.
	skipList addAll: aCollection.
	^ skipList
]

{ #category : #'instance creation' }
CTSkipList class >> sortBlock: aBlock [
	^ self new sortBlock: aBlock
]

{ #category : #adding }
CTSkipList >> add: element [ 
        "Add an association or key on to the skiplist"
        ^self add: element ifPresent: [].
        
]

{ #category : #adding }
CTSkipList >> add: element ifPresent: aBlock [
        ^self at: element put: element ifPresent: aBlock.

]

{ #category : #enumerating }
CTSkipList >> associationsDo: aBlock [
        self nodesDo: [:node | aBlock value: node]
]

{ #category : #accessing }
CTSkipList >> at: element [ 
        ^self at: element ifAbsent: []
]

{ #category : #accessing }
CTSkipList >> at: element ifAbsent: aBlock [
        "Get the key if it exists, or if it doesn't exist, get the key just after it."
        | node forward |
        node := self.
        level to: 1 by: -1 do: [:i |
                        [forward := node forward: i.
                        self is: forward before: element] whileTrue: [node := forward]].
        node := node next.
        (self is: node theNodeFor: element) ifFalse: [^aBlock value].
        ^node value

]

{ #category : #adding }
CTSkipList >> at: key put: value [ 
        "Add an association or key on to the skiplist"
        ^self at: key put: value ifPresent: [].
        
]

{ #category : #adding }
CTSkipList >> at: key put: value ifPresent: aBlock [
        | node lvl s |
        node := self search: key updating: splice.
        node ifNotNil: [^ aBlock value].
        lvl := self randomLevel.
        node := CTSkipListNode key: key value: value level: lvl.
        level + 1 to: lvl do: [:i | splice at: i put: self].
        1 to: lvl do: [:i |
                                s := splice at: i.
                                node atForward: i put: (s forward: i).
                                s atForward: i put: node].
        numElements := numElements + 1.
        splice atAllPut: nil.
        ^ node

]

{ #category : #private }
CTSkipList >> atForward: i put: node [
	level := node
		ifNil: [pointers findLast: [:n | n notNil]]
		ifNotNil: [level max: i].
	^ pointers at: i put: node
]

{ #category : #copying }
CTSkipList >> copy [
	"Create a copy of the receiver.
	Note: It's hard to operate on skipList structure.
	Easier is to recreate a neww from scratch."
	
	"This one bugs if used with different keys and values...
	^self class newFrom: self"
	
	| copy |
	copy := self class new.
	copy sortBlock: sortBlock.
	self keysAndValuesDo: [:k :v | copy at: k put: v].
	^copy
]

{ #category : #enumerating }
CTSkipList >> do: aBlock [
        self nodesDo: [:node | aBlock value: node value]
]

{ #category : #accessing }
CTSkipList >> first [
        ^pointers first.

]

{ #category : #private }
CTSkipList >> forward: i [ 
	^ pointers at: i
]

{ #category : #testing }
CTSkipList >> includes: key [
        ^ (self search: key updating: nil) notNil
]

{ #category : #initialization }
CTSkipList >> initialize: maxLevel [
	pointers := Array new: maxLevel.
	splice := Array new: maxLevel.
	numElements := 0.
	level := 0.
	Rand ifNil: [Rand := Random new]
]

{ #category : #private }
CTSkipList >> is: node before: element [ 
        | key |
        node ifNil: [^ false].
        key := node key.
        ^ sortBlock
                ifNil: [key < element]
                ifNotNil: [(self is: key equalTo: element) ifTrue: [^ false].
                        sortBlock value: key value: element]
]

{ #category : #'element comparison' }
CTSkipList >> is: element1 equalTo: element2 [
	^ element1 = element2
]

{ #category : #private }
CTSkipList >> is: node theNodeFor: key [ 
        node ifNil: [^ false].
        node == self ifTrue: [^ false].
        
        ^ self is: node key equalTo: key
]

{ #category : #testing }
CTSkipList >> isEmpty [
	^ numElements = 0
]

{ #category : #enumerating }
CTSkipList >> keysAndValuesDo: aBlock [
        ^self associationsDo:[:assoc|
                aBlock value: assoc key value: assoc value].
]

{ #category : #enumerating }
CTSkipList >> keysDo: aBlock [
        self nodesDo: [:node | aBlock value: node key]
]

{ #category : #accessing }
CTSkipList >> level [
	^ level
]

{ #category : #accessing }
CTSkipList >> maxLevel [
	^ pointers size
]

{ #category : #accessing }
CTSkipList >> maxLevel: n [
	| newLevel oldPointers |
	newLevel := n max: level.
	oldPointers := pointers.
	pointers := Array new: newLevel.
	splice := Array new: newLevel.
	1 to: level do: [:i | pointers at: i put: (oldPointers at: i)]

]

{ #category : #private }
CTSkipList >> next [
	^ pointers first
]

{ #category : #'node enumeration' }
CTSkipList >> nodesDo: aBlock [
	| node |
	node := pointers first.
	[node notNil]
		whileTrue:
			[aBlock value: node.
			node := node next]
]

{ #category : #private }
CTSkipList >> randomLevel [
	| p answer max |
	p := 0.5.
	answer := 1.
	max := self maxLevel.
	[Rand next < p and: [answer < max]]
		whileTrue: [answer := answer + 1].
	^ answer
]

{ #category : #removing }
CTSkipList >> remove: element [ 
	^ self remove: element ifAbsent: [self errorNotFound: element]
]

{ #category : #removing }
CTSkipList >> remove: key ifAbsent: aBlock [
        | node i s |
        "Remove and return th association containing key."
        node := self search: key updating: splice.
        node ifNil: [^ aBlock value].
        i := 1.
        [s := splice at: i.
        i <= level and: [(s forward: i) == node]]
                                whileTrue:
                                        [s atForward: i put: (node forward: i).
                                        i := i + 1].
        numElements := numElements - 1.
        splice atAllPut: nil.
        ^ node.

]

{ #category : #removing }
CTSkipList >> removeAll [
	pointers atAllPut: nil.
	splice atAllPut: nil.
	numElements := 0.
	level := 0.
]

{ #category : #accessing }
CTSkipList >> search: element [ 
        "Get the key if it exists, or if it doesn't exist, get the key just after it. If no key after it, return nil."
        | node forward |
        node := self.
        level to: 1 by: -1 do: [:i |
                        [forward := node forward: i.
                        self is: forward before: element] whileTrue: [node := forward]].
        node := node next.
        ^node
]

{ #category : #private }
CTSkipList >> search: element updating: array [
        | node forward |
        node := self.
        level to: 1 by: -1 do: [:i |
                        [forward := node forward: i.
                        self is: forward before: element] whileTrue: [node := forward].
                        "At this point: node < element <= forward"
                        array ifNotNil: [array at: i put: node]].
        node := node next.
        ^ (self is: node theNodeFor: element) ifTrue: [node]
]

{ #category : #accessing }
CTSkipList >> size [
	^ numElements
]

{ #category : #accessing }
CTSkipList >> sortBlock [
	^ sortBlock
]

{ #category : #accessing }
CTSkipList >> sortBlock: aBlock [
	sortBlock := aBlock
]
