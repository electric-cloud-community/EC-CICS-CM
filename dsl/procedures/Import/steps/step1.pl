$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Import';

# List of the names of optional paramters
my @optionalParams = (
   'CPID',
   'EventID',
   'ObjName',
   'ObjType',
   'ObjGroup',
   'RegisterCPID',
   'PurgeImportedRecords',
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Validation

if(($params{'resDefinition'} eq 'SelectionCriteria')) {
    # Validate optional parameters
    if(!(length($params{'CPID'}) > 0)) {
        print "ERROR: 'CPID' should be specified when 'Select resource definitions' is set to 'Selection Criteria'.";
        exit -1;
    }    
    if((length($params{'ObjName'}) > 0) || (length($params{'ObjType'}) > 0) || (length($params{'ObjGroup'}) > 0)) {
        print "ERROR: 'Resource Name', 'Resource Type', and 'Resource Group' must not be specified when 'Select resource definitions' is set to 'Selection Criteria'.";
        exit -1;
    }
}
else {
    # Validate optional parameters
    if(!(length($params{'ObjName'}) > 0) || !(length($params{'ObjType'}) > 0)) {
        print "ERROR: 'Resource Name' and 'Resource Type' should be specified when 'Select resource definitions' is set to 'Object Criteria'.";
        exit -1;
    }
    if((length($params{'CPID'}) > 0) || (length($params{'EventID'}) > 0)) {
        print "ERROR: 'CPID' and 'EventID' must not be specified when 'Select resource definitions' is set to 'Object Criteria'.";
        exit -1;
    }
    
    # Validate Object Group against Object Type
    if (($params{'ObjType'} eq 'RESGROUP') || ($params{'ObjType'} eq 'RESDESC')) {
        if (length($params{'ObjGroup'}) > 0) {
            print "ERROR: You cannot specify an Resource Group when the Resource Type is 'ResGroup (Group for CSD)' or 'ResDesc (List for CSD)'!\n";
            exit -1;
        }
    }
    
    # Validate wildcards are at end
    if (($params{'ObjName'} =~ /\*.+$/) || ($params{'ObjGroup'} =~ /\*.+$/)) {
        print "ERROR: The wildcard character '*' must only occur at the end of the Resource Name or Resource Group!\n";
        exit -1;
    }
}

my @criteria;
if($params{'resDefinition'} eq 'SelectionCriteria') {
    @criteria = SOAP::Data->name('SelectionCriteria' => \SOAP::Data->value(
        SoapData('CPID'),
        SoapDataOptional('EventID')
    ));
}
else {
    @criteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('ObjName'),
        SoapData('ObjType'),
        SoapDataOptional('ObjGroup')
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
            SoapDataOptional('RegisterCPID'),
            SoapDataOptional('PurgeImportedRecords')
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
