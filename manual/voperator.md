# variability operator

TODO (I propose to fix it and change to voperator)
The operator operation returns the "variability operator" of a feature in a feature model, i.e., the operator (mandatory, optional, Xor, Or) of the feature and its parent.

op = operator ft

ft is a variable of feature type

op is an operator type whose value is either MAND, OPT, XOR or OR of feature 'ft' and its parent

Note that a leaf feature does have an operator and a root feature has no operator.

op = operator fm1.A

op is the operator of feature A (present in the feature model fm1)

