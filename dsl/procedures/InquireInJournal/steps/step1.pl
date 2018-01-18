$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Inquire';

# List of the names of optional paramters
my @optionalParams = (
    'report',
    'ObjName',
    'ObjGroup',
    'CPID',
    'Scheme'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjType'),
            SoapDataOptional('ObjName'),
            SoapDataOptional('ObjGroup'),
            SoapDataOptional('CPID'),
            SoapDataOptional('Scheme'),
            SoapData('ObjectInstance')
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
