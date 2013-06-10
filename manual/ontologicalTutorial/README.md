### Breathing Ontological Knowledge Into Feature Model Management

This document presents: 
 * installation instructions 
 * motivation of our work
 * a complete environment we have developed for synthesizing feature models (see screencast below)
 * a comprehensive tutorial for using the tool


Important management operations of FAMILIAR, like ksynthesis, slicing, merging, diff, refactoring, are now equiped with ontological capabilities since all are based on the same synthesis procedure.

In particular, we raise previous limitations and open avenues for a practical usage in reverse engineering or maintenance scenarios.
 
##### Authors

 * Guillaume Bécan (University of Rennes 1, Inria / Irisa, Triskell team)
 * Sana Ben Nasr (University of Rennes 1, Inria / Irisa, Triskell team)
 * Mathieu Acher (University of Rennes 1, Inria / Irisa, Triskell team)
 * Benoit Baudry (University of Rennes 1, Inria / Irisa, Triskell team)

#### Installation instructions 

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

#### Run on the illustrative example

[![ScreenShot](YoutubePreview.png)](https://www.youtube.com/watch?v=C-65cV74LAY)


First, we start FAMILIAR and execute the following command that starts the environment:
``` ksynthesis --interactive Wiki ```

![Image](tutorial01.png)

The next step consists in setting the parameters of the synthesis in the synthesis menu. For this example, we choose Wikipedia Miner with the Wikipedia database as the heuristic for parent candidates, Smith-Waterman as the clustering metric and we set the threshold at 0.6. After each change, the parent candidates lists and the clusters are updated.

We start synthesizing the FM by choosing a parent for the feature *Proprietary License*. We open the list of parent candidates for this feature and see that *License* is the best parent according to our heuristic which seems correct.

![Image](tutorial02_1.png)

Thus, we right-click on *License* and select the option *Select this parent*. As a result, the features and their new relation appears on the FM overview.

![Image](tutorial02_2.png)

We continue our synthesis by choosing a parent for the cluster {PostgreSQL, MySQL}. We know by experience that these features are two types of database and should be siblings. We right-click on the cluster and select the only option available.

![Image](tutorial03_1.png)

A popup window appears asking for the parent of the selected cluster.

![Image](tutorial03_2.png)

At this point, we can deselect some features that should not be part of this clusters. The list of common parent that appears below is automatically updated and we can choose the parent for this subcluster. In our case we keep all the features selected and we choose Storage as the parent. Once again, the FM is updated and as the two previous choices do not form a single tree, two trees are displayed side by side.

![Image](tutorial03_3.png)

The other available operation on a cluster is to select its parent within the cluster's features. The same operation is available on cliques. We consider the clique {Storage, License, Wiki, Hosting}. This time, to choose *Wiki* as the parent of the clique, we right-click on the feature and select the only option displayed.

![Image](tutorial04_1.png)

A popup window appears asking for the children of *Wiki*.

![Image](tutorial04_2.png)

We confirm the choice and the FM is updated resulting in a single tree.

![Image](tutorial04_3.png)

At this point of the synthesis, we start to recognize the hierarchy of the desired FM. Thus, we try to generate the rest of the hierarchy by selecting the *Complete FM* option in the synthesis menu.

![Image](tutorial05.png)

The result is not yet satisfactory. The heuristics we set at the beginning of the synthesis do not perform well on the other features. For example they propose *Programming Language* as the child of *Storage* instead of *Wiki*. 

In that case, we can change the heuristics and the clustering threshold to influence the automated synthesis or we can continue to provide information by choosing or ignoring a parent in the remaining features. This example illustrates that synthesizing a FM is an iterative process. Moreover the order of the choices may differ from one user to another. We could adopt a top down approach by first defining the root and its descendants or a bottom up approach by first defining the leaves of the hierarchy and finally setting the root. We can also adopt an unordered approach like in our example. This diversity of approaches forces us to present all the pieces of information at the same time instead of presenting one feature at a time.










