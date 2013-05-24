### Breathing Ontological Knowledge Into Feature Model Management

This document presents: 
 * a complete environment we have developed for synthesizing feature models
 * a comprehensive tutorial for using the tool

Important management operations of FAMILIAR, like ksynthesis, slicing, merging, diff, refactoring, are now equiped with ontological capabilities since all are based on the same synthesis procedure.

In particular, we raise previous limitations and open avenues for a practical usage in reverse engineering or maintenance scenarios.
 
``This page is under construction``

##### Authors

 * Guillaume Bécan (University of Rennes 1, Inria / Irisa, Triskell team)
 * Sana Ben Nasr (University of Rennes 1, Inria / Irisa, Triskell team)
 * Mathieu Acher (University of Rennes 1, Inria / Irisa, Triskell team)
 * Benoit Baudry (University of Rennes 1, Inria / Irisa, Triskell team)

#### Motivation

#### Illustrative Examples


#### Features of the Environment

Our tool offers an interactive mode where the user can import a formula (e.g.,
in DIMACS format), synthesizes a complete feature model and export
the result in different formats. During the synthesis, the
GUI displays a ranking list of parent candidates for every
feature, a list of clusters and a graphical preview of the feature model
in construction. During the interactive process, users can:
 * select or ignore a parent candidate in the ranking lists ;
 * select a parent for a cluster within the cluster’s features
or any potential parent feature outside the cluster (the
user can also consider only a subset of a cluster when
selecting the parent) ;
 * undo a previous choice ;
 * define the different heuristics and parameters of the
synthesis ;
 * automatically generate a complete FM according to previous
choices and selected heuristics.

A typical usage is to perform some choices, generate the
current result (through a graphical representation of the feature model)
and reiterate until having a satisfactory model. In particular,
the scenario of an interactive and sound refactoring of a feature model is made possible.





