Extension { #name : #FamixPWBmajorObject }

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> allIncomingReferencesSenders [
	| scan scanTop |
	scan := self incomingReferencesSenders asOrderedCollection.
	scanTop := 1.
	[ scanTop > scan size ]
		whileFalse: [ scan
				addAll:
					((scan at: scanTop) incomingReferencesSenders
						reject:
							[ :userObject | (scan includes: userObject) or: [ self toSkipForNow: userObject ] ]).
			scanTop := scanTop + 1 ].
	^ scan
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> allOutgoingReferencesTarget [
	| scan scanTop |
	scan := self outgoingReferencesTarget asOrderedCollection.
	scanTop := 1.
	[ scanTop > scan size ]
		whileFalse: [ scan
				addAll:
					((scan at: scanTop) outgoingReferencesTarget
						reject:
							[ :userObject | (scan includes: userObject) or: [ self toSkipForNow: userObject ] ]).
			scanTop := scanTop + 1 ].
	^ scan
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> allReferences [
	| result |
	result := Set new.
	result addAll: self allIncomingReferencesSenders.
	result addAll: self allOutgoingReferencesTarget.
	^ FAMIXTypeGroup
		withAll: (result reject: [ :obj | obj name = 'uo_datawindow' ])
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> content [
	content ifNil: [ self setContent ].
	^ content
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> cyclomaticComplexity [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each cyclomaticComplexity ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> incomingReferencesSenders [
	^ ((self incomingReferences collectAsSet: #from)
		reject: [ :userObject | self toSkipForNow: userObject ]) asSet
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> numberOfIncomingInvocations [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each numberOfIncomingInvocations ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> numberOfMethods [
	^ self content size
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> outgoingInvocationsSenders [
	^ self content collect: #outgoingInvocationsSenders
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> outgoingReferencesTarget [
	^ ((self outgoingReferences collectAsSet: #target)
		reject: [ :userObject | self toSkipForNow: userObject ]) asSet
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> roassalPresenter [
	^ CIMFunctionInvocationsPresenter
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> setContent [
	content := ((self methods asSet
		reject: [ :method | method isNoisyMethod ])
		flatCollect: #withAllOutgoingInvocationCandidates)
		asOrderedCollection
		sort: [ :a :b | a numberOfLinesOfCode > b numberOfLinesOfCode ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> toSkipForNow: anObject [
	self flag: 'To be considered later'.
	^ {FamixPWBWindow.
	FamixPWBCustomType.
	FamixPWBDataWindow.
	FamixPWBFunction.
	FamixPWBEvent} includes: anObject class
]
