# parent

The parent operation returns the parent feature of a feature in a feature model (hierarchy). It returns null if there is no parent feature.

```
fml> fm = FM(A : B C [D]; B : (E|F); C : (G|H)+;)
fm: (FEATURE_MODEL) A: [D] B C ;
B: (E|F) ;
C: (H|G)+ ;
fml> parent fm.A
###########      error: (org.xtext.example.mydsl.fML.impl.ComplexCommandImpl@591
bfcbe (eProxyURI: dummy:/example766667196.fml#//@cmds.0)) NULL
fml> parent fm.B
res4: (FEATURE) A
fml> parent fm.D
res5: (FEATURE) A
fml> parent fm.E
res6: (FEATURE) B
fml> parent fm.H
res7: (FEATURE) C
```