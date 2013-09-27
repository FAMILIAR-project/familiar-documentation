ModelCriteria : ModelingApproachDimension [KeyConcepts] AdditionalConcepts* :: _ModelCriteria ;

ModelingApproachDimension : LanguageOrNotation PhaseOrActivity UnitOfEncapsulation [ViewsAndConcreteSyntax] :: _ModelingApproachDimension ;

LanguageOrNotation : Formalism AboutStandard DomainAppliance :: _LanguageOrNotation ;

Formalism : NotFormal
	| [FormalOrRigorousAnalyzableList] Choice :: FormalOrRigorous ;

Choice : Formal
	| Rigorous ;

AboutStandard : IsStandard
	| IsBuiltOnStandard
	| NonStandard ;

IsBuiltOnStandard : StandardList :: _IsBuiltOnStandard ;

DomainAppliance : DomainList [ExceptDomainList] :: isApplicationDomainSpecific
	| isGeneralPurpose ;

PhaseOrActivity : WhichActivity* WhichPhase+ :: _PhaseOrActivity ;

WhichActivity : Validation
	| Verification
	| Evolution
	| Analysis
	| OtherActivity ;

OtherActivity : ListOfOtherActivity :: _OtherActivity ;

WhichPhase : EarlyRequirement
	| LateRequirements
	| ArchitectureAndHighLevelDesign
	| LowLevelDesign
	| Implementation
	| Integration
	| Deployment
	| OtherPhase ;

OtherPhase : ListOfOtherPhase :: _OtherPhase ;

UnitOfEncapsulation : listOfUnits :: _UnitOfEncapsulation ;

ViewsAndConcreteSyntax : TypeOfSupportedViews+ TypeOfConcreteSyntax+ :: _ViewsAndConcreteSyntax ;

TypeOfSupportedViews : Structural
	| Behavioural
	| Intentional
	| QualityBased
	| OtherViews ;

QualityBased : ListOfSupportedQualities :: _QualityBased ;

OtherViews : ListOfOtherViews :: _OtherViews ;

TypeOfConcreteSyntax : Graphical
	| Textual ;

KeyConcepts : Paradigm [Composability] [Traceability] MappingWithLifeCycle* [Modularity] [TradeOffAnalysis] [ToolSupport] [EmpiricalStudies] :: _KeyConcepts ;

Paradigm : Technique+ SupportedParadigm+ :: _Paradigm ;

Technique : TechniqueName ;

SupportedParadigm : ObjectOriented
	| AspectOriented
	| Functional
	| ServiceOriented
	| ComponentOriented
	| FeatureOriented
	| OtherParadigm+ :: OtherParadigm_ ;

OtherParadigm : ListOfOtherParadigm ;

Composability : [CreationOfNewUnit] [ListOfOperators] [CompositionDefinition] TypeOfCompositionUse+ [CompositionOperators] AlgebraicPropertyOfOperators* [OperatorsWithClosure] [WhatKindOfIncrementalTechniques] QualityOfComposition* ComposedModel+ [OperatorSupport] :: _Composability ;

CreationOfNewUnit : ListOfCreationTechniques :: _CreationOfNewUnit ;

ListOfOperators : OtherKinds SpecificationMethod BasicOrCroscutting :: _ListOfOperators ;

OtherKinds : [ListOfOtherKinds] :: _OtherKinds ;

SpecificationMethod : Explicit Implicit :: _SpecificationMethod ;

Explicit : PatternMatching
	| Binding ;

Implicit : [AdditionalDetailsOnSignature] :: _Implicit ;

BasicOrCroscutting : Basic Crosscutting :: _BasicOrCroscutting ;

Crosscutting : SyntaxBased SemanticBased Decision :: _Crosscutting ;

Decision : Probabilistic Deterministic Fuzzy :: _Decision ;

CompositionDefinition : [ListOfCompositionDefinition] :: _CompositionDefinition ;

TypeOfCompositionUse : Symmetric
	| Asymmetric
	| OtherTypeOfComposition ;

OtherTypeOfComposition : [ListOfTypeOfComposition] :: _OtherTypeOfComposition ;

CompositionOperators : [ListOfCompositionOperators] :: _CompositionOperators ;

AlgebraicPropertyOfOperators : Commutativity
	| Associativity
	| Transitivity
	| OtherProperties ;

Commutativity : [ListOfCommutableOperators] :: _Commutativity ;

Associativity : [ListOfAssociativeOperators] :: _Associativity ;

Transitivity : [ListOfTransitiveOperators] :: _Transitivity ;

OtherProperties : [ListOfOtherProperties] :: _OtherProperties ;

OperatorsWithClosure : [ListOfClosedOperators] :: _OperatorsWithClosure ;

WhatKindOfIncrementalTechniques : [ListOfIncrementalTechniques] :: _WhatKindOfIncrementalTechniques ;

QualityOfComposition : ResultingModelVariability
	| ResultingModelCoupling
	| OtherQualtyCriteria ;

OtherQualtyCriteria : [ListOfCompositionQualityCriteria] :: _OtherQualtyCriteria ;

