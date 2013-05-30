# falseOptionals

This operator computes the set of false optionals feature from a given feature model.

## Examples

```
ml> fmA = FM(A: [B] C; C -> B;)
fmA: (FEATURE_MODEL) A: [B] C ; 
(C -> B);
fml> falseOptionals fmA
res2: (SET) {B}
```