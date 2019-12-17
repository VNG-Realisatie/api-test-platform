# TUTORIAL PROVIDER TEST

In this section we focus on how to:
1. Provider test overview
2. Configure and start a test
3. Analyze the results
4. Using the badges 
5. Export the results

## Provider test overview

A provider test allows providers to validate that their APIs are built according to a standard. This is done using a Postman collection that fires requests to the URL(s) of the API(s) that have to be tested.

## Select an API to test
In the menu on the right, a list is displayed of the APIs that can be tested on the API Test Platform. Select the API that you wish to test and click on `Provider`. For this tutorial, we will use the API of the ATP itself.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_screen.png)

The next page shows a list of the existing environments for test scenarios for the selected API. Because we want to create a new environment, we click on the `Create environment` button in the top right corner of the page.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/environments.png)


## Configure and start a test
In order to start a test it is necessary to tune some details. First we have to select the test scenario that we want to use:
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_form.png)    
Here the type of provider test that must be run is selected, for this tutorial, we will select the `Demo API test` provider test.

In the next step we can enter a name for the environment
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/create_environment.png) 

In the next page
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_endpoints.png)  
the endpoints of the provider must be specified. In the case of the Demo API, this is only a single URL. Also, according to the authentication type of the test, it might be possible that *client id* and *secret* are required in order to build a *jwt token*. This is not necessary for the Demo API.

## Analyze the results
Once we have created our environment, we will be taken to the page that shows all of the testruns for our environment, which is currently just a single run. At the top it shows the API that was tested, the test scenario that was used and the name of the environment, as well as the badge with the latest result of this environment.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/environment_page.png)

The returned page after having fired the tests will be a list of all the tests, their status and the badges generated for them.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_list.png)

You can click to the ID column link to get the data relative to the last test. Once the tests are performed (it can take a while according to the size of the tests), the results are displayed in the detail page.

In the first part of page all the information relative to the selected provider test are shown, as well as links to the detailed HTML and JSON logs provided by Newman.

On the right hand side, the markdown and HTML snippets can be copied to display the badge on GitHub for example.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_summary.png) 

Below the provider test details, an overview of the Postman test results is displayed.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_calls_summary.png) 

Scrolling further down, a more detailed overview of the Postman collections is displayed, showing the results of each call and testscript.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_results.png)

## Using the badges
In the detail page, both HTML snippet and the code for the raw.githubusercontent markdown are available. In order to have you own badge, just copy and paste the code on your website or in you repository.

## Export the results
The results are available for download in the log section of the detail page.
