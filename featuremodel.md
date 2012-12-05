/******** FEATURE MODEL **************/
FeatureModel : ('FM'|'featuremodel') LEFT_PAREN
                                    (
                                    (
                                    (root=ID ';')|((features+=Production ';')+ 
                                    (expr+=CNF ';')*)
                                    )
                                    | (file=StringExpr) )
                                    RIGHT_PAREN ;

//expr+=Fexpr
//FeatureDescription : Production | Expr ;

Production  : name=ID ':' features+=Child+ ;

Child       : (Mandatory
                | Optional
                | Xorgroup
                | Orgroup  
//                );             
               | Mutexgroup ) ;
                
//                | Andgroup)  ;

Mandatory   : name=FT_ID ;

//Optional    : name=FML_IDENTIFIER '?' | '[' name=FML_IDENTIFIER ']' ;

Optional    : LEFT_HOOK name=ID RIGHT_HOOK ;
Xorgroup   : LEFT_PAREN features+=FT_ID  (B_OR features+=FT_ID)+ RIGHT_PAREN ;
Orgroup    : LEFT_PAREN features+=FT_ID  (B_OR features+=FT_ID)+ RIGHT_PAREN PLUS ;
// Andgroup   : LEFT_PAREN features+=FT_ID ('|' features+=FT_ID)+ RIGHT_PAREN ; // TODO: (identifier=FML_IDENTIFIER '=')?

Mutexgroup : LEFT_PAREN features+=FT_ID  (B_OR features+=FT_ID)+ ')?' ;

terminal B_OR :     '|' | 'or'  ; 

Note this syntax
fml> fm1 = FM (A : (B or C); )
fm1: (FEATURE_MODEL) A: (B|C) ;


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

FeatureModelOperation : Insert | EditOperation | Extract ;
EditOperation : (RemoveFeature|RenameFeature) ;
Insert : 'insert' aspectfm=FMCommand 'into' baseft=FTCommand 'with' op=VariabilityOpCommand ; //TODO:  op2=(FML_IDENTIFIER)?  ;
RemoveFeature : 'removeFeature' feature=FTCommand ;
RenameFeature : 'renameFeature' feature=FTCommand 'as' featureNew=(StrCommand) ; //'in' fm=FML_IDENTIFIER ;
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


AnalysisOperation :
    op=('isValid' // validity of a FM
    | 'counting'  // number of products of a FM
    | 'configs' // set of products of a FM
    | 'nbFeatures' // number of features
    | 'root' // return the root feature of the fm
    | 'features' // return the set of features
    ) fm=(FMCommand|ConfigurationCommand)
    ;


Compare :
    'compare' fm_left=FMCommand fm_right=FMCommand;    // Boolean formula?

enum EditConstant : REFACTORING | SPECIALIZATION | GENERALIZATION | ARBITRARY ;

## Metrics

CTCRCommand : 'ctcr' fm=FMCommand ; 

## Composition


/****** COMPOSITION OPERATORS ***********/


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

Aggregate : 'aggregate' ((LEFT_BRACKET
					 (fms+=FMCommand)+
								 RIGHT_BRACKET) 
												 | sfms=IdentifierExpr) ('withMapping' mapping=SetCommand)?;


## Decomposition

   

Slice : 'slice' fm=FMCommand mode=SliceMode fts=SetCommand ; // issue: side effect or purely functional?

enum SliceMode : INCLUDING='including' | EXCLUDING='excluding' ;


## Misc

PairwiseCommand : 'pw' fm=FMCommand ('minimization=' minimization=IntegerCommand)? ('partial=' partial=IntegerCommand)? ;

ksynthesis
AsFM : 'asFM' conf=ConfigurationCommand;
CleanUp : 'cleanup' fm=FMCommand ; // functional style?
