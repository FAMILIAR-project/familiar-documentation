# renameFeature (operator) 

The *renameFeature* operation sets a new name to a feature in a feature model

``b = renameFeature ft as ftnew``

ft is a feature

ftnew is a string

b is a boolean value:
 * **true** if the renaming can be performed (ft does exist, ftnew does not exist)
 * **false** otherwise (and the feature model is not modified)
