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