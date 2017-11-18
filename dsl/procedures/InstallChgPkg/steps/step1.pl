$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Install';

# List of the names of optional paramters
my @optionalParams = (
    'Quiesce',
    'QualificationData',
    'Discard',
    'Force',
    'TargetScope',
    'ResGroupObjectType',
    'CONNDEF_RefAssign',
    'FILEDEF_RelatedScope',
    'FILEDEF_Usage',
    'PROGDEF_RelatedScope',
    'PROGDEF_Usage',
    'PROGDEF_Mode',
    'TDQDEF_RelatedScope',
    'TDQDEF_Usage',
    'TDQDEF_Mode',
    'TRANDEF_RelatedScope',
    'TRANDEF_Usage',
    'TRANDEF_Mode',
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Deal with optional parameters and build output

my @data = SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('SelectionCriteria' => \SOAP::Data->value(
        SoapData('CPID'),
        SoapData('Scheme')
    )),
    SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
        SoapDataOptional('Quiesce'),
        SoapDataOptional('QualificationData'),
        SoapDataOptional('Discard'),
        SoapDataOptional('Force'),
$[/javascript (('' + myParent.TargetScope + myParent.ResGroupObjectType + myParent.CONNDEF_RefAssign
    + myParent.FILEDEF_RelatedScope + myParent.FILEDEF_Usage
    + myParent.PROGDEF_RelatedScope + myParent.PROGDEF_Usage + myParent.PROGDEF_Mode
    + myParent.TDQDEF_RelatedScope + myParent.TDQDEF_Usage + myParent.TDQDEF_Mode
    + myParent.TRANDEF_RelatedScope + myParent.TRANDEF_Usage + myParent.TRANDEF_Mode).length == 0) ? "" :
"        SOAP::Data->name('CPSMParms' => \\SOAP::Data->value( "
]
            SoapDataOptional('TargetScope'),
            SoapDataOptional('ResGroupObjectType'),
$[/javascript (('' + myParent.CONNDEF_RefAssign).length == 0) ? "" :
"            SOAP::Data->name('CONNDEF' => \\SOAP::Data->value( \n" +
"                SOAP::Data->name('RefAssign' => $params{'CONNDEF_RefAssign'}),  # Optional parameter \n" +
"            )), "
]
$[/javascript (('' + myParent.FILEDEF_RelatedScope + myParent.FILEDEF_Usage).length == 0) ? "" :
"            SOAP::Data->name('FILEDEF' => \\SOAP::Data->value( \n" +
"                SOAP::Data->name('RelatedScope' => $params{'FILEDEF_RelatedScope'}),  # Optional parameter "
]
$[/javascript (('' + myParent.FILEDEF_Usage).length == 0) ? "" :
"                SOAP::Data->name('Usage' => $params{'FILEDEF_Usage'}),  # Optional parameter "
]
$[/javascript (('' + myParent.FILEDEF_RelatedScope + myParent.FILEDEF_Usage).length == 0) ? "" :
"            )), "
]
$[/javascript (('' + myParent.PROGDEF_RelatedScope + myParent.PROGDEF_Usage + myParent.PROGDEF_Mode).length == 0) ? "" :
"            SOAP::Data->name('PROGDEF' => \\SOAP::Data->value( \n" +
"                SOAP::Data->name('RelatedScope' => $params{'PROGDEF_RelatedScope'}),  # Optional parameter "
]
$[/javascript (('' + myParent.PROGDEF_Usage).length == 0) ? "" :
"                SOAP::Data->name('Usage' => $params{'PROGDEF_Usage'}),  # Optional parameter "
]
$[/javascript (('' + myParent.PROGDEF_Mode).length == 0) ? "" :
"                SOAP::Data->name('Mode' => $params{'PROGDEF_Mode'}),  # Optional parameter "
]
$[/javascript (('' + myParent.PROGDEF_RelatedScope + myParent.PROGDEF_Usage + myParent.PROGDEF_Mode).length == 0) ? "" :
"            )), "
]
$[/javascript (('' + myParent.TDQDEF_RelatedScope + myParent.TDQDEF_Usage + myParent.TDQDEF_Mode).length == 0) ? "" :
"            SOAP::Data->name('TDQDEF' => \\SOAP::Data->value( \n" +
"                SOAP::Data->name('RelatedScope' => $params{'TDQDEF_RelatedScope'}),  # Optional parameter "
]
$[/javascript (('' + myParent.TDQDEF_Usage).length == 0) ? "" :
"                SOAP::Data->name('Usage' => $params{'TDQDEF_Usage'}),  # Optional parameter "
]
$[/javascript (('' + myParent.TDQDEF_Mode).length == 0) ? "" :
"                SOAP::Data->name('Mode' => $params{'TDQDEF_Mode'}),  # Optional parameter "
]
$[/javascript (('' + myParent.TDQDEF_RelatedScope + myParent.TDQDEF_Usage + myParent.TDQDEF_Mode).length == 0) ? "" :
"            )), "
]
$[/javascript (('' + myParent.TRANDEF_RelatedScope + myParent.TRANDEF_Usage + myParent.TRANDEF_Mode).length == 0) ? "" :
"            SOAP::Data->name('TRANDEF' => \\SOAP::Data->value( \n" +
"                SOAP::Data->name('RelatedScope' => $params{'TRANDEF_RelatedScope'}),  # Optional parameter "
]
$[/javascript (('' + myParent.TRANDEF_Usage).length == 0) ? "" :
"                SOAP::Data->name('Usage' => $params{'TRANDEF_Usage'}),  # Optional parameter "
]
$[/javascript (('' + myParent.TRANDEF_Mode).length == 0) ? "" :
"                SOAP::Data->name('Mode' => $params{'TRANDEF_Mode'}),  # Optional parameter "
]
$[/javascript (('' + myParent.TRANDEF_RelatedScope + myParent.TRANDEF_Usage + myParent.TRANDEF_Mode).length == 0) ? "" :
"            )), "
]
$[/javascript (('' + myParent.TargetScope + myParent.ResGroupObjectType + myParent.CONNDEF_RefAssign
    + myParent.FILEDEF_RelatedScope + myParent.FILEDEF_Usage
    + myParent.PROGDEF_RelatedScope + myParent.PROGDEF_Usage + myParent.PROGDEF_Mode
    + myParent.TDQDEF_RelatedScope + myParent.TDQDEF_Usage + myParent.TDQDEF_Mode
    + myParent.TRANDEF_RelatedScope + myParent.TRANDEF_Usage + myParent.TRANDEF_Mode).length == 0) ? "" :
"        )), "
]
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
