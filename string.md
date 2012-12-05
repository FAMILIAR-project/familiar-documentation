# String

StringOperation : (StringInit | StringConcat | StringSubstring | StringIndexOf | StringLength) ;
StringInit : val='strInit' ;
StringConcat : 'strConcat' lstr=(StrCommand) rstr=(StrCommand) ; // a variable or a string literal
StringSubstring : 'strSubstring' str=(StrCommand) begin=IntegerCommand end=IntegerCommand ;
StringIndexOf : 'strIndexOf' str=(StrCommand) schar=StrCommand ; // char type?
StringLength : 'strLength' str=(StrCommand) ;