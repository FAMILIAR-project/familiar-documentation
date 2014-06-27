# Empirical Evaluation of Ontologic-aware Feature Model Synthesis 

## How to reproduce the experiments

To reproduce the experiments you have to clone two github repositories:
* [KSynthesis](https://github.com/gbecan/FOReverSE-KSynthesis) repository (version used: [ESE-evaluation](https://github.com/gbecan/FOReverSE-KSynthesis/releases/tag/ESE-evaluation)).
* [FAMILIAR](https://github.com/FAMILIAR-project/familiar-language) (version used: [ESE-evaluation](https://github.com/FAMILIAR-project/familiar-language/releases/tag/ESE-evaluation))

The first repository contains the algorithms and heuristics for synthesizing a correct and meaningful FM. It also contains an __Evaluation__ project with the two FM datasets (SPLOT and PCM) and the necessary code to run the experiments.
The second repository is a dependency for the algorithms.

The SPLOT dataset contains 126 FMs encoded in _SXFM_ format.
The PCM dataset contains 30 FMs encoded in _fmlbdd_ format.

To use heuristics based on Wikipedia, you need to install additional files.

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
* Set the path to your Wikipedia Miner properties files in [HeuristicLoader.java](https://github.com/gbecan/FOReverSE-KSynthesis/blob/master/Evaluation/src/foreverse/ksynthesis/evaluation/commons/HeuristicLoader.java) class (WIKIPEDIA_DB and WIKTIONARY_DB variables).
* Run the JUnit tests in 
[ESEEvaluation.java](https://github.com/gbecan/FOReverSE-KSynthesis/blob/master/Evaluation/src/foreverse/ksynthesis/evaluation/ese/ESEEvaluation.java), 
* Have a long coffee break.
* The results are in the output directory.
* To analyze the results, we provide R scripts in [R-analysis folder](https://github.com/gbecan/FOReverSE-KSynthesis/tree/master/Evaluation/R-analysis). They produce summary files in the output directory.
