import groovy.transform.BaseScript
import com.electriccloud.commander.dsl.util.BasePlugin

//noinspection GroovyUnusedAssignment
@BaseScript BasePlugin baseScript

// Variables available for use in DSL code
def pluginName = args.pluginName
def upgradeAction = args.upgradeAction
def otherPluginName = args.otherPluginName

def pluginKey = getProject("/plugins/$pluginName/project").pluginKey
def pluginDir = getProperty("/projects/$pluginName/pluginDir").value

//List of procedure steps to which the plugin configuration credentials need to be attached
// ** steps with attached credentials
def stepsWithAttachedCredentials = [
  [procedureName: 'AddCmdToChgPkg', stepName: 'step1'],
  [procedureName: 'AddResDefToChgPkg', stepName: 'step1'],
  [procedureName: 'AddToResDesc', stepName: 'step1'],
  [procedureName: 'AddToResGroup', stepName: 'step1'],
  [procedureName: 'Alter', stepName: 'step1'],
  [procedureName: 'Approve', stepName: 'step1'],
  [procedureName: 'Backout', stepName: 'step1'],
  [procedureName: 'Copy', stepName: 'step1'],
  [procedureName: 'CreateInOther', stepName: 'step1'],
  [procedureName: 'CreateInRepository', stepName: 'step1'],
  [procedureName: 'DeleteFromOther', stepName: 'step1'],
  [procedureName: 'DeleteFromRepository', stepName: 'step1'],
  [procedureName: 'Disapprove', stepName: 'step1'],
  [procedureName: 'DiscardAdHoc', stepName: 'step1'],
  [procedureName: 'DiscardChgPkg', stepName: 'step1'],
  [procedureName: 'Import', stepName: 'step1'],
  [procedureName: 'InquireInJournal', stepName: 'step1'],
  [procedureName: 'InquireInOther', stepName: 'step1'],
  [procedureName: 'InquireInRepository', stepName: 'step1'],
  [procedureName: 'InstallAdHoc', stepName: 'step1'],
  [procedureName: 'InstallChgPkg', stepName: 'step1'],
  [procedureName: 'ListFromJournal', stepName: 'step1'],
  [procedureName: 'ListFromOther', stepName: 'step1'],
  [procedureName: 'ListFromRepository', stepName: 'step1'],
  [procedureName: 'ListWithinResults', stepName: 'step1'],
  [procedureName: 'Migrate', stepName: 'step1'],
  [procedureName: 'NewcopyAdHoc', stepName: 'step1'],
  [procedureName: 'NewcopyChgPkg', stepName: 'step1'],
  [procedureName: 'Ready', stepName: 'step1'],
  [procedureName: 'RemoveCmdFromChgPkg', stepName: 'step1'],
  [procedureName: 'RemoveFromResDesc', stepName: 'step1'],
  [procedureName: 'RemoveFromResGrp', stepName: 'step1'],
  [procedureName: 'RemoveResDefFromChgPkg', stepName: 'step1'],
  [procedureName: 'RenameFromGroup', stepName: 'step1'],
  [procedureName: 'RenameResDef', stepName: 'step1'],
  [procedureName: 'Recover', stepName: 'step1'],
  [procedureName: 'Unready', stepName: 'step1'],
  [procedureName: 'UpdateInOther', stepName: 'step1'],
  [procedureName: 'UpdateInRepository', stepName: 'step1']

]
// ** end steps with attached credentials

project pluginName, {

	loadPluginProperties(pluginDir, pluginName)
	loadProcedures(pluginDir, pluginKey, pluginName, stepsWithAttachedCredentials)
	//plugin configuration metadata
	property 'ec_config', {
		form = '$[' + "/projects/${pluginName}/procedures/CreateConfiguration/ec_parameterForm]"
		property 'fields', {
			property 'desc', {
				property 'label', value: 'Description'
				property 'order', value: '1'
			}
		}
	}

}

// Copy existing plugin configurations from the previous
// version to this version. At the same time, also attach
// the credentials to the required plugin procedure steps.
upgrade(upgradeAction, pluginName, otherPluginName, stepsWithAttachedCredentials)
