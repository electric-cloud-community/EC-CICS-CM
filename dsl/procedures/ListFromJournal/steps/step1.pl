$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (
    'report',
    'JnlRecType',
    'JnlCCVRel',
    'JnlCICSRel',
    'JnlCPID',
    'JnlScheme',
    'JnlUserID',
    'JnlObjGroup',
    'JnlObjName',
    'JnlObjType',
    'JnlCSD',
    'JnlContext',
    'ObjType',
    'ObjName',
    'ObjGroup',
    'RestrictionCriteria',
    'HashingScope',
    'Counts',
    'FilterDate',
    'Limit'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Handle Journal criteria
my @jnlCriteriaResult;
my @jnlCriteriaParams = ('JnlRecType', 'JnlCCVRel', 'JnlCICSRel', 'JnlCPID', 'JnlScheme', 'JnlUserID', 'JnlObjGroup', 'JnlObjName', 'JnlObjType', 'JnlCSD', 'JnlContext');
for my $param (@jnlCriteriaParams) {
    if (length($params{$param}) > 0) {
        push @jnlCriteriaResult, SoapData($param);
    }
}
my @JnlCriteria;
if(scalar(@jnlCriteriaResult) > 0) {
    @JnlCriteria =
        SOAP::Data->name('JnlCriteria' => \SOAP::Data->value(
            @jnlCriteriaResult
        ));
}

# Validate ObjectCriteria

if (scalar(@JnlCriteria) > 0) {
    if (length($params{'ObjType'}.$params{'ObjName'}.$params{'ObjGroup'}) > 0) {
        # Validate ObjectCriteria for where both JnlCriteria and ObjectCriteria exist

        # Check Object type is not a Journal Type
        if (($params{'ObjType'} eq 'EventStart') || ($params{'ObjType'} eq 'BSImage') || ($params{'ObjType'} eq 'EventData') || ($params{'ObjType'} eq 'EventEnd')) {
            print "ERROR: Since you have supplied journal criteria, the Resource Type specifies the type of a resource image in a BAImage, so it cannot be 'EventStart', 'BAImage', 'EventData', or 'EventEnd'!\n";
            exit -1;    
        }

        # Validate wildcards are at end
        if (($params{'ObjName'} =~ /\*.+$/) || ($params{'ObjGroup'} =~ /\*.+$/)) {
            print "ERROR: The wildcard character '*' must only occur at the end of the Resource Name or Resource Group!\n";
            exit -1;
        }

        # Validate Object Group against Object Type
        if(($params{'ObjType'} eq 'RESGROUP') || ($params{'ObjType'} eq 'RESDESC')) {
            if (length($params{'ObjGroup'}) > 0) {
                print "ERROR: You cannot specify a Resource Group when the Resource Type is 'ResGroup (Group for CSD)' or 'ResDesc (List for CSD)'!\n";
                exit -1;
            }
        }
    }
} else {
    # Validate ObjectCriteria for where JnlCriteria don't exist
    
    # Check Object type is a Journal Type
    if (($params{'ObjType'} ne 'EventStart') && ($params{'ObjType'} ne 'BSImage') && ($params{'ObjType'} ne 'EventData') && ($params{'ObjType'} ne 'EventEnd')) {
        print "ERROR: Since you have not supplied any journal criteria, the Resource Type must be 'EventStart', 'BAImage', 'EventData', or 'EventEnd'!\n";
        exit -1;    
    } elsif (length($params{'ObjName'}.$params{'ObjGroup'}) > 0) {
        print "ERROR: Since you have not supplied any journal criteria and the Resource Type is a journal object type, the Resource Name and Resource Group must be left empty!\n";
        exit -1;    
    }
}

# Handle Object Criteria
my @objCriteriaResult;
my @objCriteriaParams = ('ObjType', 'ObjName', 'ObjGroup');
for my $param (@objCriteriaParams) {
    if (length($params{$param}) > 0) {
        push @objCriteriaResult, SoapData($param);
    }
}
my @ObjectCriteria;
if (scalar(@objCriteriaResult) > 0) {
    @ObjectCriteria =
        SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            @objCriteriaResult
        ));
}

# Split and parse optional RestrictionCriteria
my @RestrictionCriteria = makeRestrictionCriteria($params{'RestrictionCriteria'});

# Handle optional Process Parameters
my @processParmsResult;
my @processParmsParameters = ('HashingScope', 'Counts', 'FilterDate', 'Limit');
for my $param (@processParmsParameters) {
    if (length($params{$param}) > 0) {
        push @processParmsResult, SoapData($param);
    }
}
my @ProcessParms;
if(scalar(@processParmsResult) > 0) {
    @ProcessParms =
        SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
            @processParmsResult
        ));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationType')
        )),
        @JnlCriteria,
        @ObjectCriteria,
        @RestrictionCriteria,
        @ProcessParms
    ));

$[/myPlugin/project/ec_perl_code_block_2]
