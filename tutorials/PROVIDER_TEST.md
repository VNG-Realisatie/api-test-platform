# TUTORIAL PROVIDER TEST

In this section we focus on how to:
1. Configure and start a test
2. Analyze the results
3. Using the badges 
4. Export the results

## Configure and start a test
In order to start a test it is necessary to tune some details. Clicking on the **Start testrun** button, a form is displayed.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_form.png)    
The first field regards the type of the test to run. As for the consumer session, clicking through the names a brief introduction, it is possible to see a brief introduction of the test type. Next, even if not required, the supplier name, software product and product role can be provided.   
Finally, the schedule checkbox triggers an automatic test with the same configuration every day at 00:00. In this case the results are also sent via email and are available in the specific tab **Schedule tests**. Except this difference the following procedure are exactly the same in both cases.  
In the next page
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_endpoints.png)  
a list of endpoints are required. Also, according to the authentication type of the test, it might be possible that *client id* and *secret* are required in order to build a *jwt token*.

## Analyze the results
Once the tests are performed (it can take a while according to the size of the tests), the results are displayed in the detail page.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_results.png) 
In the first part of page all the information relative to the tests are shown.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_summary.png) 
It is also possible to see a generated HTML log that slightly differs from the detail page. Furthermore, a json and a PDF log is available to download (bear in mind that generate the PDF for quite long collection can take time).  
A brief summary that conveys the number of failed/successful call is firstly shown.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/providers_calls_summart.png) 
Scrolling down, it is possible to analyze one by one each call, see its result code and eventually its tests.


## Using the badges
In the detail page, both HTML snippet and the code for the raw.githubusercontent markdown are available. IN order to have you own badge, just copy and paste the code on your website or in you repository.

## Export the results
The results are available to the download in the log section of the detail page.
