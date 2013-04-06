# Downloading and Installing FAMILIAR

Stay tuned for updates!
 * current version: '''1.0.7 (beta)''' 
 * We have moved to Xtext 2.0 and so last Eclipse versions (Juno)
 * '''The Eclipse update site is down, we will fix it ASAP'''

We provide different solutions for using FAMILIAR:
  * FAMILIAR environment, fully integrated modeling standalone app that can be executed as JAR file.
  * A plugin for the Eclipse platform, integrated with [http://wwwiti.cs.uni-magdeburg.de/iti_db/research/featureide FeatureIDE] ;
  * Another standalone version that supports console mode only.


### FAMILIAR environment

This is the standalone graphical version, or simply called the '''FAMILIAR Tool'''. The tool was developed using Java with Prefuse visualization toolkit and AWT/Swing. It offers fully integrated modeling environment which includes the FAMILIAR Editor, Console and Language. It is designed to provide an intuitive and easy to use user interface allowing non-expert users to build Feature Models and reason about them.

The following graph shows the architecture of the FAMILIAR Tool:

[[Image(wiki:readme:FAMILIARToolArchitecture.png, 35%)]]


The following graph shows the main window view of the FAMILIAR Editor:

[[Image(wiki:readme:FAMILIARTool-Main-v0.9.9.9.png, 65%)]]


Watch the FAMILIAR Tool demo on Screencast.com: http://www.screencast.com/t/1oJBNwvw5f41

The FAMILIAR Tool is available for download as a JAR file: http://mathieuacher.com/pub/FAMILIAR/FML-editor-1.0.3.jar

This version is developed by Aleksandar Jakšić (Colorado State University) 

=== Eclipse Plugin === 

'''The Eclipse update site is down, we will fix it ASAP'''

'''The Eclipse plugin requires Java 1.6 and Eclipse Juno (>= 4.2) with Xtext 2.0''' 

All dependent Eclipse projects or libraries (FeatureIDE, JavaBDD) are included 
either in the standalone version or in the Eclipse plugin version. 
You do not need FeatureIDE. 
Note that it is not possible to use an existing version of FeatureIDE since we have made some changes to the FeatureIDE code. 


Installing the Eclipse plugin via the update site-method:
	- Open eclipse.
	- Go to Help -> Install new software then click on "Add" button.
	- A dialog frame will be shown with tow fields
		The first is for the name.
		The second one is for the URL of the plugin. Paste the following link '''http://www.i3s.unice.fr/~acher/familiar/''' and validate
	- Select "FAMILIAR" in the new frame and click on "Next" and click again on "Next" if there is no dependence error is reported.
	- Click on "Finish" and restart your Eclipse. Your plugin should now be available.
	
Hint for MacOS users:
Select the cocoa-x86_64 version of Eclipse (there are some issues with SWT related to some MacOS versions)


==== Starting with the Eclipse Plugin (highly recommended to read) ====

Once you have installed FAMILIAR in the Eclipse environment, you should have an Eclipse menu called FAMILIAR. 
At this step, I suggest not to use the entry "Top Level" but to create a new Eclipse project, with a new file called foo.fml 
("fml" is the file extension supported by FAMILIAR). You can edit your FAMILIAR file with the FAMILIAR editor. 
Let say you write something like:

```
// foo.fml
fm1 = FM (A : B C [D]; D -> C; )
fm2 = FM (W : [X] Y Z; X <-> Y ; )
fm3 = FM (R : S [T] U; !U -> !S; ) 
```

At this step, you can right click on foo.fml and "Run as FAMILIAR script..." executes the script foo.fml. 

Some variables should appear in the FAMILIAR environment view. 
You can double click on variables to obtain a visual representation (using FeatureIDE editors). 
You also have an access to the top level. 
Type {{{ls}}} for instance to display the list of variables. 
Or simply {{{fm1}}}. 
Or new commands like:

```renameFeature fm1.A as "AAA"```



=== Standalone version (simple one) ===

The standalone version is simply a JAR file.

Available here:

TODO

```
> java -Xmx1024M -jar FML-1.0.7s.jar --help
```

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
        
(Option -o is no longer active at the moment, "output" is the default folder)

Here is an example session:

```

$ java -Xmx1024M -jar FML-1.0.7.jar foo.fml 
FAMILIAR (for FeAture Model scrIpt Language for manIpulation and Automatic Reasoning)  version 1.0.7 (beta)
http://familiar-project.github.com/
fml> ls
(FEATURE_MODEL, completeName: fm1, ns:) fm1 = A: [D] B C ; (D -> C);
(FEATURE_MODEL, completeName: fm3, ns:) fm3 = R: S [T] U ; (!U -> !S);
(FEATURE_MODEL, completeName: fm2, ns:) fm2 = W: [X] Y Z ; (X <-> Y);
fml> fm1
fm1: (FEATURE_MODEL) A: [D] B C ; (D -> C);
fml> renameFeature fm1.A as "AAA"
res0: (BOOLEAN) true
fml> fm1
fm1: (FEATURE_MODEL) AAA: [D] B C ; (D -> C);
fml> c1 = configuration fm1
c1: (CONFIGURATION) selected: [AAA, B, C] 	 deselected: []
fml> c1
c1: (CONFIGURATION) selected: [AAA, B, C] 	 deselected: []
fml> autoSelect c1 MAX
res1: (BOOLEAN) true
fml> c1
c1: (CONFIGURATION) selected: [D, AAA, B, C] 	 deselected: []
fml> c2 = configuration fm1
c2: (CONFIGURATION) selected: [AAA, B, C] 	 deselected: []

```

Another more funny session is here. 
Look at the poster, the "corresponding" FAMILIAR [attachment:poster.fml script] and the FAMILIAR output below:

```
> java -jar FML-1.0.7.jar 
FAMILIAR (for FeAture Model scrIpt Language for manIpulation and Automatic Reasoning)  version 1.0.3 (beta)
http://familiar-project.github.com/
fml> run "FML-scripts/poster.fml"
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
Technique: (UpdatingAndExtractingViews|ReasoningWithTwoKindsOfVariability|ReconcilingFMs)+ ; 
CaseStudy: (MedicalImagingWorkflows|VideoSurveillanceProcessingChains|ReverseEngineeringSoftwareArchitecture) ;
fmSupport: (FEATURE_MODEL) Support: Language Environment Automation ; 
Environment: Eclipse [Standalone] TextualEditor ; 
Automation: (SAT|BDD)+ ;
rootE: (FEATURE) Slicing
res0: (BOOLEAN) true
```


[[Image(wiki:WikiStart:ASE-poster-Slicing2.png, 25%)]]


