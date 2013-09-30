# Empirical Evaluation of Ontologic-aware Feature Model Synthesis 

Data, code, and instructions for reproducing the results will be available very soon

We freeze the revision (used for the experiments):
https://github.com/FAMILIAR-project/familiar-language/commit/0e28c3add661d1063eb4c0be78ad7b603a22f2f3 

## How to reproduce the experiments

### Datasets
* Download the two datasets (SPLOT and PCM) : [Datasets](https://github.com/FAMILIAR-project/familiar-documentation/blob/master/manual/ontologicalTutorial/datasets.zip)

The SPLOT dataset contains 93 FMs encoded in _SXFM_ format.  
The PCM dataset contains 30 FMs encoded in _fmlbdd_ format.

### Installing FAMILIAR



### Installing the heuristics

To use heuristics based on WordNet and Wikipedia, you need to install additional files.

#### Heuristics based on WordNet
* Download and install WordNet 3.1 (the 3.0 version may produce errors with a particular FM): [WordNet](http://wordnet.princeton.edu/wordnet/download/current-version/)
* Download the properties file that FAMILIAR will use to access WordNet: [wordnet_properties.xml]()
* Set the path to WordNet **dict** folder inside the previous properties file.

#### Heuristics based on Wikipedia
To access Wikipedia, we use an offline dump of the encyclopedia. Such dump can be downloaded here: 
[latest dump](http://download.wikimedia.org/enwiki/latest/enwiki-latest-pages-articles.xml.bz2)
This dump is not directly usable by our tool. 


### Executing the tests

