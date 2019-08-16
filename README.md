# API Test Platform

[![Build Status](https://jenkins.nlx.io/job/gemma-zaken-build-and-test/badge/icon?style=plastic)](https://jenkins.nlx.io/) ![Repo Status](https://img.shields.io/badge/status-concept-lightgrey.svg?style=plastic)

## Introduction 

To reach the goals of the [Common Ground](https://commonground.nl) for Dutch municipalities a platform to test their API's is being developed. These are the main features of the [API Test Platform](https://api-test.nl):

* Functionality for testing both consumers as providers of the API's.
* Sandbox to play with API's.
* Facilities for demonstrating compliancy such as test reports and badges.
* Scheduler for monitoring API's.
* [API](https://api-test.nl/api/v1/schema) for integration with your own CI/CD pipeline.

## Documentation
First, in order to use the API Test Platform you need to create a user, you can easily follow the tutorial [here](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/tutorials/USER.md).
Then, you can test both provider and consumer following the steps depicted in these guides:

0. [Register](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/tutorials/USER.md)
1. [Consumer session](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/tutorials/CONSUMER_SESSION.md)
2. [Provider test](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/tutorials/PROVIDER_TEST.md)
3. [API](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/tutorials/API.md)

Regarding the API endpoints, you can analyze the swagger generated schema [here](https://vng-staging.maykin.nl/api/v1/schema) or directly the OpenApi yaml [file](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/api-specificatie/openapi.yaml). 


## Software
The code of this project can be found [here](https://github.com/VNG-Realisatie/api-testvoorziening-code).


## Roles

- Client: [@TheoVNGPeters](https://github.com/TheoVNGPeters)
- Delivery manager: [@wishalg](https://github.com/wishalg)
- Product owner: [@HenriKorver](https://github.com/HenriKorver)
- Scrum master:  [@JanWillemKooi](https://github.com/JanWillemKooi)

## License
Copyright © VNG Realisatie

[Licensed under the EUPL](LICENCE.md)
