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



## A first example 

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
fm8 = ksynthesis fm5 over s7
```

The script loads three feature models fm1, fm2 and fm3 (the rest of the script will be explained in detail hereafter).
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

### Merge operator

The magic is in the merge operator. 
The principle of the merge operator can be summarized as follows:
 * two features match iff they have the same name (F2 of fm1 matches with F2 of fm2 and F2 of fm3)
 * a new feature with the same "matched" name is created in the composed feature model (merging process)
 * depending on the sets of configuration we want (e.g., union) the variability information is synthesized accordingly. For instance, F3 and F4 are mutually exclusive (forming a Mutex-group, i.e., at most 1 of the features can be selected), F1 logically implies F3 or F2 is mandatory.
 * the feature hierarchy tries to retain as much as possible parent-child relationships in the input feature models. In particular, F5 and F6 are subfeatures of F2
 
The internal details of the merge implementation are also worth to describe. The principle is to encode each feature model as a formula and then computes a "composed" formula. 
This can be achieved by '''denoting''' into the Boolean logic the configuration semantics (e.g., of "union"). 
A hierarchy is then automatically selected and variability information is synthesized (more details can be found in ECMFA'10 paper or PhD thesis, see references [1] [2] below). 

### Reference-based approach 

The merge operator previously described is very suited when 
 * the maching and merging of features are rather basic (i.e., the matching strategy is one-to-one, based on names, and the composed feature model contains features with same names) 
 * the configuration semantics can be denoted in the Boolean logic
 
However there are practical situations in which the matching/merging strategy is much more complicated. 
Similar observations can be made for the configuration semantics: the "union" is not always what the users want. 
Moreover the merge operator looses the traceability with the input feature models. 

Therefore a natural idea is to **reference** input feature models. 
A ***composed view***, containing the features that are of interest for the composition, is specified. 
Then features of the view "reference" features of input feature models through (logical) constraints. 

Combined with advanced mechanisms such as slicing or local synthesis, we will show that we can actually implement a merge-like operator. 
Such compositional mechanisms are more general and should be preferred in case, as a user of FAMILIAR, you want to customize the matching/merging strategy as well as the configuration and ontological semantics. 

#### Aggregate 

To implement a reference-based approach, a natural approach is to execute the following steps:
 * define the composed view
 * define the set of constraints to establish correspondences with input features 
 * aggregate the composed view, the constraints as well as the input feature models together 

Using FAMILIAR, it can be implemented with something like: 
```
cfm1 = copy fm1
cfm2 = copy fm2
cfm3 = copy fm3
fm5View = FM (S : [F1] [F2] [F3] [F4] ; F2 : [F5] [F6] ; )
csts = constraints (F1 -> (fm1_F1 or fm2_F1 or .. ; )
fm5bis = aggregate --renamings { cfm1 cfm2 cfm3 fm5View } withMapping csts
```

#### AggregateMerge

For implementing the union mode (or another like intersection), the constraints to be specified can be huge, thus making the process time-consuming and error-prone.
Another (more technical) problem is that the aggreagate operator assumes that features' names are unique (in order to make a distinction between features). 

Therefore we develop and provide another operator to automate this task, called **aggregateMerge**. 
It takes as input a set of feature models and a "mode" (e.g., union, intersection).

```
// reference-based
fm5 = aggregateMerge union { fm1 fm2 fm3 }
```

It automatically generates (1) the view (2) the constraints and (3) aggregate both inputs with automatic renamings (see below on the previous example).

```
fml> fm5
fm5: (FEATURE_MODEL) MergeCST: S InputFMs ; 
S: [F4] [F1] [F2] [F3] ; 
InputFMs: (fm3_S|fm1_S|fm2_S) ; 
F2: [F6] [F5] ; 
fm3_S: [fm3_F1] [fm3_F4] [fm3_F3] fm3_F2 ; 
fm2_S: fm2_F1 [fm2_F4] fm2_F2 [fm2_F3] ; 
fm1_S: [fm1_F1] [fm1_F4] [fm1_F3] fm1_F2 ; 
fm3_F2: [fm3_F5] [fm3_F6] ; 
fm2_F2: [fm2_F5] [fm2_F6] ; 
fm1_F2: (fm1_F5|fm1_F6) ; 
(fm3_F5 -> fm3_F1);
(F6 <-> ((fm3_F6 | fm2_F6) | fm1_F6));
!fm1_F3;
(F1 <-> ((fm3_F1 | fm2_F1) | fm1_F1));
(F2 <-> ((fm2_F2 | fm1_F2) | fm3_F2));
(F3 <-> ((fm3_F3 | fm2_F3) | fm1_F3));
(F4 <-> ((fm1_F4 | fm2_F4) | fm3_F4));
!fm2_F4;
!fm3_F3;
(S <-> ((fm2_S | fm1_S) | fm3_S));
(F5 <-> ((fm1_F5 | fm3_F5) | fm2_F5));
```

The interest of the aggregated feature model, here **fm5**, is that you have a ***semantically equivalent*** representation of the set of configurations. 
Indeed, the combinations of features authorized in the composed "view" of fm5 are exactly the same as in fm4, thus realizing the configuration semantics of union. 
It is straightforward to understand why: the constraints force the selection of at least one and at most one corresponding feature (if any)  in the input feature models. 

An example is given below. Selecting F3 in the view automatically selects the root of fm2 and deselects features of fm1 and fm3.
You can also notice that F2 is selected by default since F2 is included in every configuration of fm1, fm2 or fm3. 
You can play with c5 and verify that every valid configuration involving features of the view are also valid in fm4. 

```
fml> c5 = configuration fm5
c5: (CONFIGURATION) selected: [MergeCST, S, F2, InputFMs]   deselected: [fm1_F3, fm2_F4, fm3_F3]
fml> select F3 in c5
res1: (BOOLEAN) true
fml> selectedF c5
res2: (SET) {fm2_F1;F3;fm2_F2;F2;S;F1;MergeCST;fm2_S;InputFMs;fm2_F3}
fml> deselectedF c5
res3: (SET) {fm2_F4;fm3_F4;fm3_F5;fm3_F1;F4;fm3_F3;fm1_F1;fm1_F4;fm1_F6;fm1_F2;fm3_F2;fm1_F5;fm1_S;fm3_F6;fm1_F3;fm3_S}
```

#### On the Quality of the View

A major problem with the previous solution is that features are all optionals in the "view" (we will see some other problems in the remainder).   

```
fml> fm6 = extract fm5.S
fm6: (FEATURE_MODEL) S: [F4] [F1] [F2] [F3] ; 
F2: [F6] [F5] ;
```

As a result, you cannot use the view (fm6) independently. Furthermore the view contains anomalies, since the syntactical constructs are not conformant to the actual meaning. 
In particular, F2 is modeled as optional but is actually mandatory ; F3 and F4 are mutually exclusive ; F3 implies the selection of F1. 
It is clearly not the case in fm6 (see above). It is a very rough over-approximation of the actual configuration set. 
Therefore it not acceptable to exploit fm6 afterwards.

Two techniques are conceivable for improving the quality of the "view".

#### With Slicing

A first one is to rely on the **slice** operator. 
It takes as input a feature model and a set of features (slicing criterion). 
It computes a new feature model containing only the features of the slicing criterion.
Importantly the resulting feature model characterizes the *projected set of configurations* onto the slicing criterion. 
In our case, we are only interested by features of the view (see s7 below) and we slice fm5 (resulting from the aggregateMerge operator) with s7. 

```
fml> s7
s7: (SET) {F5;F3;F2;F1;F6;S;F4}
fml> fm7 = slice fm5 including s7
fm7: (FEATURE_MODEL) S: (F4|F3)? [F1] F2 ; 
F2: [F6] [F5] ; 
(F3 -> F1);
```

Intuitively, the projected set of configurations is the same set of configurations of the input feature model ***without*** the features not in the slicing criterion. 

```
cs5 = configs fm5
actualConfView = setEmpty
foreach (cf in cs5) do
    si = setIntersection cf s7
    setAdd actualConfView si
end
```

```
fml> cs5
cs5: (SET) {{fm1_S;fm1_F2;F2;F5;MergeCST;S;fm1_F5;InputFMs};{S;F1;fm2_F2;F6;InputFMs;F2;F5;fm2_S;fm2_F6;fm2_F1;MergeCST;fm2_F5};{fm1_F4;F5;InputFMs;F4;fm1_S;fm1_F2;F2;S;MergeCST;fm1_F5};{MergeCST;F2;fm3_F4;fm3_F2;fm3_F5;F5;InputFMs;fm3_F1;S;F4;F1;fm3_S};{MergeCST;S;F6;F2;fm1_F2;fm1_S;fm1_F6;InputFMs};{fm2_F2;fm2_F1;fm2_S;F5;InputFMs;MergeCST;fm2_F5;S;F1;F2};{S;F1;fm3_F1;F2;fm3_F6;F6;MergeCST;fm3_F2;InputFMs;fm3_S};{fm3_S;F2;fm3_F1;fm3_F5;fm3_F2;F1;S;InputFMs;fm3_F6;F6;F5;MergeCST};{MergeCST;S;F1;fm2_S;F2;fm2_F1;InputFMs;fm2_F2};{fm3_F4;S;MergeCST;InputFMs;F4;fm3_F2;F1;fm3_F1;fm3_F6;F2;fm3_S;F6};{InputFMs;F5;fm2_F2;F1;F3;fm2_S;S;MergeCST;F2;fm2_F3;fm2_F5;fm2_F1};{fm3_F2;fm3_S;InputFMs;S;F2;fm3_F1;fm3_F4;F1;F4;MergeCST};{S;fm1_F6;fm1_F2;F4;F2;InputFMs;F6;MergeCST;fm1_F4;fm1_S};{fm2_S;F2;InputFMs;fm2_F3;fm2_F1;F3;fm2_F2;F1;F5;fm2_F5;MergeCST;fm2_F6;F6;S};{F2;fm3_F1;S;InputFMs;F1;fm3_F2;MergeCST;fm3_S};{F6;F2;fm1_F2;fm1_S;fm1_F1;fm1_F6;S;MergeCST;InputFMs;F1};{InputFMs;fm2_F6;fm2_S;F6;S;MergeCST;F1;F2;fm2_F2;fm2_F1};{F5;fm3_S;F2;InputFMs;fm3_F2;fm3_F1;fm3_F5;S;MergeCST;F1};{fm2_F1;InputFMs;MergeCST;F1;F6;F2;F3;fm2_F2;S;fm2_F3;fm2_F6;fm2_S};{F4;F1;fm1_F2;fm1_F6;MergeCST;InputFMs;F2;fm1_F4;F6;fm1_S;fm1_F1;S};{F4;fm3_F4;InputFMs;fm3_F2;F2;S;MergeCST;fm3_S};{InputFMs;fm1_S;F1;F2;S;fm1_F2;fm1_F5;F5;fm1_F1;MergeCST};{F2;S;F6;InputFMs;fm3_F2;fm3_F6;fm3_S;MergeCST};{fm1_F2;F1;InputFMs;fm1_F5;F4;MergeCST;F2;S;fm1_F4;F5;fm1_F1;fm1_S};{S;fm3_S;InputFMs;F4;fm3_F6;MergeCST;fm3_F4;fm3_F2;F6;F2};{InputFMs;MergeCST;fm3_S;fm3_F2;F2;S};{F4;F6;F5;fm3_F4;InputFMs;S;fm3_F6;fm3_F2;fm3_S;MergeCST;fm3_F5;fm3_F1;F2;F1};{InputFMs;MergeCST;fm2_S;F2;S;fm2_F2;F3;fm2_F3;F1;fm2_F1}}
fml> actualConfView
actualConfView: (SET) {{S;F2};{F1;S;F2};{F4;F2;S};{S;F2;F6};{S;F4;F2;F6};{F2;F5;F4;S;F1};{S;F2;F3;F1};{F1;S;F6;F2;F5};{F5;S;F1;F2};{F5;F1;F3;S;F2};{F1;F5;F2;F6;F3;S};{S;F1;F2;F6};{S;F4;F1;F2;F6};{F5;S;F4;F2;F1;F6};{F1;F3;F2;F6;S};{F5;F4;F2;S};{F2;F5;S};{S;F2;F1;F4}}
fml> actualConfView eq configs fm4
res1: (BOOLEAN) true
```

Obviously, the slice operator is **not** internally implemented like this. Enumerating all configurations and then computing the projected configurations with set operations is not efficient and scalable even for small feature models. 
Instead a Boolean formula, free for non relevant variables, is computed. 
Then satisfiability techniques are used to synthesize a comprehensive feature model.

A key benefit is that the computed feature model fm7 is exactly the same as fm4. The formulas are exactly the same as well as the synthesized feature diagram.

```
fml> compare fm4 fm7
res2: (STRING) REFACTORING
fml> hierarchy fm4 eq hierarchy fm7
res6: (BOOLEAN) true
```

#### With Local Synthesis

Another strategy for correcting the "view" of fm5 is possible. 
Instead of computing a new Boolean formula (like with the slice, see above), we can directly exploit the original formula of fm5 and perform ***over*** the relevant Boolean variables.
We thus adapt the operator *ksynthesis* so that the synthesis procedure performs over the set of features specified. 

```
> fm8 = ksynthesis fm5 over s7
fm8: (FEATURE_MODEL) S: (F4|F3)? [F1] F2 ; 
F2: [F6] [F5] ; 
(F3 -> F1);
```

The resulting feature model fm8 seems to be the same as fm4 and fm7. 
But this is not the case.

```
fml> compare fm8 fm7
res1: (STRING) GENERALIZATION
``` 

The reason is that the synthesized feature diagram is an over-approximation of the actual set of configurations we want. 

```
fml> cs4 = configs fm4
cs4: (SET) {{S;F2};{F6;F2;S;F1;F4};{F6;F3;S;F2;F1;F5};{F1;F6;S;F2};{S;F1;F2};{F6;F5;F1;F2;S};{F1;F6;F2;F5;S;F4};{F6;F2;S};{F5;F2;S;F1};{F2;S;F6;F3;F1};{F4;F5;F2;S};{F5;F2;S;F4;F1};{F5;F2;S};{F5;F1;S;F2;F3};{S;F1;F3;F2};{F2;S;F1;F4};{F4;S;F2};{S;F2;F6;F4}}
fml> cs7 = configs fm7
cs7: (SET) {{F1;F3;F2;S};{F6;S;F4;F2};{F2;S;F1;F4};{F4;S;F2;F1;F6};{F6;F5;S;F2;F1};{F2;F5;S;F4};{F2;F6;S};{F2;S;F1};{F2;F5;F6;F1;S;F4};{F2;S;F1;F5};{F2;S;F1;F6};{F2;S;F4};{F2;F1;S;F4;F5};{S;F2;F5};{F2;S;F6;F3;F1};{F2;S};{F1;F2;S;F3;F5};{F6;S;F5;F1;F3;F2}}
fml> cs8 = configs fm8
cs8: (SET) {{F4;F6;S;F2};{F5;F2;F6;S};{S;F5;F2};{F2;F5;F6;F1;S};{S;F2;F4;F1};{F5;F2;S;F4};{F3;F1;F6;S;F5;F2};{S;F5;F1;F2;F4};{S;F6;F2};{F2;F1;S;F3};{F5;F6;F2;F4;F1;S};{S;F2;F3;F1;F5};{F1;S;F2};{F2;F1;F6;S};{F2;F6;F4;F5;S};{F1;S;F5;F2};{S;F4;F2};{F2;S};{S;F6;F2;F4;F1};{F2;F3;F6;S;F1}}
fml> cs7 eq cs4
res2: (BOOLEAN) true
fml> setDiff cs8 cs7
res3: (SET) {{F5;F2;F6;S};{F2;F6;F4;F5;S}}
```

The local synthesis procedure, as other synthesis procedure, makes it best for producing a maximal feature diagram. 
But it is well-known that feature diagrams offer syntactical constructs that are not expressively complete wrt Boolean logics. It is the case of fm8 that authorizes two configurations not valid in fm4 and fm7 (i.e., fm8 is a "generalization" of fm4 and fm7).

## Second Example: Customizing your Composition 

As previously stated, there are situations in which the matching/merging strategy is not one-to-one and based on feature names. Moreover, the combinations of features legal in the composed feature model can be more tricky. 

We consider again the same feature models fm1, fm2 and fm3 and this time we want to build a view that does not necessarily include all the original details or feature names:
 * F56 is mapped to features F5 and F6 of input feature models. The intuition
is that either selecting F5 or F6 is sufficient to realize the feature F56. In a
sense, F56 abstracts features F5 and F6 since no distinction is made between F5 and F6 at the level of abstraction of the view ; 
 * F1 is no longer present in the composed view. It is another form of abstraction: unnecessary details are removed ;
 * another feature, named F8, is present in the view and aims to better structure the feature model, considering that features F3 and F4 are ontologically closed.

We give an implementation in FAMILIAR below, using **aggregate**

```
```

## Acknowledgements 

We thanks MODELS'12 and SPLC'12 participants of the tutorial "Next-Generation Model-based Variability Management : Languages and Tools" for providing early feedbacks on the composition mechanisms offered by FAMILIAR. 

## Resources and References 

[1] Acher, M.: Managing Multiple Feature Models: Foundations, Language and Applications.
PhD thesis (2011)

[2] M. Acher, P. Collet, P. Lahire, and R. France. Comparing Approaches to Implement
Feature Model Composition. In Proc. of ECMFA’10, volume 6138 of LNCS, pages
3–19, 2010.

![Image](compositionTutorial/fm1.png?raw=true)
![Image](compositionTutorial/fm2.png?raw=true)
![Image](compositionTutorial/fm3.png?raw=true)
