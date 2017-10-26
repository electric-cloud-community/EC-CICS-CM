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

#### TODO If restrictionCriteria is non-empty, split and parse its contents, and add them to $data

my @paramsForRequest;
for my $name (@names) {
    if (defined $params{$name}) {
        push @paramsForRequest, SoapData($name);
    }
}

my $data =
SOAP::Data->name('CCV530' => \SOAP::Data->value( #### TODO This produces <List><CCV510>...</CCV510></List>, but we actually need them nested in the opposite order -- I don't know how to make SOAP::Lite do that
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('CConfig'),
        SOAP::Data->name('ListCount' => 1),
        SOAP::Data->name('ListElement' => \SOAP::Data->value(
            SOAP::Data->name('DefA' => \SOAP::Data->value(
                SoapData('ObjGroup'),
                SoapData('ObjType'),
                SoapData('ObjName')
            ))
        ))
    )) #### ,
####    SOAP::Data->name('InputData' => \SOAP::Data->value( #### TODO Why is this here? I don't think it's needed
####       @paramsForRequest
####    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
