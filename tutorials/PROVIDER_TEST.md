# TUTORIAL PROVIDER TEST

In this section we focus on how to:
1. Provider test overview
2. Configure and start a test
3. Analyze the results
4. Using the badges 
5. Export the results

## Provider test overview

A provider test allows providers to validate that their APIs are built according to a standard. This is done using a Postman collection that fires requests to the URL(s) of the API(s) that have to be tested.

## Configure and start a test
In order to start a test it is necessary to tune some details. Clicking on the **Start testrun** button, a form is displayed.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_form.png)    
Here the type of provider test that must be run is selected, for this tutorial, we will select the `Demo API test` provider test. 

Optionally, the schedule checkbox triggers an automatic test with the same configuration every day at 00:00. In this case the results are also sent via email and are available in the specific tab **Schedule tests**. Except this difference the following procedure are exactly the same in both cases.  

In the next page
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_endpoints.png)  
the endpoints of the provider must be specified. In the case of the Demo API, this is only a single URL. Also, according to the authentication type of the test, it might be possible that *client id* and *secret* are required in order to build a *jwt token*. This is not necessary for the Demo API.

## Analyze the results
The returned page after having fired the tests will be a list of all the tests, their status and the badges generated for them.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_list.png) 
You can click to the ID column link to get the data relative to the last test. Once the tests are performed (it can take a while according to the size of the tests), the results are displayed in the detail page.


In the first part of page all the information relative to the selected provider test are shown.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_summary.png) 

Below the provider test details, an overview of the Postman test results is displayed.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_calls_summary.png) 

Scrolling further down, a more detailed overview of the Postman collections is displayed, showing the results of each call and testscript.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_results.png) 

It is also possible to see a generated HTML log that slightly differs from the detail page. Furthermore, a json and a PDF log is available to download (bear in mind that generate the PDF for quite long collection can take time).

## Using the badges
In the detail page, both HTML snippet and the code for the raw.githubusercontent markdown are available. IN order to have you own badge, just copy and paste the code on your website or in you repository.

## Export the results
The results are available to the download in the log section of the detail page.
