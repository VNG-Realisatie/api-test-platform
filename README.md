# API-testplatform

[![Build Status](https://jenkins.nlx.io/job/gemma-zaken-build-and-test/badge/icon?style=plastic)](https://jenkins.nlx.io/) ![Repo Status](https://img.shields.io/badge/status-concept-lightgrey.svg?style=plastic)

[![Status badge](https://img.shields.io/endpoint.svg?style=for-the-badge&amp;url=https://vng-staging.maykin.nl/api/v1/provider-run-shield/100/)](https://vng-staging.maykin.nl/server/a1660a86-3312-48f6-8106-4fa9dec1e8f7)

[![Status badge](https://img.shields.io/endpoint.svg?style=for-the-badge&amp;url=https://vng-staging.maykin.nl/api/v1/provider-run-shield/134/)](https://vng-staging.maykin.nl/server/ed749136-cc93-4169-9fc2-3482871966e9)

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

## Rollen

- Opdrachtgever: [@TheoVNGPeters](https://github.com/TheoVNGPeters)
- Delivery manager: [@wishalg](https://github.com/wishalg)
- Product Owner: [@HenriKorver](https://github.com/HenriKorver)
- Scrum Master:  [@JanWillemKooi](https://github.com/JanWillemKooi)

## Snelle links

## Licentie
Copyright © VNG Realisatie 2018

[Licensed under the EUPL](LICENCE.md)
