# Set 

SetOperations : SetCard | SetToNames | SetBelongs | SetUnionOrIntersection | SetEmpty | SetAddOrRemove | IsEmptySet ;

SetCard : 'size' set=SetCommand ; //TODO: @deprecated 'set_card'
SetBelongs : 'setBelongs' setl=FML_IDENTIFIER setr=FML_IDENTIFIER;
SetUnionOrIntersection : op=('setUnion'|'setIntersection'|'setDiff') setl=SetCommand setr=SetCommand;
SetEmpty : val='setEmpty' ;
SetAddOrRemove : op=('setAdd'|'setRemove') setl=SetCommand var=Command;
IsEmptySet : 'setIsEmpty' set=SetCommand ;
SetToNames : 'names' set=SetCommand ;

                    | {SetOperation.left=current} sop=(SetOperator) right=ComplexCommand // TODO new!


