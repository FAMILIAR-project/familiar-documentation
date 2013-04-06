# Downloading and Installing FAMILIAR

We provide different solutions for using FAMILIAR:
  * FAMILIAR environment, fully integrated modeling standalone app that can be executed as JAR file ; 
  * A plugin for the Eclipse platform, integrated with [http://wwwiti.cs.uni-magdeburg.de/iti_db/research/featureide FeatureIDE] ;
  * Another standalone version that supports console mode only.


### FAMILIAR environment

This is the standalone graphical version, or simply called the **FAMILIAR Environment**. 
The tool was developed using Java with Prefuse visualization toolkit and AWT/Swing. 
It offers fully integrated modeling environment which includes the FAMILIAR Editor, Console and Language. 
It is designed to provide an intuitive and easy to use user interface allowing (non-expert) users to build Feature Models and reason about them.

Watch the FAMILIAR Tool demo on Screencast.com: http://www.screencast.com/t/1oJBNwvw5f41

The FAMILIAR Tool is available for download as a JAR file: 
[1.0.7](../release/FML-environment-1.0.7.jar)



### Basic environment

The standalone version is simply a JAR file that supports console mode only. 

Available here:
[1.0.7](../release/FML-basic-1.0.7.jar)

```
java -jar -Xmx1024M ../release/FML-basic-1.0.7.jar --help

Usage: java FML
                [-v|--verbose] [-h|--help] [--version] [(-p|--path)[:paths1,paths2,...,pathsN ]] [(-o|--output) <output>] [<filename>]

  [-v|--verbose]
        Requests verbose output.

  [-h|--help]
        Help.

  [--version]
        Version of FAMILIAR

  [(-p|--path)[:paths1,paths2,...,pathsN ]]
        Paths to consider (FAMILIAR files should be located in those paths)

  [(-o|--output) <output>]
        Output folder where FAMILIAR files are produced.

  [<filename>]
        FAMILIAR file to interpret.
```


Here is an example session:

```
scriptsRepository $ java -jar -Xmx1024M ../release/FML-basic-1.0.7.jar foo.fml 
FAMILIAR (for FeAture Model scrIpt Language for manIpulation and Automatic Reasoning)  version 1.0.7 (beta)
http://familiar-project.github.com/
fml> ls
(FEATURE_MODEL) fm3
(FEATURE_MODEL) fm1
(FEATURE_MODEL) fm2
fml> fm1
fm1: (FEATURE_MODEL) A: [D] B C ; 
(D -> C);
fml> renameFeature fm1.A as "AAA"
res0: (BOOLEAN) true
fml> fm1
fm1: (FEATURE_MODEL) AAA: [D] B C ; 
(D -> C);
fml> c1 = configuration fm1
c1: (CONFIGURATION) selected: [AAA, B, C]   deselected: []
fml> select D in c1
res1: (BOOLEAN) true
fml> c1
c1: (CONFIGURATION) selected: [D, AAA, B, C] 	 deselected: []
fml> c2 = configuration fm1
c2: (CONFIGURATION) selected: [AAA, B, C] 	 deselected: []
fml> 

```

Another more funny session is here. 
Look at the poster, the "corresponding" FAMILIAR script [poster.fml](../scriptsRepository/poster.fml) and the FAMILIAR output below:

```
scriptsRepository macher1$ java -jar -Xmx1024M ../release/FML-basic-1.0.7.jar 
FAMILIAR (for FeAture Model scrIpt Language for manIpulation and Automatic Reasoning)  version 1.0.7 (beta)
http://familiar-project.github.com/
fml> run "poster.fml"
fmASE: (FEATURE_MODEL) Slicing: Technique [FutureWork] Motivation Paper Algorithm Support ; 
Technique: (ReasoningWithTwoKindsOfVariability|UpdatingAndExtractingViews|ReconcilingFMs)+ ; 
Motivation: (MultipleInterRelatedFMs|LargeAndComplexFMs)+ ; 
Paper: (Short|Long|Demonstration)+ ; 
Algorithm: (SyntacticalTechnique|SemanticsAware) [PropositionalLogics] [Semantics] [CorrectiveCapabilities] [RootSupport] [SupportForConstraints] ; 
Support: [Language] [Environment] [Automation] ; 
Demonstration: CaseStudy ; 
Semantics: Hierarchy [SetOfConfigurations] ; 
Environment: (Eclipse|Standalone)+ [Editors] ; 
Automation: (SAT|BDD)+ ; 
CaseStudy: (MedicalImagingWorkflows|VideoSurveillanceProcessingChains|ReverseEngineeringSoftwareArchitecture) ; 
Editors: [GraphicalEditor] [TextualEditor] ; 
(CorrectiveCapabilities -> SupportForConstraints);
(TextualEditor -> Eclipse);
(CorrectiveCapabilities -> SemanticsAware);
(SetOfConfigurations <-> SemanticsAware);
(Algorithm <-> RootSupport);
(Language -> TextualEditor);
Language;
(Algorithm <-> CorrectiveCapabilities);
(Algorithm <-> Semantics);
(SemanticsAware -> Automation);
fmSemantics: (FEATURE_MODEL) Semantics: Hierarchy SetOfConfigurations ;
fmAlgorithm: (FEATURE_MODEL) Algorithm: RootSupport SupportForConstraints SemanticsAware ;
fmEnvironment: (FEATURE_MODEL) Slicing: Technique [CaseStudy] ; 
Technique: (ReasoningWithTwoKindsOfVariability|UpdatingAndExtractingViews|ReconcilingFMs)+ ; 
CaseStudy: (MedicalImagingWorkflows|VideoSurveillanceProcessingChains|ReverseEngineeringSoftwareArchitecture) ;
fmSupport: (FEATURE_MODEL) Support: Language Environment Automation TextualEditor ; 
Environment: Eclipse [Standalone] ; 
Automation: (SAT|BDD)+ ;
rootE: (FEATURE) Slicing
res4: (BOOLEAN) true
fml> 
```

### Eclipse Plugin 

*The Eclipse update site is down, we will fix it ASAP*

*The Eclipse plugin requires Java 1.6 and Eclipse Juno (>= 4.2) with Xtext 2.0*




