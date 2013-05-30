# renameFeature (operator) 

The *renameFeature* operation sets a new name to a feature in a feature model

``b = renameFeature ft as ftnew``

ft is a feature

ftnew is a string

b is a boolean value:
 * **true** if the renaming can be performed (ft does exist, ftnew does not exist)
 * **false** otherwise (and the feature model is not modified)

## Examples

```
fmA = FM(A: (B|C|D); B: [E] F;)
fmA: (FEATURE_MODEL) A: (D|B|C) ; 
B: [E] F ;
fml> renameFeature fmA.B as "toto"
res0: (BOOLEAN) true
fml> fmA
fmA: (FEATURE_MODEL) A: (D|toto|C) ; 
toto: [E] F ;
```