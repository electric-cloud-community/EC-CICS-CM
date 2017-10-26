
// Was generated by REST Plugin Wizard
def procName = 'Create migration scheme'
def stepName = 'CreateScheme'
procedure procName, description: 'Dynamically create a migration scheme with a single migration path', {

    step stepName,
        command: """
\$[/myProject/scripts/preamble]
use EC::RESTPlugin;
EC::RESTPlugin->new->run_step('CreateScheme');
""",
        errorHandling: 'failProcedure',
        exclusiveMode: 'none',
        releaseMode: 'none',
        shell: 'ec-perl',
        timeLimitUnits: 'minutes'

}