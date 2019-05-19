Class {
	#name : #BaselineOfContainersSkipList,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersSkipList
}

{ #category : #baselines }
BaselineOfContainersSkipList >> baseline: spec [
	<baseline>

	spec for: #pharo do: [		
		spec package: 'Containers-SkipList'
	]
]
