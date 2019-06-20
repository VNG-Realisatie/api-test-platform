# TUTORIAL CONSUMER SESSION

In this section we focus on how to:
1. Start a session
2. Use its API
3. Check the calls
4. Run the tests

## Start a session
To start a session click on **Start sessie** in the left hand side bar. 
A list of all the possible session is presented, clicking on the name of a session type, a brief description of it is displayed.  
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/start_testrun.png)   
The functionality of the checkbox **sandbox** is explained below.

## Use the created API
After having created a new session, a bunch of endpoints are now available to use. They can be find on the right hand side of the detail page of the session.

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/endpoints.png) 

Every call performed to one of these endpoints is logged in the detail page.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/consumers_log.png) 

## Check the calls
Clicking of the report page, the list of all the calls that should be performed is shown. Once the url and the query parameters are strictly matched, the scenario case is registered, successfully if the result of the HTTP calls is not a error code.  
Assuming the **sandbox** option has been checked, it is possible to call several times the same url path and override the result with the last one. On the other side, if the sandbox option is off, only the first result is saved.  
It is possible to export the result clicking through the **Rapport PDF** button to download a detail PDF of the scenario cases.  
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/consumers_report.png) 

## Run the tests
If the session type is specifically configured, as soon as the session is turned off with the designated button, a postman collection is ran against the proxied endpoint.
