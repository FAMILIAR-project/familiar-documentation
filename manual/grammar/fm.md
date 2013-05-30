# FeatureModel grammar

<pre>
	<code>
	FeatureModel : 'FM' LEFT_PAREN  (features+=Production ';')+ ( expr+=Constraint ';')* ) RIGHT_PAREN ;
	Production  : name=FML_IDENTIFIER ':' features+=Child ;

	Child       : (Mandatory
	                | Optional
	                | Mutexgroup 
	                | Xorgroup
	                | Orgroup) ;

	Mandatory   : name=ID ;
	Optional    : '[' name=FML_IDENTIFIER ']' ;
	Mutexgroup   : LEFT_PAREN features+=ID  ('|' features+=ID)+ RIGHT_PAREN '?' ;
	Xorgroup   : LEFT_PAREN features+=ID  ('|' features+=ID)+ RIGHT_PAREN ;
	Orgroup    : LEFT_PAREN features+=ID  ('|' features+=ID)+ RIGHT_PAREN '+' ;


	ID : ('^')?('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*; 

	Constraint       : Constraint  ('|' | '&' | '->' | '<->') Constraint
	            | '!' Constraint 
	            | '(' Constraint ')'
	            | ID
	</code>
</pre>