ComposedModel : ANewViewBasedOnComposedModel
	| AnAnnotedOriginalViewOnComposedModel
	| ASetOfCompositionOperators
	| UsingATool
	| OtherComposedModelPresentation ;

OtherComposedModelPresentation : [ListOfModelPresentation] :: _OtherComposedModelPresentation ;

OperatorSupport : [SupportOrderingComposition] :: _OperatorSupport ;

SupportOrderingComposition : [AditionalInformationOnOrdering] :: _SupportOrderingComposition ;

Traceability : TypeOTraceability* Capabilities* :: _Traceability ;

TypeOTraceability : Horizontal
	| Vertical
	| OtherTraceability ;

Horizontal : [ListOfHorizontalTracedEntity] :: _Horizontal ;

Vertical : [ListOfVerticalTracedEntity] :: _Vertical ;

OtherTraceability : [ListOfOtherTraceability] :: _OtherTraceability ;

Capabilities : RefinementIdentification
	| CompositionSourceIdentification
	| OtherCapabilities ;

OtherCapabilities : [ListOfOtherCapabilities] :: _OtherCapabilities ;

MappingWithLifeCycle : ModelingTechniqueForMovingFromPreviousStage
	| ModelingTechniqueForMovingToNextStage ;

ModelingTechniqueForMovingFromPreviousStage : [ListOfModelingTechniqueForPreviousStage] :: _ModelingTechniqueForMovingFromPreviousStage ;

ModelingTechniqueForMovingToNextStage : [ListOfModelingTechniqueForNextStage] :: _ModelingTechniqueForMovingToNextStage ;

Modularity : TypeOfSupport+ CompositionSeparationFromModuleSpecification* :: _Modularity ;

TypeOfSupport : SpecialOperators
	| FirstClassElement
	| DomainspecificElement
	| ServiceLevelAgreement
	| InterfaceDefinition
	| OtherTypeOfSupport ;

OtherTypeOfSupport : ListOfTypeOfSupport :: _OtherTypeOfSupport ;

CompositionSeparationFromModuleSpecification : SeparationYes
	| SeparationNo
	| OtherDetails+ :: OtherDetails_ ;

OtherDetails : ListOfOtherDetails ;

TradeOffAnalysis : TradeOffAnalysisAsPartOfTheTechnique
	| TradeOffAnalysisForEasyAccessToData
	| NoConceptOffTradeOffAnalysis
	| OtherTradeOffAnalysis ;

TradeOffAnalysisForEasyAccessToData : [ListOfEasyAccessToData] :: _TradeOffAnalysisForEasyAccessToData ;

OtherTradeOffAnalysis : [ListOfOtherTradeOffAnalysis] :: _OtherTradeOffAnalysis ;

ToolSupport : WhatActivitySupportedByTool* [HowItIsVisualized] HelpProvidedByTool* :: _ToolSupport ;

WhatActivitySupportedByTool : Specification
	| CompositionActivity
	| AnalysisActivity
	| ValidationActivity
	| VerificationActivity
	| ModelConsistencyActivity
	| OtherActivitySuppportedByTools ;

HowItIsVisualized : [ListOfVisualizedToolSuppport] :: _HowItIsVisualized ;

HelpProvidedByTool : UnwantedInteractions
	| Dependencies
	| OtherHelp ;

UnwantedInteractions : [ListOfUnwanted] :: _UnwantedInteractions ;

Dependencies : [ListOfDependencies] :: _Dependencies ;

OtherHelp : [ListOfOtherHelp] :: _OtherHelp ;

EmpiricalStudies : [Description] :: _EmpiricalStudies ;

Description : [ListOfDescriptions] :: _Description ;

AdditionalConcepts : Reusability+ :: Reusability_
	| [RelationshipBetweenModules] [Visualization] :: Scalablity
	| Abstraction
	| Usability
	| IntermoduleInteraction
	| Evolvability
	| ModelingEffort
	| Completeness
	| Expressiveness ;

Reusability : IsUnitOfEncapsulatiionReusable
	| AppliesTo+ :: AppliesTo_
	| UnitOfReuse
	| [FeatureForUseOrReuse] [FeatureForUnitCustomization] :: LanguageFeatures ;

AppliesTo : GeneralPurpose
	| DomainSpecific
	| Applicationspecific
	| OtherReuseAppliance ;

UnitOfReuse : [ListOfUnitOfReuse] :: _UnitOfReuse ;

FeatureForUseOrReuse : PreserveConsistency HowToReuse CharacterizationOfReuse :: _FeatureForUseOrReuse ;

PreserveConsistency : [Preserve] [DoNotPreserve] [PreservePartially] :: _PreserveConsistency ;

PreservePartially : [ListOfNotPreserved] [ListOfPreserved] :: _PreservePartially ;

HowToReuse : PointcutInstanciation [TechniqueOfReuse] :: _HowToReuse ;

PointcutInstanciation : [PointcutMatch] [ExplicitPointcut] :: _PointcutInstanciation ;

TechniqueOfReuse : [CompositionOperator] :: _TechniqueOfReuse ;

FeatureForUnitCustomization : [PointcutExpressiveness] [GenericParameter] :: _FeatureForUnitCustomization ;

%%

not ServiceOriented implies not ServiceLevelAgreement ;

