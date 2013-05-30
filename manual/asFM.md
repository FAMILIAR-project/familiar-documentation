# asFM

This operator allows to convert a configuration into a feature model.
Deselected features of the configuration will be removed in the resulting feature model and selected features will be changed to mandatory features. Then the semantic of the feature model behind the configuration is keeped, but a cleanup is performed to remove unnecessary constraints and features.


## Examples

```
fml> fmA = FM(A: (B|C|D) [E] [F]; B: [X]; C: (J|L)+; E -> L;)
fmA: (FEATURE_MODEL) A: (D|B|C) [E] [F] ; 
B: [X] ; 
C: (J|L)+ ; 
(E -> L);
fml> c = configuration fmA
c: (CONFIGURATION) selected: [A] 	 deselected: []
fml> deselect F in c
res8: (BOOLEAN) true
fml> select E in c
res9: (BOOLEAN) true
fml> c      
c: (CONFIGURATION) selected: [E, A, C, L] 	 deselected: [F, D, B, X]
fml> unselectedF c
res10: (SET) {J}
fml> fmB = asFM c
fmB: (FEATURE_MODEL) A: E C ; 
C: [J] L ;
```