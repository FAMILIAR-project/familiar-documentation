# slicing 

The slice operator returns a new feature model such as its set of configurations is the one of the original
feature model but only a subset of its features are taken into consideration. One can either include or exclude a set of Feature. 

```
fml> fm = FM(A : B C [D]; B : (E|F);)
fm: (FEATURE_MODEL) A: [D] B C ;
B: (E|F) ;
fml> slice fm excluding {fm.A fm.C}
res1: (FEATURE_MODEL) B: (E|F) [D] ;
```

**_Few Explainations_**

The set of configurations of the feature model fm are : 
- A B C D F
- A B C D E
- A B C E
- A B C F

By slicing, only features B D E F are kept, configurations become : 
- B D F
- B D E
- B E
- B F

that is the set of configurations of the resulting feature model res1.