$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add';

# List of the names of optional paramters
my @optionalParams = (

);

my @mandatoryParams = (
    'ContainerName',
    'ContainerType'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------


# Validation

if(($params{'Command'} ne 'Add') and $params{'TContainer'}) {
    print "ERROR: 'target container' is relevant only when packaging an Add command. It identifies the ResGroup to which you want the resource definitions added.";
    exit -1;
}

my @paramsForRequest;
for my $p (@optionalParams, @mandatoryParams) {
    if (defined $params{$p}) {
        push @paramsForRequest, SoapData($p);
    }
}

my @mParams = ('Command', 'ObjGroup', 'ObjName', 'ObjType', 'ObjDefVer', 'TContainer');

my @ObjectCriteria = createObjectCriteria(\@mParams, 1, "CmdAPost", %params);

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
            SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
                    SoapData('LocationType')
                )) ,
            SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
            SOAP::Data->name('InputData' => \SOAP::Data->value(
                    @paramsForRequest
                ))
        ));

$[/myPlugin/project/ec_perl_code_block_2]
