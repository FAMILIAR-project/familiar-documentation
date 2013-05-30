# Configs

Returns the set of valid configurations computed from a FM. 
The result is presented as a set of sets of features: each set of features represent a valid combination of selected features.

## Examples

```
fml> fmA = FM(A: (B|C);)
fmA: (FEATURE_MODEL) A: (B|C) ;
fml> configs fmA
res2: (SET) {{B;A};{C;A}}
```