# Graphital for use on OpenShift

Modified version of Graphital for use on OpenShift (http://www.openshift.com). Writes vitals to file rather than sending to a server, so a script can be used to pull these files instead.

## Usage 

* Clone this repository and copy everything *except* 'openshift_action_hooks', 'README.md' and '.git' into a directory called 'graphital' at the root of your OpenShift app repository
* Copy the action hook script excerpts from the 'openshift_action_hooks' directory into the appropriate scripts within your OpenShift app repository's '.openshift/action_hooks' directory
* Within the 'graphital' directory you copied the files to, make a copy of the 'graphital.conf.eg' file called 'graphital.conf'. Configure the variables within this file to suit your use case
* Use Git to add and commit the new files and start your app

## Notes and Assumptions

* The Graphital home directory is set as '$OPENSHIFT_DATA_DIR/graphital'. If the OpenShift cartridge you are using does not use $OPENSHIFT_DATA_DIR for some reason, you will need to set this environment variable to point to your cartridge's permanent storage space 
* The deploy script excerpt assumes the repository's version of the Graphital directory can be found at '$OPENSHIFT_REPO_DIR/graphital'. If this is not true in your case, alter the deploy script accordingly
 

See https://github.com/rashidkpc/graphital for more information about Graphital.
    
