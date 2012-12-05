# Constraint

## Constraint (specification)
CNF : Or_expr ; //(expr+=Or_expr)+ ;

Or_expr returns CNFExpression:
 And_expr ({Or_expr.left=current} B_OR right=And_expr)*;

And_expr returns CNFExpression:
 Impl_expr ({And_expr.left=current} B_AND right=Impl_expr)*;

Impl_expr returns CNFExpression:
 Biimpl_expr ({Impl_expr.left=current} B_IMPLY right=Biimpl_expr)*;
 
Biimpl_expr returns CNFExpression:
 Unary_expr ({Biimpl_expr.left=current} B_BIMPLY right=Unary_expr)*;

Unary_expr returns CNFExpression:
 Neg_expr |
 Primary_expr ;
 
 
//name=FML_IDENTIFIER ;
 
Neg_expr : B_NOT expr=Primary_expr ; 
Primary_expr returns CNFExpression : 
 	     name=(ID|'true'|'false') | 
 	     LEFT_PAREN Or_expr RIGHT_PAREN ;



terminal B_NOT :    '!' | '~' ; // 'not' | 
terminal B_AND :    '&' | 'and' ; //| '&' ;
terminal B_OR :     '|' | 'or'  ; 
terminal B_IMPLY :   '->' | 'implies' | 'requires' ;
terminal B_BIMPLY :     '<->' | 'biimplies' ;

## Constraint (building) 
AtomicConstraintExpr : 'constraint' LEFT_PAREN expr=CNF RIGHT_PAREN ; 
ConstraintExpr : 'constraints' ((LEFT_PAREN (constraints+=CNF ';')+ RIGHT_PAREN) 
											| fm=FMCommand ) ; // implies + excludes + biimplies + o 


## Constraint (operators)

AddConstraint : 'addConstraint' cst=ConstraintCommand 'to' fm=FMCommand ; //cst=ConstraintCommand ;
RemoveConstraint : 'removeConstraint' cst=ConstraintCommand 'in' fm=FMCommand ; //TODO //cst=ConstraintCommand ; // LEFT_BRACKET (clause+=CNF ';')+ RIGHT_BRACKET ;

Map : 'map' fm=FMCommand 'with' cst=SetCommand;
UnMap : 'unmap' fm=FMCommand ;


## Constraint (getter)

GetConstraints : kindOfGet=KindOfGet fm=FMCommand ;
enum KindOfGet : HIERARCHY_IMPLIES='getImpliesHierarchy'|HIERARCHY_EXCLUDES='getExcludesHierarchy'|HIERARCHY_BIIMPLIES='getBiimpliesHierarchy'|
			CONSTRAINT_IMPLIES='getImpliesConstraint'|CONSTRAINT_EXCLUDES='getExcludesConstraint'|CONSTRAINT_BIIMPLIES='getBiimpliesConstraint' ;

## Constraint (computation)

ComputeConstraints : kindOfCompute=KindOfCompute fm=FMCommand ;
enum KindOfCompute : IMPLIES='computeImplies'|EXCLUDES='computeExcludes'|BIIMPLIES='computeBiimplies' ;
