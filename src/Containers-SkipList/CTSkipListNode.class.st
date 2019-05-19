"
This is a skiplist node. It can be treated as an association that allows a 'next' operator to go to the next node in the skiplist.


"
Class {
	#name : #CTSkipListNode,
	#superclass : #Association,
	#instVars : [
		'pointers',
		'object'
	],
	#category : 'Containers-SkipList-Structure'
}

{ #category : #'instance creation' }
CTSkipListNode class >> key: key value: value level: maxLevel [ 
        ^ (super key: key value: value) initialize: maxLevel
]

{ #category : #'instance creation' }
CTSkipListNode class >> new: maxLevel [
	^ super new initialize: maxLevel
]

{ #category : #'instance creation' }
CTSkipListNode class >> on: element level: maxLevel [ 
        ^ self key: element value: element level: maxLevel

]

{ #category : #'instance creation' }
CTSkipListNode class >> tailOfLevel: n [
	^ self on: nil level: n
]

{ #category : #accessing }
CTSkipListNode >> atForward: i put: node [
	^ pointers at: i put: node
]

{ #category : #accessing }
CTSkipListNode >> forward: i [ 
	^ pointers at: i
]

{ #category : #initialization }
CTSkipListNode >> initialize: maxLevel [
	pointers := Array new: maxLevel
]

{ #category : #accessing }
CTSkipListNode >> level [
	^ pointers size
]

{ #category : #accessing }
CTSkipListNode >> next [
	^ pointers first
]

{ #category : #accessing }
CTSkipListNode >> printOn: aStream [
        | first |
        aStream
                nextPut: $[.
        super printOn: aStream.
        aStream
                nextPutAll: ']-->('.
        first := true.
        pointers do: [:node |
                first ifTrue: [first := false] ifFalse: [aStream space].
                node ifNil: [aStream nextPutAll: '*'] 
                ifNotNil: [node printOn: aStream]].
        aStream nextPut: $)

]
