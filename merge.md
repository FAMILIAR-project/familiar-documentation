# merge

The merge operator is used to merge two (or more than two) feature models. 
The result is another feature model. 
The merge uses a name-based matching: two features match if and only if they have the same name. 
Several modes are defined for this operator. 
This mode indicates how the merge has to be done in terms of set of conﬁgurations preserved in the resulting feature model. 


'''merge''' ''mode'' sfm 

''mode'' can be:
  * '''intersection'''
  * '''union''' (eq '''sunion''')
  * '''diff'''

sfm is a set of feature models, for example, you can use the following notation 

{{{ { fm1, fm2, ..., fmn } }}} to represent a set of feature models fm1, fm2, ..., fmn.

You can also use this notation:
{{{ fm* }}} that represents a set of variables whose name begins with {{{fm}}}


## merge intersection 

The intersection mode is the most restrictive option: the merged feature model, FMr, expresses the common valid configurations of FM1 and FM2, i.e., a configuration that is valid in FM1 and FM2 is also valid in FMr. 

## merge union (or sunion)

When the merge operator is applied in (strict) union mode, the set of configurations of the merged feature model, FMr , is exactly the union of sets of configurations of input feature models, FM1 and FM2.