# Shell commands

Shell : cmd=(Exit|Exist|Listing|IsConflicting|State|Help) ;

Exit : val=('quit'|'exit');
Exist : val=('isExisting') var=FML_IDENTIFIER ;
IsConflicting : val=('isConflicting') var=FML_IDENTIFIER ;
Listing : val=('ls'|'vars') (opt=OPT_LISTING)?;
enum OPT_LISTING : NORMAL='--normal'|VERBOSE='--verbose'|VALUE_ONLY='--withValues' ;
State : val=('state'|'memory'|'cpu') ; // memory usage, CPU speed?
Help : val=('help') ; //cmd=FML_IDENTIFIER;

/*** UTILITIES ******/

PrinterUtility : op=('print'|'println') arg=LArgs ;

LArgs : args+=Command (COMMA args+=Command)* ;

// TODO: unify! @deprecated: print_vars
//Arg : StringArg | IdArg ;
//StringArg : val=STRING;
//IdArg : val=FML_IDENTIFIER;

// graphical display or print information on the variable
GDisplay : cmdDisplay=('gdisplay') var=(FMCommand|ConfigurationCommand) ; //@deprecated: display //@deprecated: 'print_var'// can also be a configuration

GListing : cmd='glisting'|'gls' {GListing} ; // TODO: what's that?