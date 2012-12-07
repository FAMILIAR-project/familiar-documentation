# Variables

## Identifiers

FT_ID : ID ('.' ID)* ; // feature ID
FML_IDENTIFIER :  ID ('.' (ID|STAR))* | ID STAR;

## Copy and remove

CopyVariable : ('copy'|'cp') vid=FML_IDENTIFIER ; //('as')? (newvar=FML_IDENTIFIER)?;
RemoveVariable : ('removeVariable'|'rm') vid=FML_IDENTIFIER ;

## Equality *eq* and *neq*
The eq (resp. neq) binary operator returns true (resp. false) if the contents of the two variables are equals.

The equality is specific to a type:

two variables of feature model type are equal if
 1. they represent the same set of configurations, i.e., the compare operator applied to the two variables returns REFACTORING (see [compare](compare.md))
 2. they have the same hierarchy

two variables of type features are equal if they have the same name 

two variables of type configuration are equal if
 1. they belong to the same feature model 
 2. they have the same set of selected, deselected and unselected features

TODO