"
Like a SkipList, except that elements are compared with #== instead of #= .

See the comment of IdentitySet for more information.

"
Class {
	#name : #CTIdentitySkipList,
	#superclass : #CTSkipList,
	#category : 'Containers-SkipList-Structure'
}

{ #category : #'element comparison' }
CTIdentitySkipList >> is: element1 equalTo: element2 [
	^ element1 == element2
]
