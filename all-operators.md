

[Feature model] (featuremodel.md)
[Feature] (feature.md)
[Feature groups] (fgroups.md)
[Configuration] (configuration.md)
[Constraint] (constraint.md)

[Set] (set.md)
[Integer] (integer.md)
[Boolean] (boolean.md)
[String] (string.md)


[Basic language constructs] (basic-constructs.md)

[Cleanup] (cleanup.md)
[KSynthesis] (ksynthesis.md)



 

ComplexCommand : left=Command    
                   
                    | {ComparisonOperation.left=current} cmpOp=(ComparisonOperator) right=ComplexCommand //(IntegerCommand|BCommand)

                    )?
                | not?='not' batom=ComplexCommand ;   
   
Command :     (LEFT_PAREN ComplexCommand RIGHT_PAREN)
            | (
            StringExpr
            |SetExpr
            |BooleanExpr
            |IdentifierExpr
            |IntegerExpr
            |FeatureVariabilityOperator
            |IfCondition
            |ForeachSet
            |FeatureModel
            |AddConstraint // only internal constraints (see aggregate)
            |RemoveConstraint // what about associating an id to a constraint?
            |SetOperations
            |AnalysisOperation
            |FeatureOperation // children, sibling, parent, operator
            |StringOperation
            |Compare
            |LoadGeneric
            |Merge
            |AggregateMerge
            |Synthesis
            |FeatureModelOperation // insert, remove, rename, extract
            |Aggregate
            |Slice
            |AtomicConstraintExpr
            |ConstraintExpr
            |GetConstraints
            |ComputeConstraints
            |GetFGroups
            |ComputeFGroups
            |VariableNull
            |Cores
            |Deads
            |Cliques
            |FullMandatorys 
            |PrinterUtility
            |Convert
            |Assertion
            |GDisplay
            |GListing
            |AsFM
            |ModifyVOperator
            |FMLSave
            |ConfigurationCmd
            |ScriptDefinition
            |Shell
            |CopyVariable
            |RemoveVariable
            |CTCRCommand
            |PairwiseCommand
            )
            ;


 
IntegerExpr :  {IntLiteral} value=INT
;



IdentifierExpr : val=FML_IDENTIFIER  (LEFT_HOOK META_ATTRIBUTE_SYMBOL metaID=(StringExpr) RIGHT_HOOK)?;

StringExpr :     val=STRING ;

SetExpr : (LEFT_BRACKET (e+=ComplexCommand)+ RIGHT_BRACKET)
 ;
 
 

// TODO: whichfm for features

/******* TYPE OPERATIONS ******/
lType: val=('FeatureModel'|'Feature'|'Boolean'|'String'|'Configuration'|'Set'|'Double'|'Integer'|'Constraint') ;

FMLAbstractCommand : (Command | FMCommand | FTCommand | SetCommand | ConstraintCommand) 
		     	      		  ;

FMCommand : 
		(IdentifierExpr | CopyVariable | AggregateMerge | Merge | Synthesis | 
				  FeatureModel | FMFeature | AsFM | Aggregate | Extract | Slice)
				  	       //	   | LEFT_PAREN FMCommand RIGHT_PAREN 
            ;

FTCommand : IdentifierExpr | CopyVariable | FeatureOperation ; //ParentFeature ;

BCommand : (IdentifierExpr | IsEmptySet | RemoveVariable |
            RemoveFeature | RenameFeature | Insert | ModifyVOperator |
            IsConflicting | CompleteConfiguration | SetBelongs 
            )
            ;

StrCommand : IdentifierExpr | CopyVariable | StringExpr | StringConcat | StringInit | StringSubstring | FeatureOperation | Convert ; //FeatureOperation for NameFeature

ConfigurationCommand : (IdentifierExpr | CreateConfiguration)
						//| LEFT_PAREN ConfigurationCommand RIGHT_PAREN
                    ;

SetCommand : IdentifierExpr | SetExpr | FeatureOperation | 
	     		    Cliques | Cores | Deads | FullMandatorys | // TODO: AnalysisOperation due to 'features'
			    	      SetToNames | SetUnionOrIntersection | 
				      		   SetEmpty | SelectedConfiguration | DeselectedConfiguration | ConstraintExpr | 
						   	      GetConstraints 	    | ComputeConstraints | GetFGroups | ComputeFGroups | PairwiseCommand
							      			      ;
												
ConstraintCommand :										IdentifierExpr | AtomicConstraintExpr ;






IntegerCommand : IdentifierExpr | IntegerExpr | SetCard | StringLength | StringIndexOf | DoubleCommand ; // weird for double command

