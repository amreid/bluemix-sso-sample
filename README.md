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
If you don't already have an account on [IBM Bluemix](https://ace.ng.bluemix.net) you will need to create one in order to deploy the sample application. You sould also be familiar with Cloud Foundry and have the Cloud Foundry [command line tool](http://docs.cloudfoundry.org/devguide/installcf/whats-new-v6.html) installed. 
   
### Rename Application 
First you will need to edit the "name" and "host" in the manifest.yml file to ensure the application name and route to the application are unique. For example:

    applications:
      - name: my-sso-sample
        host: my-sso-sample

### Push Application to Cloud foundry (Bluemix)
Run the following commands from the cloned repository (e.i. bluemix-sso-sample). This will connect you to Bluemix and then push the application to the the Cloud Foundry server and launch it. **Note -** you won't be able to run the application until it is bound to the Single Sign On service and configured. 

    $ cf api https://api.ng.bluemix.net
    $ cf login
    $ cf push


## Add Single Sign On Service
Login to [Bluemix](https://ace.ng.bluemix.net) and go to the Dashboard page where the sso sample application was deployed. Click on the ADD A SERVICE button, and usder Security click on the Single Sign On service. In the dropdown for the App, select the name you gave to the application you deployed, and then hit the CREATE button. Hit OK when asked to restage the application.

Next click on the Single Sign On service which will bring up its configuration page.
Enter the Display Name (the name users will see when prompted for access), and the Redirect URI. This must be the URL to the callback method in the Sinatra deployed application. For example if in the manifest.yml file you set the "host" to my-sso-sample then the call back URL will be https://my-sso-sample.mybluemix.net/auth/oauth2/callback


Click Save, and next you will be given the applications Client Identifier and Client Secret. Copy these some where save since you will need them to configure the application environment variables.






## Configure the Application Credentials
Next we will configure the application environment variables which the application will used to access the Client Identifier and Client Secret.

    $ cf set-env my-sso--sample  CLIENT_ID wJytqIdZ61XXXXXXX
    $ cf set-env my-sso--sample  CLIENT_SECRET 3Bhr2spmXXXXXXXXXX
    $ cf restage my-sso-sample


Once the application is restages you should be able to run the application by hitting its https URL (e.g. https://my-sso-sample.mybluemix.net)



## External Documentation

* [Getting started with Single Sign On](https://www.ng.bluemix.net/docs/#services/SingleSignOn/index.html#sso_gettingstarted)
* [OAuth2 Gem](https://github.com/intridea/oauth2)
