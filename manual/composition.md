# Composing your Compositions of Variability Models

 * Mathieu Acher (University of Rennes 1, Inria / Irisa, Triskell team)
 * Benoit Combemale (University of Rennes 1, Inria / Irisa, Triskell team)
 * Philippe Collet (University of Nice Sophia Antipolis)
 * Olivier Barais (University of Rennes 1, Inria / Irisa, Triskell team)
 * Philippe Lahire (University of Nice Sophia Antipolis)
 * Robert B. France (Colorado State University)

This document presents: 
 
 * a comprehensive tutorial on feature model composition, showing the equivalence of various operators and mechanims offered by the FAMILIAR language
 * numerous examples (toy examples or based on the revisit of existing works)
 * the associated FAMILIAR scripts as well as the packaged version to play with the tool

Our ultimate goal is to provide solutions that fulfill the various needs of variability model composition.

### A first example 

Let us consider the following FAMILIAR script: 
```
MacBook-Pro-de-Mathieu-3:MODELS13 macher1$ cat testMODELSFirstExample.fml
fm1 = FM (S : [F1] F2 [F4] ; F2 : (F5|F6) ; ) // F1, F4 optionals, F5 and F6 mutually exclusive 
fm2 = FM (S : F1 F2 [F3] ; F2 : [F5] [F6] ; ) // F5,F6 still subfeatures of F2 but optionals, F1 mandatory 
fm3 = FM (S : [F1] F2 [F4] ; F2 : [F5] [F6] ; F5 -> F1 ; )

// you can also play with TVL, featureide, SPLOT or other formats if you want
// serialize fm3 into featureide 

// logic-based
fm4 = merge union { fm1 fm2 fm3 }

// reference-based
fm5 = aggregateMerge union { fm1 fm2 fm3 }
// let S be the common root of fm1, fm2, fm3

// 0. without any slicing
fm6 = extract fm5.S

// 1. with slicing
s7 = { fm5.S } ++ fm5.S.*
fm7 = slice fm5 including s7

// 2. with local slicing
fm8 = ksynthesis fm5 over fm5.R*
```

![Image](../compositionTutorial/fm1.png?raw=true)
