$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Delete';

# List of the names of optional paramters
my @optionalParams = (
    'IntegrityToken',
    'MonSpecInherit',
    'RTASpecInherit',
    'WLMSpecInherit',
    'LNKSWSCGParm',
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

my @mParams = ('ObjName', 'ObjGroup', 'ObjType', 'ObjDefVer');

my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", %params);

# Handle optional parametrs
my @paramsForRequest;
for my $p (@optionalParams) {
    if ($params{$p} ne "") {
        push @paramsForRequest, SoapData($p);
    }
}
my @processParms;
if(scalar(@paramsForRequest) > 0) {
    @processParms = SOAP::Data->name('ProcessParms' => \SOAP::Data->value(@paramsForRequest));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
            SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
                    SoapData('LocationName'),
                    SoapData('LocationType')
                )),
            SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
            @processParms

    ));

$[/myPlugin/project/ec_perl_code_block_2]
