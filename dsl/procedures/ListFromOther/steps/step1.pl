$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup', 'ObjDefVer', 'RestrictionCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

#### TODO Split and parse optional restrictionCriteria

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
	SoapData('ObjType'),
	SoapData('ObjGroup'),
	SoapData('ObjName')
	#### TODO Add optional ObjDefVer here
    ))
    #### TODO Add optional RestrictionCriteria here and to form.xml
    #### TODO Add optional ProcessParms here and to form.xml
));

$[/myPlugin/project/ec_perl_code_block_2]
