# extract

The extract operation returns a new feature model such as : 
- features are the feature specified as parameter plus its descendant features.
- the root feature is the feature specified as parameter
- constraints that not involves features of this new feature model are removed 
Note that the extract operation does not alter the feature model in which the feature parameter belongs to.

```
fml> fm = FM(A : B C [D]; B : (E|F); C : (G|H)+; H -> D;)
fm: (FEATURE_MODEL) A: [D] B C ;
B: (E|F) ;
C: (H|G)+ ;
(H -> D);
fml> extract fm.C
res0: (FEATURE_MODEL) C: (H|G)+ ;
```

See also [slice operator] (slicing.md)