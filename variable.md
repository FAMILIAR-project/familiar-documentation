# Variables

## Identifiers

FT_ID : ID ('.' ID)* ; // feature ID
FML_IDENTIFIER :  ID ('.' (ID|STAR))* | ID STAR;

## Copy and remove

CopyVariable : ('copy'|'cp') vid=FML_IDENTIFIER ; //('as')? (newvar=FML_IDENTIFIER)?;
RemoveVariable : ('removeVariable'|'rm') vid=FML_IDENTIFIER ;