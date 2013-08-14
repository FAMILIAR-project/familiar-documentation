# aggregate 

The aggregate operation is used to inter-relate a set of feature models, possibly with cross-tree, propositional constraints.  
_Note that, contrary to the [merge](merge.md) operator, we assume that there is no common feature between feature models, i.e., the features have distinct names._  

## Example

In the following FAMILIAR script, **fm1**, **fm2** and **fm3** are aggregated into an unique feature model, **fm4**, and in which a constraint relates features J and C.  

```
fml> fm1 = FM(A : B [C] [D]; D : (E|F); C -> !E;)
fm1: (FEATURE_MODEL) A: [D] B [C] ;
D: (E|F) ;
(C -> !E);
fml> fm2 = FM(I : J [K] L;)
fm2: (FEATURE_MODEL) I: J L [K] ;
fml> fm3 = FM(M : (N|O|P)+;)
fm3: (FEATURE_MODEL) M: (P|N|O)+ ;
fml> cst = constraints(J implies C;)
cst: (SET) {(J -> C)}
fml> fm4 = aggregate fm* withMapping cst
res0: (FEATURE_MODEL)
fm4: (FEATURE_MODEL) "fm4": A I M ;
A: [D] B [C] ;
I: J L [K] ;
M: (P|N|O)+ ;
D: (E|F) ;
(C -> !E);
(J -> C);
fml> cleanup fm4
fml> fm4
fm4: (FEATURE_MODEL) "fm4": A I M ;
A: [D] B C ;
I: J L [K] ;
M: (P|N|O)+ ;
D: F ;
fml> rfm4 = root fm4
rfm4: (FEATURE) fm4
fml> renameFeature rfm4 as "MySPL"
res1: (BOOLEAN) true
fml> fm4
fm4: (FEATURE_MODEL) MySPL: A I M ;
A: [D] B C ;
I: J L [K] ;
M: (P|N|O)+ ;
D: F ;
```

Then, a cleanup is applied to **fm4** so that, for example, dead features are removed (here: E is removed due to the constraint C -> !E).  
_Note that, in addition, the feature C becomes mandatory due to the constraints_.  
A synthetic, fake root is automatically created during the aggregation. This root can be renamed.  
  
It is possible that after an aggregation, the feature model is invalid, i.e., it contains no valid configuration. It is the case of fm3 (see below):

```
fml> fm1 = FM(A : B C D;)
fm1: (FEATURE_MODEL) A: D B C ;
fml> fm2 = FM(E : (F|G);)
fm2: (FEATURE_MODEL) E: (F|G) ;
fml> fm3 = aggregate { fm1 fm2 } withMapping constraints( B -> F; C -> G;)
res2: (FEATURE_MODEL)
fm3: (FEATURE_MODEL) "fm3": A E ;
A: D B C ;
E: (F|G) ;
(B -> F);
(C -> G);
fml> isValid fm3
res3: (BOOLEAN) false
```