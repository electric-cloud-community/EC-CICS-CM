import java.io.File

def procName = 'CreateConfiguration'
procedure procName,
        description: 'Creates a plugin configuration', {

    step 'createConfiguration',
            command: new File(pluginDir, "dsl/procedures/$procName/steps/createConfiguration.pl").text,
            errorHandling: 'abortProcedure',
            exclusiveMode: 'none',
            postProcessor: 'postp',
            releaseMode: 'none',
            shell: 'ec-perl',
            timeLimitUnits: 'minutes'

    step 'createAndAttachCredential',
        command: new File(pluginDir, "dsl/procedures/$procName/steps/createAndAttachCredential.pl").text,
        errorHandling: 'failProcedure',
        exclusiveMode: 'none',
        releaseMode: 'none',
        shell: 'ec-perl',
        timeLimitUnits: 'minutes'

    property 'ec_stepsWithAttachedCredentials', value: '''[{"procedureName":"AddCmdToChgPkg", "stepName":"step1"},{"procedureName":"AddResDefToChgPkg", "stepName":"step1"},{"procedureName":"AddToResDesc", "stepName":"step1"},{"procedureName":"AddToResGroup", "stepName":"step1"},{"procedureName":"Alter", "stepName":"step1"},{"procedureName":"Approve", "stepName":"step1"},{"procedureName":"Backout", "stepName":"step1"},{"procedureName":"Copy", "stepName":"step1"},{"procedureName":"CreateInOther", "stepName":"step1"},{"procedureName":"CreateInRepository", "stepName":"step1"},{"procedureName":"DeleteFromOther", "stepName":"step1"},{"procedureName":"DeleteFromRepository", "stepName":"step1"},{"procedureName":"Disapprove", "stepName":"step1"},{"procedureName":"Discard", "stepName":"step1"},{"procedureName":"Import", "stepName":"step1"},{"procedureName":"InquireInJournal", "stepName":"step1"},{"procedureName":"InquireInOther", "stepName":"step1"},{"procedureName":"InquireInRepository", "stepName":"step1"},{"procedureName":"InstallAdHoc", "stepName":"step1"},{"procedureName":"InstallChgPkg", "stepName":"step1"},{"procedureName":"ListFromJournal", "stepName":"step1"},{"procedureName":"ListFromOther", "stepName":"step1"},{"procedureName":"ListFromRepository", "stepName":"step1"},{"procedureName":"ListWithinResults", "stepName":"step1"},{"procedureName":"Migrate", "stepName":"step1"},{"procedureName":"NewcopyAdHoc", "stepName":"step1"},{"procedureName":"NewcopyChgPkg", "stepName":"step1"},{"procedureName":"Ready", "stepName":"step1"},{"procedureName":"Unready", "stepName":"step1"},{"procedureName":"UpdateInOther", "stepName":"step1"},{"procedureName":"UpdateInRepository", "stepName":"step1"}]'''

}
