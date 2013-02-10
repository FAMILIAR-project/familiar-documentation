# aggregate 

The aggregate operation is used to inter-relate a set of feature models, eventually with cross-tree, propositional constraints. 
Note that, contrary to the [wiki:merge merge] operator, we assume that there is no common feature between feature models, i.e., the features have distinct names. 

## examples 

In the following FAMILIAR script, **fm1**, **fm2** and **fm3** are aggregated into an unique feature model, **fm4**, and in which a constraint relates features J and C.

Then, a cleanup (line 7) is applied to **fm4** so that, for example, dead features are removed (here: E is removed due to the constraint C -> !E). 
Note that, in addition, the feature C becomes mandatory due to the constraints.

A synthetic, fake root is automatically created during the aggregation. This root can be renamed (as in line 13). 
Below, we show a graphical representation of fm4 at the end of the FAMILIAR script (using FeatureIDE editor):  


It is possible that after an aggregation, the feature model is ''invalid'', i.e., it contains no valid configuration. 
It is the case of fm3 (see below):

