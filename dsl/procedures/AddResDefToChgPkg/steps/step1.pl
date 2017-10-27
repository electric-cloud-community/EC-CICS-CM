$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add'; 

# List of the names of optional paramters
my @optionalParams = ('ObjectCriteria');

# TODO Add more procedure-specific metadata: how to structure XML, etc ?

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# TODO Can we figure out a way to drive this with metadata so it could be shared?

my @data  =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('CConfig'),
#        SOAP::Data->name('ListCount' => 1), # TODO Handle ObjectCriteria non-empty case
#        SOAP::Data->name('ListElement' => \SOAP::Data->value(
            SOAP::Data->name('keya' => \SOAP::Data->value(
                SoapData('ObjName'),
                SoapData('ObjType'),
                SoapData('ObjDefVer'),
            )),
#        )),
    )),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('ContainerName'),
        SoapData('ContainerType')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
