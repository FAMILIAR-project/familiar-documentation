# Synthesis of feature model
 
/*
 could be ksynthesis fm0 with fm1
 BUT
 it is preferable to have a decomposed specification with all parts optional
 importantly, KST can be specified using accessors of FML
 */            
Synthesis: 'ksynthesis' fm=FMCommand ('with' kst=KnowledgeSpecification)? ;
// ('withKST' kst=KnowledgeSpecification)? ;

//('with' LEFT_HOOK kst=KnowledgeSpecification RIGHT_HOOK)? ;

KnowledgeSpecification : {KnowledgeSpecification} (hierarchy=HierarchySpecification)? 
												 (COMMA groups=GroupsSpecification)? 
												 				         (COMMA constraints=ConstraintsSpecification)? ;

HierarchySpecification : 'hierarchy=' 
							 (features+=HProduction ';')+  ;
HProduction : name=ID ':' features+=FT_ID+ ;

GroupsSpecification : 'groups=' (groups+=GroupSpec ';')+ ; // getFGroups?
GroupSpec : XorGroupSpec | MtxGroupSpec | OrGroupSpec ; 
XorGroupSpec : 'xorGroup' LEFT_PAREN name=ID ':' features+=FT_ID+ RIGHT_PAREN ;
MtxGroupSpec : 'mtxGroup' LEFT_PAREN name=ID ':' features+=FT_ID+ RIGHT_PAREN ; 
OrGroupSpec : 'orGroup' LEFT_PAREN name=ID ':' features+=FT_ID+ RIGHT_PAREN ; 


ConstraintsSpecification : 'constraints=' csts=ConstraintExpr ; // constraint strategy