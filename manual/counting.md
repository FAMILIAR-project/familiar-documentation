# Counting

The counting operation returns the number of valid configurations of a feature model or a configuration.

Note that if a feature model is not valid (i.e., the feature model has no valid configuration), the result equals to zero.

## Examples

```
fmA: (FEATURE_MODEL) A: (B|C) ;
fml> root fmA
res5: (FEATURE) A
fml> fmA = FM(A: (B|C);)
fmA: (FEATURE_MODEL) A: (B|C) ;
fml> counting fmA
res6: (DOUBLE) 2.0

fml> fmB = FM(A: (B|C); B <-> C;)
fmB: (FEATURE_MODEL) A: (B|C) ; 
(B <-> C);
fml> counting fmB
res7: (DOUBLE) 0.0

fml> c = configuration fmA
c: (CONFIGURATION) selected: [A] 	 deselected: []
fml> counting c
res10: (INTEGER) 2

fml> isValid fmB
res8: (BOOLEAN) false
```
