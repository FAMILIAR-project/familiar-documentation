# isComplete

The isComplete operation checks whether a configuration is finished, meaning there is no more unselected features.

The operator should not been mixed with [`isValid`](isValid.md) which expresses if a configuration is valid.


Examples:

```
fml> fmA = FM(A: (B|C);)
fmA: (FEATURE_MODEL) A: (B|C) ;
fml> c = configuration fmA
c: (CONFIGURATION) selected: [A] 	 deselected: []
fml> isValid c
res1: (BOOLEAN) true
fml> isComplete c
res2: (BOOLEAN) false
fml> select B in c
res3: (BOOLEAN) true
fml> isComplete c
res4: (BOOLEAN) true
```