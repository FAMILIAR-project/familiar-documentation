# insert

The insert operator modifies a feature model by inserting another feature model into one of its features.  
  
This operator takes three arguments: 
 * the feature model to be inserted, 
 * the feature in the base/target feature model where the insertion is to take place, 
 * the variability operator (MAND, OPT, XOR or OR) that determines the form of the insertion.

The precondition of the insert operator requires that the intersection between the set of features of the base feature model and the one of the aspect feature model is empty. 
This condition preserves the well-formed property of the composed feature model which states that each feature's name is unique. 
If this pre-condition is not respected or features arguments does not exist in the base or aspect models, insert returns false and the base or target feature model is not modified otherwise it returns true if the insertion has been effective.

```
fml> fm2 = FM(C : (G|H)+;)
fm2: (FEATURE_MODEL) C: (H|G)+ ;
fml> insert fm2 into fm.A with mand
res1: (BOOLEAN) true
fml> fm
fm: (FEATURE_MODEL) A: [D] B C ;
B: (E|F) ;
C: (H|G)+ ;
```