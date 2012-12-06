# Language constructs

## Conditional instructions

IfCondition : 'if' LEFT_PAREN (bexpr=ComplexCommand) RIGHT_PAREN 'then' //BCommand | ComparisonExpression
(then+=ScriptCommand)+
('else' (else+=ScriptCommand)+)?
'end'
;


## Foreach (iterator/loop)

ForeachSet : 'foreach' LEFT_PAREN val=FML_IDENTIFIER 'in' var=FML_IDENTIFIER RIGHT_PAREN 'do'
(exprs+=ScriptCommand)+
'end'
;

                  
## Comparison                   
                  
{ComparisonOperation.left=current} cmpOp=(ComparisonOperator) right=ComplexCommand 

enum ComparisonOperator : EQUAL='eq'|NotEqual='neq'|LesserThan='<'|GreaterThan='>'|REF_EQUAL='=='|REF_NotEqual='!='; //| IntegerOperator ) ;

## Assertion 

'assert' LEFT_PAREN assertion=ComplexCommand RIGHT_PAREN ; // should be a BooleanOperation