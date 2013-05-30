# children

The children operation returns the set of child features of a feature in a feature model (hierarchy).

## Examples

```
fml> fmA = FM(A: (B|C|D) [E];)
fmA: (FEATURE_MODEL) A: (D|B|C) [E] ;
fml> fA = root fmA
fA: (FEATURE) A
fml> children fA
res7: (SET) {E;D;C;B}
```