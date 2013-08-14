# compare

The compare operation is used to determine whether a feature model is a refactoring, a generalization, a specialization or an arbitrary edit of another feature model.  
Let f and g be feature models, and let ``[[f]]`` (resp. ``[[g]]``) denote the set of configurations for f (resp. g).
f is a specialization of g if ``[[f]]`` is included in ``[[g]]``.
f is a generalization of g if ``[[g]]`` is included in ``[[f]]``.
f is a refactoring of g if ``[[f]]`` is equal to ``[[g]]``.
Otherwise, f is an arbitrary edit of g.

```
fml> fm1 = FM(A : B [C];)
fm1: (FEATURE_MODEL) A: B [C] ;
fml> fm2 = FM(A : B; B : [C];)
fm2: (FEATURE_MODEL) A: B ;
B: [C] ;
fml> compare fm1 fm2
res0: (STRING) REFACTORING
fml> fm3 = FM(A : (B|C);)
fm3: (FEATURE_MODEL) A: (B|C) ;
fml> fm4 = FM(A : (B|C)+;)
fm4: (FEATURE_MODEL) A: (B|C)+ ;
fml> compare fm3 fm4
res1: (STRING) SPECIALIZATION
fml> compare fm4 fm3
res2: (STRING) GENERALIZATION
```