$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Discard';

# List of the names of optional paramters
my @optionalParams = (
    'Quiesce',
    'QualificationData',
    'TargetScope'
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
$[/javascript (('' + myParent.Quiesce).length == 0) ? "" :
"        SoapData('Quiesce'),  # Optional parameter "
]
$[/javascript (('' + myParent.QualificationData).length == 0) ? "" :
"        SoapData('QualificationData'),  # Optional parameter "
]

$[/javascript (('' + myParent.TargetScope).length == 0) ? "" :
"        SOAP::Data->name('CPSMParams' => \\SOAP::Data->value( " +
"            SoapData('TargetScope'),  # Optional parameter \n" +
"        )), "
]
    )),
));

$[/myPlugin/project/ec_perl_code_block_2]
