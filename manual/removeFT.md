# removeFeature

The *removeFeature* operation deletes a feature and its child features in a feature model

The result is a boolean value:
 * true if the removal can be performed (ft does exist)
 * false otherwise (and the feature model is not modified)

## Examples

```
fml> fmA = FM(A: (B|C|D); B: [E] F;)
fmA: (FEATURE_MODEL) A: (D|B|C) ; 
B: [E] F ;
fml> removeFeature fmA.B
res13: (BOOLEAN) true
fml> fmA
fmA: (FEATURE_MODEL) A: (D|C) ;
fml> removeFeature fmA.X
###########	 error: (org.xtext.example.mydsl.fML.impl.ComplexCommandImpl@288d539f (eProxyURI: dummy:/example1625880796.fml#//@cmds.0)) null
###########	 error: (org.xtext.example.mydsl.fML.impl.ComplexCommandImpl@288d539f (eProxyURI: dummy:/example1625880796.fml#//@cmds.0)) NULL 
###########	 error: (org.xtext.example.mydsl.fML.impl.ComplexCommandImpl@288d539f (eProxyURI: dummy:/example1625880796.fml#//@cmds.0)) feature expected but v=null
###########	 error: (org.xtext.example.mydsl.fML.impl.ComplexCommandImpl@288d539f (eProxyURI: dummy:/example1625880796.fml#//@cmds.0)) NULL 
	 	 Warning: feature not found
res14: (BOOLEAN) false
```