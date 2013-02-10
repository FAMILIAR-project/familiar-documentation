/********* ACCESSORS ***********/
// + root (see below)
FeatureOperation : op=(AncestorFeature | DescendantFeature | ChildrenFeature | SiblingFeature | ParentFeature | NameFeature | FMFeature | FeatureOperator)
                   feature=FTCommand;


AncestorFeature : val='ancestors' ;
DescendantFeature : val='descendants' ;



ChildrenFeature : val='children'  ; // children: Set[Feature]
SiblingFeature: val='sibling' ; // sibling: Set[Feature]

[sibling] (sibling.md)

ParentFeature : val='parent' ; // parent: Feature
NameFeature : val='name'  ; // name: String

FMFeature : val='whichfm'  ; // whichfm : FM

[operator] (voperator.md)
FeatureOperator : val='operator'  ; // operator: enum {AND, XOR, OR, ANDOPT}


    | 'features' // return the set of features
TODO fm.*

[root] (root.md)
   | 'root' // return the root feature of the fm

[children] (children.md)
[parent] (parent.md)