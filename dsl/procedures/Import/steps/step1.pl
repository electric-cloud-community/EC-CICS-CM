$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Import';

# List of the names of optional paramters
my @optionalParams = (

);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Validateion

if(($params{'resDefinition'} eq 'SelectionCriteria')) {
    if(!$params{'CPID'} || !$params{'EventID'}) {
        print "ERROR: 'CPID' and 'EventId' should be specified.";
        exit -1;
    }
}
elsif(!$params{'ObjName'} || !$params{'ObjType'} || !$params{'ObjGroup'}) {
    print "ERROR: 'ObjName', 'ObjType' and 'ObjGroup' should be specified.";
    exit -1;
}

my @criteria;
if($params{'resDefinition'} eq 'SelectionCriteria') {
    @criteria = SOAP::Data->name('SelectionCriteria' => \SOAP::Data->value(
            SoapData('CPID'),
            SoapData('EventID')
        ));
}
else {
    @criteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjName'),
            SoapData('ObjType'),
            SoapData('ObjGroup')
        ));
}

# Procedure-specific Code
# -----------------------

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
            SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
                    SoapData('LocationType'),
                    SoapData('LocationName')
                )),
            @criteria,
            SOAP::Data->name('InputData' => \SOAP::Data->value(
                    SoapData('TargetLocationType'),
                    SoapData('TargetLocationName')
                )),
            SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
                    SoapData('RegisterCPID'),
                    SoapData('PurgeImportedRecords')
                ))
        ));

$[/myPlugin/project/ec_perl_code_block_2]
