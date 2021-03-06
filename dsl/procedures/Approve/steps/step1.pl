$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Approve';

# List of the names of optional paramters
my @optionalParams = (
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Build output

my @data = SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('SelectionCriteria' => \SOAP::Data->value(
        SoapData('CPID'),
        SoapData('Scheme')
    )),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('Role')
    ))

));

$[/myPlugin/project/ec_perl_code_block_2]
