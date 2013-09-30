# Empirical Evaluation of Ontologic-aware Feature Model Synthesis 

## How to reproduce the experiments

### Datasets
* Download the two datasets (SPLOT and PCM) : [Datasets](https://github.com/FAMILIAR-project/familiar-documentation/blob/master/manual/ontologicalTutorial/datasets.zip).

The SPLOT dataset contains 93 FMs encoded in _SXFM_ format.  
The PCM dataset contains 30 FMs encoded in _fmlbdd_ format.

### Installing FAMILIAR
To install FAMILIAR, you have to clone the git repository of the projet and compile it: [FAMILIAR](https://github.com/FAMILIAR-project/familiar-language)
For our experiments we used the following version: https://github.com/FAMILIAR-project/familiar-language/commit/0e28c3add661d1063eb4c0be78ad7b603a22f2f3.

To use heuristics based on WordNet and Wikipedia, you need to install additional files.

#### Heuristics based on WordNet
* Download and install WordNet 3.1 (the 3.0 version may produce errors with a particular FM): [WordNet](http://wordnet.princeton.edu/wordnet/download/current-version/).
* Download the properties file that FAMILIAR will use to access WordNet: [wordnet_properties.xml](wordnet_properties.xml).
* Set the path to WordNet **dict** folder inside the previous properties file.

#### Heuristics based on Wikipedia
To access Wikipedia, we use the [Wikipedia Miner](http://wikipedia-miner.cms.waikato.ac.nz/) toolkit.
It works on a database extracted from a dump of the encyclopedia. 
Such dump can be downloaded here: [latest dump](http://download.wikimedia.org/enwiki/latest/enwiki-latest-pages-articles.xml.bz2).

To extract the database, you have to follow this tutorial : [Obtaining wikipedia data](https://github.com/dnmilne/wikipediaminer/wiki/Obtaining-wikipedia-data).
For the dump of English articles of April 2013, the extraction process took us 2 days on a 8-core processor. The resulting database represents about 40GB.

* Download the properties file that FAMILIAR will use to access the Wikipedia Miner database: [wikipedia_template.xml](wikipedia_template.xml).
* Set the path to the Wikipedia Miner database inside the properties file.

For Wiktionary, we used the same process on a [Wiktionary dump](http://dumps.wikimedia.org/enwiktionary/latest/enwiktionary-latest-pages-articles.xml.bz2).

### Executing the tests
* Set the path to your WordNet and Wikipedia Miner properties files in [KSynthesisTest.java](https://github.com/FAMILIAR-project/familiar-language/blob/master/FAMILIAR/src/fr/unice/polytech/modalis/familiar/test/heuristics/KSynthesisTest.java) class (WORDNET_DB, WIKIPEDIA_DB and WIKTIONARY_DB variables).
* Run the JUnit tests in 
[ICSE2014Experiment1.java](https://github.com/FAMILIAR-project/familiar-language/blob/master/FAMILIAR/src/fr/unice/polytech/modalis/familiar/test/heuristics/ICSE2014Experiment1.java), 
[ICSE2014Experiment2.java](https://github.com/FAMILIAR-project/familiar-language/blob/master/FAMILIAR/src/fr/unice/polytech/modalis/familiar/test/heuristics/ICSE2014Experiment2.java) and 
[ICSE2014Experiment3.java](https://github.com/FAMILIAR-project/familiar-language/blob/master/FAMILIAR/src/fr/unice/polytech/modalis/familiar/test/heuristics/ICSE2014Experiment2.java) classes.
* Have a coffee break.
