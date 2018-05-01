copying
copy
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