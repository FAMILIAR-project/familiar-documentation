# Feature groups


GetFGroups : kindOfGroups=KindOfGetGroups fm=FMCommand ;
enum KindOfGetGroups : OR='getORGroups'|XOR='getXORGroups'|MUTEX='getMUTEXGroups' ;

ComputeFGroups : kindOfGroups=KindOfComputeGroups fm=FMCommand ;
enum KindOfComputeGroups : OR='computeORGroups'|XOR='computeXORGroups'|MUTEX='computeMUTEXGroups' ;