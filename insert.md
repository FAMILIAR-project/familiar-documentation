# insert

The insert operator produces a feature model by inserting a feature model into another base or target feature model. The operator takes three arguments: 
 * the feature model to be inserted, 
 * the feature in the base/target feature model where the insertion is to take place, 
 * the variability operator (e.g., Xor) that determines the form of the insertion.

The precondition of the insert operator requires that the intersection between the set of features of the base feature model and the one of the aspect feature model is empty. 
This condition preserves the well-formed property of the composed feature model which states that each feature's name is unique. 
If this pre-condition is not respected or features arguments does not exist in the base or aspect models, insert returns false and the base or target feature model is not modified.

b = insert afm into bft with opt

afm is a variable of feature model type

bft is a variable of feature type (the feature model in which bft belongs to is automatically determined)

opt is a string value whose value is either MAND, OPT, XOR or OR