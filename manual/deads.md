# Deads

This operator computes a set of dead features in a given feature model.

## Examples

```
fml> fmA = FM(A: (B|C); B -> C;)
fmA: (FEATURE_MODEL) A: (B|C) ; 
(B -> C);
fml> deads fmA
res1: (SET) {B}
```
