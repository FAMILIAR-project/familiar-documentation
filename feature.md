/********* ACCESSORS ***********/
// + root (see below)
FeatureOperation : op=(AncestorFeature | DescendantFeature | ChildrenFeature | SiblingFeature | ParentFeature | NameFeature | FMFeature | FeatureOperator)
                   feature=FTCommand;

AncestorFeature : val='ancestors' ;
DescendantFeature : val='descendants' ;
ChildrenFeature : val='children'  ; // children: Set[Feature]
SiblingFeature: val='sibling' ; // sibling: Set[Feature]
ParentFeature : val='parent' ; // parent: Feature
NameFeature : val='name'  ; // name: String
FMFeature : val='whichfm'  ; // whichfm : FM
FeatureOperator : val='operator'  ; // operator: enum {AND, XOR, OR, ANDOPT}
