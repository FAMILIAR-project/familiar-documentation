# extract

The extract operation returns a new feature model

features are the feature specified as parameter plus its descendant features.
the root feature is the feature specified as parameter
Note that the extract operation does not alter the feature model in which the feature parameter belongs to.

fm = extract ft

ft is a feature

fm is a feature model

See also [slice operator] (slicing.md)