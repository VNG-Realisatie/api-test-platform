# API of the API Test platform

In this section the following will be explained:
1. Overview of API Test platform API
2. Creating API tokens
3. Consumer sessions using the API
4. Provider tests using the API
5. The openAPIinspector

## Overview of API Test platform API

The API Test platform provides an API of its own, which can be used to integrate its functionalities into your own pipeline. This tutorial will explain how to use this API with examples using Postman (of which the official tutorial can be found [here](https://learning.getpostman.com/docs/postman/launching_postman/installation_and_updates/)).

The API offers roughly three functionalities:
- The managing of consumer sessions (and the ability to retrieve the results)
- The managing of provider test runs (and the ability to retrieve the results)
- The openAPIinspector

## Creating API tokens

In order to access the API, an API token is required. This token can be generated using the token manager, accessible with the link on the left hand side of the home screen of the API test platform, under `API Token manager`

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/token_manager.png)

On this page you can generate one or more API tokens, by entering a unique token name, and clicking `Generate new API token`:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/token_generated.png)

Once the token is generated, the value under `Key` is needed to access the API. If we open Postman, we can now make a request to the API endpoint of the test platform by adding an Authorization header which contains `Token <token>`, where `<token>` is the key generated using the API token manager.

## Consumer sessions using the API

In the same fashion as shown above, we can make a request to show the session types using the API, by making a request to the `sessiontypes` endpoint:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_sessions_list.png)

We can then start a consumer session by choosing one of the session types and making a POST request to the `testsessions` endpoint, for this example we will use `Demo API test (Docker)`:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_create_session.png)

Once the session is successfully started, information such as the `id` of the session, the set of `exposed_url`s and the `uuid` of the session will be returned. The `id` and `uuid` are needed to retrieve the session result and badge. As explained in the Consumer session tutorial, you can now make requests to the exposed urls.

If you want to stop the session, you can send a GET request to the `testsessions/<id>/stop` endpoint:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_stop_session.png)

Once the session is stopped, you can retrieve the test results with the `testsessions/<id>/result` endpoint:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_session_result.png)

Additionally you can retrieve the badge information with the `testsession-run-shield/<uuid>` 

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_session_shield.png)

## Provider tests using the API

To start a provider test using the API, we make a post request to the `provider-run` endpoint, specifying the name of the test scenario and the values of the variables for the test scenario:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_provider_create.png)

Similar to the session data, an `id` and `uuid` are returned, which can be used to retrieve the results and badge information of the provider run.

For the results, we make a request to `provider-run/<id>/result`:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_provider_result.png)


For the badge information, we make a request to `provider-run-shield/<uuid>`:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_provider_shield.png)

## The openAPIinspector

The API also provides the `openAPIinspector` endpoint, to which you can make POST requests. A url has to be specified in the request body, which should point to an openAPI specification, and the API will validate whether the specification is conforms to OAS3.

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/openAPIinspector.png)