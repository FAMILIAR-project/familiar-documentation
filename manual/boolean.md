# boolean 

 {BoolOperation.left=current} op=(BOOL_Operator) right=ComplexCommand //BCommand

enum BOOL_Operator : BOOL_OR='||' | BOOL_AND='&&' ;

/******** BOOLEAN EXPRESSION? ********/
BooleanExpr : {BooleanExpr} val=('true'|'false')  ;
