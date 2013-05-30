# sibling

The sibling operation returns the set of sibling features of a feature in a feature model (hierarchy).

## Examples

```
fmA = FM(A: [B] C; C -> B;)
fmA: (FEATURE_MODEL) A: [B] C ; 
(C -> B);
fml> sibling fmA.B
res3: (SET) {C}
```