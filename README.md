# API Test Platform

[![Build Status](https://jenkins.nlx.io/job/gemma-zaken-build-and-test/badge/icon?style=plastic)](https://jenkins.nlx.io/) ![Repo Status](https://img.shields.io/badge/status-concept-lightgrey.svg?style=plastic)

## Visie 
 
Om de doelen van de Common Ground te bereiken hebben we een testvoorziening nodig die je kunt aanroepen om zowel client- als provider-api's te kunnen testen, met de mogelijkheid deze te integreren in eigen automatische software tests (continuous integration). Daarbij spelen de volgende punten een belangrijke rol:
* De tests moeten worden getriggerd met de aanroep van een API, niet vanuit een grafische user interface.
* Een grafische user interface is alleen nodig voor het tonen van overzichten met resultaten en eventueel voor het instellen van wat autorisaties - wie kan beschikken over welke testresultaten.
* De tests moeten zowel consumers als providers kunnen testen en valideren met realistische scenario's.
* Het zou mooi zijn als de valideren test op twee manieren kan worden ingezet: 
   1. voor eigen gebruik tijdens softwareontwikkeling, dan geeft het feedback over wat goed gaat en wat niet  
   2. voor het valideren van een consumer of provider, om een stempeltje “compliant met de standaard” te verkrijgen.
* Idealiter kunnen gemeenten dezelfde constructie gebruiken om een implementatie van door leverancier ingezette software te testen tegen het testplatform.
* Wat extraatjes zoals ‘badges’ waarmee je resultaat validatie voor een bepaalde build/versie kunt tonen zou mooi zijn.
* De testvoorziening moet aanroepbaar zijn als API
* Het opstarten van tests en ophalen van resultaten loopt via REST/JSON calls 
* Integratie met een eigen CI/CD pipeline is mogelijk, voorbeeld voor het doen van regressietesten

## Doel
Deze repository bevat alles wat nodig is voor de ontwikkeling van een nieuw API-testplatform

## Vragen en bijdragen
Lees meer over hoe je vragen kunt stellen, bugs kunt melden en bij kunt dragen (met code of documentatie) in [`CONTRIBUTING.md`](CONTRIBUTING.md) (EN).

## Aan de slag met de testvoorziening voor API Lab
Ga naar de folder [api-lab](https://github.com/VNG-Realisatie/api-testvoorziening/tree/master/doc/api_lab) voor het downloaden van de tutorial en de bijbehorende Postman collecties.

## Documentatie
First, in order to use the API Test Platform you need to create a user, you can easily follow the tutorial [here](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/tutorials/USER.md).
Then, you can test both provider and consumer following the steps depicted in these guides:
1. [Consumer sessioin](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/tutorials/CONSUMER_SESSION.md)
2. [Provider test](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/tutorials/PROVIDER_TEST.md)

Regarding the API endpoints, you can analyze the swagger generated schema [here](https://vng-staging.maykin.nl/api/v1/schema) or directly the OpenApi yaml [file](https://github.com/VNG-Realisatie/api-testvoorziening/blob/master/api-specificatie/openapi.yaml). 


## Sofware
The code of this project can be found [here](https://github.com/VNG-Realisatie/api-testvoorziening-code).


## Rollen

- Opdrachtgever: [@TheoVNGPeters](https://github.com/TheoVNGPeters)
- Delivery manager: [@wishalg](https://github.com/wishalg)
- Product Owner: [@HenriKorver](https://github.com/HenriKorver)
- Scrum Master:  [@JanWillemKooi](https://github.com/JanWillemKooi)

## Snelle links

## Licentie
Copyright © VNG Realisatie 2018

[Licensed under the EUPL](LICENCE.md)
