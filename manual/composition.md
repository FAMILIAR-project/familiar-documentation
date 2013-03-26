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

The script loads three feature models fm1, fm2 and fm3. 
Note that fm1, fm2 and fm3 actually correspond to feature models used in the paper "Supplier independent feature modelling" by Herman Hartmann, Tim Trew, Aart A. J. Matsinger, SPLC'09 (191-200).

We want to compose the three feature models. 
In particular, we are targeting the following scenario. fm1, fm2 and fm3 are representing three product lines maintained by three different suppliers. 
We want to build a new product line offering every possible product offered by suppliers (no more, no less). 
In terms of feature modeling, we want to compute a new feature model (a composed feature model) that represents the union of input sets of configurations.

```
fml> s1 = configs fm1
s1: (SET) {{S;F4;F2;F5};{S;F2;F5;F1};{F6;S;F2};{F6;S;F4;F2};{S;F2;F6;F1};{F6;F4;F2;S;F1};{S;F5;F2};{F1;F5;S;F4;F2}}
fml> s2 = configs fm2
s2: (SET) {{S;F1;F2;F5};{F5;F2;S;F1;F3};{S;F5;F1;F2;F6};{S;F6;F2;F1};{S;F2;F6;F1;F3};{F1;S;F3;F2};{F2;F1;S};{F2;F3;F6;F5;S;F1}}
fml> s3 = configs fm3
s3: (SET) {{F2;F4;F1;F6;S};{F5;F2;F1;S};{F6;F4;S;F2};{S;F1;F6;F2;F4;F5};{F1;F2;F4;F5;S};{F6;S;F2;F1;F5};{S;F1;F2};{F2;S};{F4;F2;S};{F2;F1;S;F4};{F6;F2;S};{F1;F6;F2;S}}
```

Likewise, each configuration authorized in the composed feature model corresponds to at least one configuration in either fm1, fm2 and fm3.
fm4 is such a feature model

```
fml> fm4
fm4: (FEATURE_MODEL) S: (F4|F3)? [F1] F2 ; 
F2: [F6] [F5] ; 
(F3 -> F1);
```

```
fml> s4 = configs fm4
s4: (SET) {{S;F1;F4;F2};{F4;S;F2};{F6;S;F1;F3;F2};{F2;F4;F6;S};{S;F5;F2;F4};{F3;F1;F2;S};{F2;F5;S;F1};{F6;F1;S;F2};{F2;F1;F5;S;F3};{F2;F1;F6;S;F4;F5};{S;F2;F1};{F3;S;F5;F2;F1;F6};{F6;S;F2};{F2;S;F5};{S;F6;F2;F4;F1};{F4;F2;F1;S;F5};{F2;S};{F1;F6;F5;F2;S}}
fml> size s4
res3: (INTEGER) 18
fml> counting fm4
res4: (DOUBLE) 18.0
```

##### Merge operator

The magic is in the merge operator. 
The principle of the merge operator can be summarized as follows:
 * two features match iff they have the same name (F2 of fm1 matches with F2 of fm2 and F2 of fm3)
 * a new feature with the same "matched" name is created in the composed feature model (merging process)
 * depending on the sets of configuration we want (e.g., union) the variability information is synthesized accordingly. For instance, F3 and F4 are mutually exclusive (forming a Mutex-group, i.e., at most 1 of the features can be selected), F1 logically implies F3 or F2 is mandatory.
 * the feature hierarchy tries to retain as much as possible parent-child relationships in the input feature models. In particular, F5 and F6 are subfeatures of F2
 
The internal details of the merge implementation are also worth to describe. The principle is to encode each feature model as a formula and then computes a "composed" formula. 
This can be achieved by '''denoting''' into the Boolean logic the configuration semantics (e.g., of "union"). 
More details can be found in ECMFA'10 paper or PhD thesis (see references below). 

##### Reference-based approach 

The merge operator previously described is very suited when 
 * the maching and merging of features are rather simple (i.e., the matching strategy is one-to-one, based on names, and the composed feature model contains features with same names) 
 * the configuration semantics can be denoted in the Boolean logic
 
However there are practical situations in which the matching/merging strategy is much more complicated. 
Similar observations can be made for the configuration semantics: the "union" is not always what the users want. 
Moreover the merge operator looses the traceability with the input feature models. 

Therefore a natural idea is to '''reference''' input feature models. 
A "composed" view is specified, containing the features that are of interest for the composition. 
Then features of the composed view "reference" features of input feature models through (logical) constraints. 

Combined with advanced mechanisms such as slicing or local synthesis, we can actually implement a merge-like operator.



### Acknowledgements 

We thanks MODELS'12 and SPLC'12 participants of the tutorial "Next-Generation Model-based Variability Management : Languages and Tools" for providing early feedbacks on the composition mechanisms offered by FAMILIAR. 

### Resources and References 

![Image](compositionTutorial/fm1.png?raw=true)
![Image](compositionTutorial/fm2.png?raw=true)
![Image](compositionTutorial/fm3.png?raw=true)