DoubleCommand : CTCRCommand ;

// TODO (urgent)
//ConstraintCommand : IdentifierExpr | CopyVariable | AtomicConstraintExpr ; 

//SetCNF : (LEFT_BRACKET (constraints+=CNF)+ RIGHT_BRACKET) | UnMap  ;

VariabilityOpCommand : IdentifierExpr | CopyVariable | FeatureVariabilityOperator ;











Parameter : 'parameter' param=FML_IDENTIFIER (typed=':' type=lType)?;



// TODO: distinguish between string and simple identifier
LoadGeneric : 'run' stream=(STRING|FML_IDENTIFIER) (LEFT_BRACKET (params+=FML_IDENTIFIER)* RIGHT_BRACKET)? ('into' ns=FML_IDENTIFIER)? ;






//LEFT_BRACKET (fms+=FMCommand)+ RIGHT_BRACKET



Assertion : 'assert' LEFT_PAREN assertion=ComplexCommand RIGHT_PAREN ; // should be a BooleanOperation

enum ComparisonOperator : EQUAL='eq'|NotEqual='neq'|LesserThan='<'|GreaterThan='>'|REF_EQUAL='=='|REF_NotEqual='!='; //| IntegerOperator ) ;


enum SetOperator : SUNION='++'|SDIFF='--' ;

VariableNull : 'isNull' var=FML_IDENTIFIER ;

// Export/ Hide
Export : 'export' arg=LVidentifier ;
Hidden : 'hide'    arg=LVidentifier ;

// list of identifiers
LVidentifier : args+=FML_IDENTIFIER (COMMA args+=FML_IDENTIFIER)* ;

Dependency : 'dependencies' var=FML_IDENTIFIER; // return the set of FMs which are dependent from var // TODO: deprecated???


ScriptDefinition : LEFT_HOOK 
(params+=Parameter)*
(cmds+=ScriptCommand)+ 
exports+=(Export|Hidden)*
RIGHT_HOOK ;

// shell commands
Shell : cmd=(Exit|Exist|Listing|IsConflicting|State|Help) ;

Exit : val=('quit'|'exit');
Exist : val=('isExisting') var=FML_IDENTIFIER ;
IsConflicting : val=('isConflicting') var=FML_IDENTIFIER ;
Listing : val=('ls'|'vars') (opt=OPT_LISTING)?;
enum OPT_LISTING : NORMAL='--normal'|VERBOSE='--verbose'|VALUE_ONLY='--withValues' ;
State : val=('state'|'memory'|'cpu') ; // memory usage, CPU speed?
Help : val=('help') ; //cmd=FML_IDENTIFIER;



CopyVariable : ('copy'|'cp') vid=FML_IDENTIFIER ; //('as')? (newvar=FML_IDENTIFIER)?;
RemoveVariable : ('removeVariable'|'rm') vid=FML_IDENTIFIER ;








/*** UTILITIES ******/

PrinterUtility : op=('print'|'println') arg=LArgs ;

LArgs : args+=Command (COMMA args+=Command)* ;

// TODO: unify! @deprecated: print_vars
//Arg : StringArg | IdArg ;
//StringArg : val=STRING;
//IdArg : val=FML_IDENTIFIER;

// graphical display or print information on the variable
GDisplay : cmdDisplay=('gdisplay') var=(FMCommand|ConfigurationCommand) ; //@deprecated: display //@deprecated: 'print_var'// can also be a configuration

GListing : cmd='glisting'|'gls' {GListing} ; // TODO: what's that?



terminal LEFT_PAREN : '(' ;
terminal RIGHT_PAREN : ')' ;






//terminal NEWLINE: '\r' ? '\n' ;
//terminal WS : (' ' |'\t' |'\n' |'\r' )+  ;
terminal LEFT_BRACKET :     '{' ;
terminal RIGHT_BRACKET : '}' ;

terminal LEFT_HOOK : '[' ;
terminal RIGHT_HOOK : ']' ; 
 
terminal COMMA : ',' ;

terminal META_ATTRIBUTE_SYMBOL : '@' ; 

//terminal QUOTE :  '"' ;


//IDENTIFIER :
//terminal FML_IDENTIFIER : ID ; //Letter (Letter | DIGIT)*;
// TODO: abstract feature / concrete feature
// setAbstract or FM (A : B C D ; abstract D : (E|F|G) ; )
FT_ID : ID ('.' ID)* ; // feature ID
FML_IDENTIFIER :  ID ('.' (ID|STAR))* | ID STAR;
//terminal Letter :  'a'..'z' |  'A'..'Z' |  '_' |  '.' ;

//terminal DIGIT :  '0'..'9';
