import java.io.File

def procName = 'ListFromRepository'
procedure procName, {

	step 'step1',
    	  command: new File(pluginDir, "dsl/procedures/$procName/steps/step1.pl").text,
    	  shell: 'ec-perl'

}
  
