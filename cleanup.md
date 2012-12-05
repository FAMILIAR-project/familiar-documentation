# cleanup (operator)


macher-wifi:Documents macher1$ java -jar -Xmx1024M FML-1.0.1.jar 
FAMILIAR (for FeAture Model scrIpt Language for manIpulation and Automatic Reasoning)  version 1.0 (beta)
University of Nice Sophia Antipolis, UMR CNRS 6070, I3S Laboratory
https://nyx.unice.fr/projects/familiar/
fml> fm1 = FM (A : (B or C); )
fm1: (FEATURE_MODEL) A: (B|C) ;
fml> fm1 = FM (A : (B or C); B requires C ; )
fm1: (FEATURE_MODEL) A: (B|C) ; 
(B -> C);
fml> cleanup fm1
fml> fm1
fm1: (FEATURE_MODEL) A: C ;



