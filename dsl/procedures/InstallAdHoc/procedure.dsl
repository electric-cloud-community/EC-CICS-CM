import java.io.File

def procName = 'InstallAdHoc'
procedure procName, {

	step 'step1',
    	  command: new File(pluginDir, "dsl/procedures/$procName/steps/step1.pl").text,
    	  postProcessor: 'postp',
    	  shell: 'ec-perl'

}
  
