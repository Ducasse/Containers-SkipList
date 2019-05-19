# Containers-SkipList

An implementation of Pugh datastructure proposal described in Skip lists: a probabilistic alternative to balanced trees - Communications of the ACM.

[![Build Status](https://travis-ci.com/Ducasse/Containers-SkipList.svg?branch=master)](https://travis-ci.com/Ducasse/Containers-SkipList)
[![Coverage Status](https://coveralls.io/repos/github//Ducasse/Containers-SkipList/badge.svg?branch=master)](https://coveralls.io/github//Ducasse/Containers-SkipList?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()
[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
<!-- [![Build status](https://ci.appveyor.com/api/projects/status/1wdnjvmlxfbml8qo?svg=true)](https://ci.appveyor.com/project/olekscode/dataframe)  -->



## Loading

```
Metacello new
   baseline: 'ContainersSkipList';
   repository: 'github://Ducasse/Containers-SkipList';
   load.
```

## If you want to depend on it

```
spec 
   baseline: 'ContainersOrderPreservingDictionary' 
   with: [ spec repository: 'github://Ducasse/Containers-SkipList/src' ].
```

## History
I harvested the code from the old SmalltalkHub/PharoExtras repository. The original developer should contact me for authorship acknowledgment.


The best way to predict the future is to do it! Less talking more doing. stepharo.self@gmail.com
