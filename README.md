Bluemix OAuth2 SSO Sample
==================

Sample Ruby application showing how to integrate with the IBM Bluemix Single Sign On service as an OAuth2 provider in a Cloud Foundry application.

## Installation
Clone or fork this repository then run bundle to install the dependent gems.  

    git clone https://github.com/tbeauvais/bluemix-sso-sample.git
    cd bluemix-sso-sample
    bundle

Run the specs

    rspec spec
    
## Deploy to Bluemix
If you don't already have an account on [IBM Bluemix](https://ace.ng.bluemix.net) you will need to create one in order to deploy the sample application.
   
### Rename Application 
First you will need to edit the "name" and "host" in the manifest.yml file to ensure the application name and route to the application are unique. For example:

    applications:
      - name: my-sso-sample
        host: my-sso-sample

### Push Application to Cloud foundry (Bluemix)
Run the following commands from the cloned repository (e.i. bluemix-sso-sample). This will connect you to Bluemix and then push the application to the the Cloud Foundry server and launch it. Note you won't be able to run the application until it is bound to the Single Sign On service and configured. 

    $ cf api https://api.ng.bluemix.net
    $ cf login
    $ cf push





## External Documentation

* [Getting started with Single Sign On](https://www.ng.bluemix.net/docs/#services/SingleSignOn/index.html#sso_gettingstarted)
* [OAuth2 Gem](https://github.com/intridea/oauth2)
