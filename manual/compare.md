# compare

The compare operation is used to determine whether a feature model is a refactoring, a generalization, a specialization or an arbitrary edit of another feature model.

Let f and g be feature models, and let ``[[f]]`` (resp. ``[[g]]``) denote the set of configurations for f (resp. g); f is a specialization of g if ``[[f]]`` is included in ``[[g]]`` ; f is a generalization of g if ``[[g]]`` is included in ``[[f]]`` ; f is a refactoring of g if ``[[f]]`` is equal to ``[[g]]``; otherwise, f is an arbitrary edit of g.

cmp = compare f g

f and g are feature models

cmp is a string whose value is either GENERALIZATION, SPECIALIZATION, ARBITRARY or REFACTORING.