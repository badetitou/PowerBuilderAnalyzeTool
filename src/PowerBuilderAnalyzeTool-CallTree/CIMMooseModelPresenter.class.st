Class {
	#name : #CIMMooseModelPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'pbModelTable'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #specs }
CIMMooseModelPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #pbModelTable;
		yourself
]

{ #category : #examples }
CIMMooseModelPresenter class >> run [
	<example>
	self new openWithSpec
]

{ #category : #api }
CIMMooseModelPresenter >> focusElement: aCIMCodeAnalyserFmxPWBMethodAdapter [
  pbModelTable selectItem: aCIMCodeAnalyserFmxPWBMethodAdapter
]

{ #category : #initialization }
CIMMooseModelPresenter >> initializeModel [
  model := PWBCallTreeBrowserModel new.
  model mooseModelPresenter: self.

]

{ #category : #initialization }
CIMMooseModelPresenter >> initializePresenter [
	pbModelTable
		whenSelectionChangedDo: [ :selected | 
			selected selectedItem
				ifNotNil: [ model globallySelect: selected selectedItem ] ]
]

{ #category : #initialization }
CIMMooseModelPresenter >> initializeWidgets [
  self initializeModel.
  self initializeTable.

]

{ #category : #accessing }
CIMMooseModelPresenter >> model: anObject [
  model := anObject.
  model mooseModelPresenter: self
]

{ #category : #accessing }
CIMMooseModelPresenter >> pbModel [
	^ model
]

{ #category : #accessing }
CIMMooseModelPresenter >> pbModelTable [
	^ pbModelTable
]

{ #category : #accessing }
CIMMooseModelPresenter >> pbModelTable: anObject [
	pbModelTable := anObject
]

{ #category : #initialization }
CIMMooseModelPresenter >> searchEntity [
  pbModelTable searchMatching: [:item :textToSearch |  item name beginsWith: textToSearch ]
]

{ #category : #accessing }
CIMMooseModelPresenter >> searchFor: aText [
  pbModelTable adapter widget function searchFor: aText
]