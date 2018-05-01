A skiplist is a sorted data structure that allows one to search for any element in o(log n) time.

It also allows one to enumerate forward to the next element. Basically, its a tree-like algorithm, except it doesn't use trees.

The implementation here is similar to a Dictionary, in that it indexes (a subclass of) Associations. Thus, you can do    foo at: key put: value   You can also search for a key, if the key does not exist, it will report the first key greater than the search, or nil.

In computer science, a skip list is a data structure that allows fast search within an ordered sequence of elements. Fast search is made possible by maintaining a linked hierarchy of subsequences, each skipping over fewer elements. Searching starts in the sparsest subsequence until two consecutive elements have been found, one smaller and one larger than or equal to the element searched for. Via the linked hierarchy, these two elements link to elements of the next sparsest subsequence, where searching is continued until finally we are searching in the full sequence. The elements that are skipped over may be chosen probabilistically or deterministically, with the former being more common.

https://people.ksp.sk/~kuko/gnarley-trees/?page_id=51
http://opendatastructures.org/versions/edition-0.1e/ods-java/4_1_Basic_Structure.html

This package was originally developed by klc. 
