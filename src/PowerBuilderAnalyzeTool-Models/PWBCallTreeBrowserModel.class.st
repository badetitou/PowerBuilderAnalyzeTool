Class {
	#name : #PWBCallTreeBrowserModel,
	#superclass : #Object,
	#instVars : [
		'pbModel',
		'selected',
		'selectionListeners',
		'pwbBrowser'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserModel >> globallySelect: anEntity [
	pwbBrowser globallySelect: anEntity
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> pbModel [
	^ pbModel
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> pwbBrowser: aPWBBrowser [
	pwbBrowser := aPWBBrowser
]

{ #category : #api }
PWBCallTreeBrowserModel >> roassal [
	^ selected roassalPresenter
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> selected [
	^ selected
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> selected: anObject [
	selected := anObject.
	self setContent
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> selectedContent [
	selected ifNil: [ selected setContent ].
	^ selected content
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> setContent [
	selected ifNil: [ selected setContent ]
]
