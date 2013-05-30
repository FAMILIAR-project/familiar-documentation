# FAMILIAR Xtext Grammar 

```xtext
Command :     (LEFT_PAREN ComplexCommand RIGHT_PAREN)
            | (
            StringExpr
            |SetExpr
            |BooleanExpr
            |IdentifierExpr
            |IntegerExpr
            |FeatureVariabilityOperator
            |SetOperations
            |AnalysisOperation
            |FeatureOperation // children, sibling, parent, operator
            |StringOperation
            |Compare
            |LoadGeneric
            |Merge
            |AggregateMerge
            |FeatureModelOperation // insert, remove, rename, extract
            |Aggregate
            |AtomicConstraintExpr
            |ConstraintExpr
            |VariableNull
            |ModifyVOperator
            |ConfigurationCmd
            |ScriptDefinition
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





VariabilityOpCommand : IdentifierExpr | CopyVariable | FeatureVariabilityOperator ;











Parameter : 'parameter' param=FML_IDENTIFIER (typed=':' type=lType)?;



// TODO: distinguish between string and simple identifier
LoadGeneric : 'run' stream=(STRING|FML_IDENTIFIER) (LEFT_BRACKET (params+=FML_IDENTIFIER)* RIGHT_BRACKET)? ('into' ns=FML_IDENTIFIER)? ;






//LEFT_BRACKET (fms+=FMCommand)+ RIGHT_BRACKET



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


terminal META_ATTRIBUTE_SYMBOL : '@' ; 
```