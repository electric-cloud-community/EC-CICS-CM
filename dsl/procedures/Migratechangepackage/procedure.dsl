
// Was generated by REST Plugin Wizard
def procName = 'Migrate change package'
def stepName = 'MigratePackage'
procedure procName, description: 'Migrate a change package', {

    step stepName,
        command: """
\$[/myProject/scripts/preamble]
use EC::RESTPlugin;
EC::RESTPlugin->new->run_step('MigratePackage');
""",
        errorHandling: 'failProcedure',
        exclusiveMode: 'none',
        releaseMode: 'none',
        shell: 'ec-perl',
        timeLimitUnits: 'minutes'

}
