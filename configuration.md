# configuration

In FAMILIAR, it is possible to create feature model configurations and then select, deselect, or unselect a feature. 
Each of these configuration manipulation operations returns a boolean value to notify success or failure, i.e., if a feature does not exist in a feature model. 
(There is no failure if the selection or deselection of feature leads to an unvalid configuration -- see isValid). 
Accessors selectedF, deselectedF, unselectedF return the set of selected, deselected and unselected features of a configuration.


## Autoselect

The autoselect operation tries to populate a configuration so that the configuration becomes valid and complete, i.e., all features are either selected or deselected. Some strategies are implemented:

RANDOM (by default): features are randomly selected or deselected
MAX: populate the configuration so that the maximum number of features is selected
MIN: populate the configuration so that the minimum number of features is selected
Note that autoselect takes into account previous selection/deselection of features. For example, if the feature 'Z' has already been selected, autoselect tries to find a configuration according to one of the strategy described above and in which the feature 'Z' is selected.


// a configuration is a set of features selected
// BUT: some features are also 'deselected'
// and some other features are not selected / deselected

ConfigurationCmd : CreateConfiguration | CompleteConfiguration |
            SelectionFeature | AutoConfiguration |
            SelectedConfiguration | DeselectedConfiguration | UnselectedConfiguration ;

CreateConfiguration: 'configuration' fm=FMCommand ;
CompleteConfiguration: 'isComplete' config=ConfigurationCommand ; // full configuration?
SelectionFeature : op=('select'|'deselect'|'unselect') (fts+=FeatureExpression)+ 'in' config=ConfigurationCommand ; // STRING? // TODO: in conflict with the "in"/foreach

FeatureExpression: ft=IdentifierExpr | ft=StringExpr;
enum OpSelection: SELECT='select' | DESELECT='deselect' | UNSELECT='unselect' ;
AutoConfiguration : 'autoSelect' config=ConfigurationCommand (mode=AutoConfMode)?; // populate a configuration such that the configuration is valid
enum AutoConfMode : RANDOM='RANDOM'|MAX='MAX'|MIN='MIN'; // current strategies to populate a configuration: select the maximum/minimum number of features or randomly
SelectedConfiguration: 'selectedF' config=ConfigurationCommand  ; // features selected in a configuration
DeselectedConfiguration: 'deselectedF' config=ConfigurationCommand  ; // features deselected in a configuration
UnselectedConfiguration: 'unselectedF' config=ConfigurationCommand  ; // features unselected in a configuration