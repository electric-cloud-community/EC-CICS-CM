$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Backout';

# List of the names of optional paramters
my @optionalParams = (
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
            SOAP::Data->name('SelectionCriteria' => \SOAP::Data->value(
                    SoapData('CPID'),
                    SoapData('Scheme'),
                    $[/javascript (('' + myParent.EventID).length == 0) ? "" : "SoapData('EventID')"]
                ))
        ));

$[/myPlugin/project/ec_perl_code_block_2]
