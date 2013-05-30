# cleanup (operator)

Cleanup removes automatically dead features and redundant constraints.

```
fml> fm1 = FM (A : (B | C); C: D; B -> C; C -> D; )
fm1: (FEATURE_MODEL) A: (B|C) ; 
C: D ; 
(C -> D);
(B -> C);
fml> deads fm1
res6: (SET) {B}
fml> cleanup fm1
fml> fm1
fm1: (FEATURE_MODEL) A: C ; 
C: D ;
```