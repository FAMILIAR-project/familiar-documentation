# Model-based Variability Management

The tutorial has been presented at ECMFA/ECSA/ECOOP'13 conference 

http://www.lirmm.fr/ecmfa13/?id=158#tutorial10

> Abstract: The customization of almost everything is observed in a wide range of domains. Many organizations should address the challenge of extending, changing, customizing or conﬁguring numerous kinds of systems and artefacts (requirements, components, services, languages, architectural or design models, codes, user interfaces, etc.) for use in a particular context. As a result, modeling and managing variability of such systems and artefacts is a crucial activity in a growing number of software engineering contexts (e.g., software product lines, dynamic adaptive architectures). Numerous model-based techniques have been proposed and usually consist in i) a variability model (e.g., a feature model), ii) a model (e.g., a class diagram) expressed in a domain-speciﬁc modeling language (e.g., Uniﬁed Modelling language), and iii) a realization layer that maps and transforms variation points into model elements. Based on a selection of desired features in the variability model, a derivation engine can automatically synthesise customized models – each model corresponding to an individual product.
In this tutorial, we present the foundations and tool-supported techniques of state-of-the-art variability modeling technologies. In the first part, we briefly exemplify the management of variability in some systems/artefacts (design models, languages, product conﬁgurators). We introduce the Common Variability Language (CVL), a representative approach and ongoing effort involving both academic and industry partners to promote standardization variability modeling technology. In the second part, we focus on feature models the most popular notation to formally represent and reason about commonality and variability of a software system. Feature modelling languages and tools, directly applicable to a wide range of model-based variability problems and application domains, are presented. The FAMILIAR language and environment is used to perform numerous management operations like the import, export, compose, decompose, edit, conﬁgure, compute diffs, refactor, reverse engineer, test, or reason about (multiple) feature models. We describe their theoretical foundations, efficient implementations, and how these operations can be combined to realize complex variability management tasks. In the third part, we show how to combine feature models and other modeling artefacts. We revisit the examples given in the first part of the tutorial, using the Kermeta workbench and familiarCVL, an implementation of CVL. Finally we present some of the ongoing challenges for variability modeling.
At the end of the tutorial, participants (being practitioners or academics, beginners or advanced) will learn languages, tools and novel variability modeling techniques they can directly use in their industrial contexts or as part of their research.

## Authors

 * Mathieu Acher (IRISA/Inria, University of Rennes I), actual presenter at the conference
 * Benoit Combemale (IRISA/Inria, University of Rennes I)
 * Olivier Barais (IRISA/Inria, University of Rennes I)

### Acknowledgments

## Material

 * slides of the tutorial (TODO: link)
 * related articles (TODO: links)
 * FAMILIAR scripts 
 * CVL models (TODO: links)
 
and packaged tools to interactively play with the models during the tutorial.
FAMILIAR instructions: (TODO link)


### CVL


### Install your environment

If you want to install your own envronment

Please Download an xtext bundle from
http://www.eclipse.org/Xtext/download.html

next install obeo designer from the following update site. 
http://www.obeo.fr/download/release/designer/6.1/latest/juno3/update/
Please choose only obeo designer and DO NOT install obeodesigner dependencies

Next download our update site from 
http://goo.gl/HqOQE
Unzip it and add it as a local update site. 

Please select featureIDE, Familiar and CVL

You have now the last eclipse with the last familiar and the last cvl derivator. 

Start eclipse, go to the modelling perspective. 

Next create your own modelling project
(Viewpoint-> Modeling). 

Create your cvl model and your base model. 
You can draw it, derive it and generate the familiar script to check the correctness of the VAM model.

If you want to draw it. Do a right clic on the project -> ViewPointsSelection and select the three cvl representation.

Let us go. 

Have fun. 


