Extension { #name : #Collection }

{ #category : #'*Containers-SkipList' }
Collection >> asIdentitySkipList [
	"Answer a IdentitySkipList whose elements are the elements of the 
	receiver. The sort order is the default less than or equal."

	^ self as: CTIdentitySkipList
]

{ #category : #'*Containers-SkipList' }
Collection >> asSkipList [
	"Answer a SkipList whose elements are the elements of the 
	receiver. The sort order is the default less than or equal."

	^ self as: CTSkipList
]

{ #category : #'*Containers-SkipList' }
Collection >> asSkipList: aSortBlock [ 
	"Answer a SkipList whose elements are the elements of the 
	receiver. The sort order is defined by the argument, aSortBlock."

	| skipList |
	skipList := SortedCollection new: self size.
	skipList sortBlock: aSortBlock.
	skipList addAll: self.
	^ skipList
]
