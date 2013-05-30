# isValid

The operator `isValid` can be used both with feature models or configurations.

## Feature Model

The isValid operation on a feature model determines its satisfiability, i.e., whether or not there is at least one valid configuration.

## Configuration

The isValid operation checks whether a configuration is valid according to its feature model.
The operator should not been mixed with [`isComplete`](isComplete.md) which expresses if a configuration is finished.


Examples:

```
fml> fmA = FM(A: (B|C); B <-> C;)
fmA: (FEATURE_MODEL) A: (B|C) ; 
(B <-> C);
fml> isValid fmA
res0: (BOOLEAN) false

fml> fmA = FM(A: (B|C);)
fmA: (FEATURE_MODEL) A: (B|C) ;
fml> c = configuration fmA
c: (CONFIGURATION) selected: [A] 	 deselected: []
fml> isValid c
res1: (BOOLEAN) true

fml> isComplete c
res2: (BOOLEAN) false
```