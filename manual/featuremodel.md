# Feature Models 

## Formats

The following formats are fully supported for using feature models:
 * [SPLOT] (http://www.splot-research.org/), 
 * [FeatureIDE] (http://wwwiti.cs.uni-magdeburg.de/iti_db/research/featureide/), 
 * a subset of [TVL] (http://www.info.fundp.ac.be/~acs/tvl/), 
 * S2T2
 * the familiar notation (see below)

## Internal notation

Building a new feature model uses the constructor `FM`:

```
fm1 = FM (A : B C [D]; B: (E|F) ; C : (G|H|I)? ; D : (J|K)+ ; (!C | D) ; )
```

 * A is the **root** 
 * B, C and D are child-features of A: B and C are **mandatory** whereas D is **optional** 
 * E and F form a **XOR-group** and are child-features of B 
 * G, H and I form an **optional XOR-group** and are child-features of C 
 * J and K form an **OR-group** and are child-features of D
 * (!C | D) is equivalent to (C -> D) and is an **internal constraint** of the feature model

Here is a diagrammatic representation of fm1 with FeatureIDE editor: 

// ADD PICTURE

[See the grammar](grammar/fm.md) 

## Importing feature models in other notation

You can: 
 * load feature models in those notations, the file extension is linked with the feature model representation:

```
     fm_A = FM("A.fml") // familiar file
     fm_B = FM("b.xml") // SPLOT file
     fm_C = FM("c.m")   // FeatureIDE file
     fm_D = FM("d.tvl") // TVL file
     fm_E = FM(A: C D;) // Familiar notation 
```

 * convert a feature model to return a string representation of the FM in the specified format:

```
 		convert fm_A in featureide
 		convert fm_A in fml
 		convert fm_A in splot
 		convert fm_A in tvl
```

 * serialize the feature models in those notations (Files are saved in the directory *output*):

```
 	 save fm_A into fml
 	 save fm_B into splot
 	 save fm_C into featureide
 	 save fm_D into tvl
```

## Editing facilities

// change the variability operator associated to a feature
ModifyVOperator: (MandatoryEdit | OptionalEdit | AlternativeEdit | OrEdit); 

MandatoryEdit : 'setMandatory' ft=FTCommand ;
OptionalEdit : 'setOptional' ft=FTCommand ;
AlternativeEdit : 'setAlternative' fts=SetCommand ; // should be a set of features
OrEdit : 'setOr' fts=SetCommand ; // should be a set of features 


//FeatureVariabilityOperator : 'OP' LEFT_PAREN val=FeatureEdgeKind RIGHT_PAREN ;
FeatureVariabilityOperator : val=FeatureEdgeKind ;
enum FeatureEdgeKind : MANDATORY='mand'| OPTIONAL='opt'| ALTERNATIVE='Xor'| OR='Or'|MUTEX='Mutex' ;

fml> fm3 = copy fm2
fm3: (FEATURE_MODEL) A: (B|E|C|F)+ ;
fml> setAlternative fm3.A.*
res2: (BOOLEAN) true
fml> fm2
fm2: (FEATURE_MODEL) A: (B|E|C|F)+ ;
fml> fm3
fm3: (FEATURE_MODEL) A: (B|E|C|F) ;

fml> setMandatory fm3.B
res3: (BOOLEAN) true
fml> fm3 
fm3: (FEATURE_MODEL) A: B [E] [C] [F] ; 
(B -> A);
(A -> B);
fml> setOr { fm3.E fm3.C fm3.F }
res4: (BOOLEAN) true
fml> fm3
fm3: (FEATURE_MODEL) A: (E|C|F)+ B ; 
(B -> A);
(A -> B);

## Editing (2)

[insert] (insert.md)
Insert : 'insert' aspectfm=FMCommand 'into' baseft=FTCommand 'with' op=VariabilityOpCommand ; //TODO:  op2=(FML_IDENTIFIER)?  ;

[renameFeature] (renameFT.md)
[removeFeature] (removeFT.md)

RemoveFeature : 'removeFeature' feature=FTCommand ;
RenameFeature : 'renameFeature' feature=FTCommand 'as' featureNew=(StrCommand) ; //'in' fm=FML_IDENTIFIER ;

[extract] (extract.md)
Extract: 'extract' rootfeature=FTCommand ;


## Serialization


// convert e.g., featureide, pure::variants, etc.

Convert: 'convert' v=FMCommand 'into' format=FMFormat ; // returns a string
enum FMFormat : FMLBDD='fmlbdd'|FIDE='featureide'|FCALC='fmcalc'|FFML='fml'|FSPLOT='SPLOT'|FTVL='TVL'|FTRISKELL='fd'|FFML2='xmi'|S2T2='S2T2' ;
FMLSave : ('save'|'serialize') v=FMCommand 'into' format=FMFormat;

## Automated analysis

Cores : 'cores' fm=FMCommand ; // core features
Deads : 'deads' fm=FMCommand ; // dead features
// TODO: make the difference!
FullMandatorys : ('fullMandatorys'|'falseOptionals') fm=FMCommand ; // full mandatory features

Cliques : 'cliques' fm=FMCommand ; // cliques (aka atomic sets?)

// isDead? isCore? isFullMandatory? can be written with an FML script

[counting] (counting.md)
[isValid] (isValid.md)
[configs] (configs.md)



[compare] (compare.md)
Compare :
    'compare' fm_left=FMCommand fm_right=FMCommand;    // Boolean formula?

enum EditConstant : REFACTORING | SPECIALIZATION | GENERALIZATION | ARBITRARY ;

## Metrics

CTCRCommand : 'ctcr' fm=FMCommand ; 

## Composition


/****** COMPOSITION OPERATORS ***********/

[merge] (merge.md)

Merge: 'merge' mode=MergeMode 
            ((LEFT_BRACKET
                (lfms+=FMCommand)+
            RIGHT_BRACKET) 
             | fms=LFMArgs) ;
            //(pre=Predirectives)?
            //(post=Postdirectives)?; // alignment directives

enum MergeMode : CROSS='crossproduct'|UNION='union'|SUNION='sunion'|INTER='intersection'|DIFF='diff' ;
LFMArgs : lfms+=FMCommand (COMMA lfms+=FMCommand)* ;

AggregateMerge: 'aggregateMerge' mode=MergeMode 
            ((LEFT_BRACKET
                (lfms+=FMCommand)+
            RIGHT_BRACKET) 
             | fms=LFMArgs) ;

[aggregate] (aggregate.md)

Aggregate : 'aggregate' ((LEFT_BRACKET
					 (fms+=FMCommand)+
								 RIGHT_BRACKET) 
												 | sfms=IdentifierExpr) ('withMapping' mapping=SetCommand)?;


## Decomposition

   
[slice] (slicing.md)
Slice : 'slice' fm=FMCommand mode=SliceMode fts=SetCommand ; // issue: side effect or purely functional?

enum SliceMode : INCLUDING='including' | EXCLUDING='excluding' ;


## Misc

PairwiseCommand : 'pw' fm=FMCommand ('minimization=' minimization=IntegerCommand)? ('partial=' partial=IntegerCommand)? ;

[ksynthesis] (ksynthesis.md)

[asFM] (asFM.md)
AsFM : 'asFM' conf=ConfigurationCommand;

[cleanup] (cleanup.md)
CleanUp : 'cleanup' fm=FMCommand ; // functional style?
