Verzamelde documenten ten behoeve van het beheren van het API Testplatform

# Postman collecties op het API Test Platform

Het ATP biedt de mogelijkheid om Postman collecties te uploaden, tegelijkertijd 
is het ook mogelijk om via Postman deze collecties te publiceren met documentatie op [https://getpostman.com/](https://getpostman.com/)
en om deze link ook beschikbaar te maken op het ATP. Echter, zodra er door een developer
aanpassingen worden gemaakt aan een Postman collectie, worden deze veranderingen automatisch doorgevoerd naar
de gepubliceerde collectie op [https://getpostman.com/](https://getpostman.com/). Hierdoor kunnen er synchronisatie
problemen ontstaan, omdat de collectie op het ATP niet automatisch updates ontvangt, maar handmatig geupload moet worden.

Om dit soort problemen te voorkomen, is de volgende aanpak voor het beheren
van Postman collecties gewenst. In Postman is het mogelijk om versie tags toe
te voegen aan een collectie, hiervoor moet er eerst een API gemaakt worden in Postman.
Dit kan door op het kopje `APIs` te klikken en vervolgens op `New API` te klikken zoals hieronder:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/create_postman_api.png)

Daarna kan de naam van de API veranderd worden en kunnen er nieuwe versie tags aan de API toegevoegd worden
door op `Show all versions` te klikken:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/add_version.png)

Zodra er een API is met een versie tag, kan deze tag ook toegevoegd worden aan een Postman collectie,
dit is mogelijk door terug te gaan naar het kopje `Collections`,
 op het pijltje te klikken rechts van de collectie en vervolgens `Changelog` aan te klikken:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/postman_changelog.png)

Hier is een lijst te zien met de laatste aanpassingen aan de collectie en hier is het mogelijk
om op een bepaalde aanpassing een versie tag te zetten, door op `Add version tag` te klikken:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/add_version_tag.png)

Nu is er een Postman collectie met een versie tag aangemaakt en kan deze collectie gepubliceerd worden op de Postman
website, dit kan door weer op het pijltje te klikken naast de collectie en daarna op `View in web`:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/view_web.png)

Klik daarna op de knop `Publish` rechtsbovenin:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/publish1.png)

Voeg vervolgens onder `Collection version` de versie tags toe die zijn aangemaakt:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/publish2.png)

Klik daarna op de knop `Publish Collection` onderaan de pagina:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/publish3.png)

Klik de URL aan van de gepubliceerde collectie:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/publish4.png)

Klik tot slot op `CURRENT` linksboven en selecteer de versie van de collectie die op het ATP gezet dient te worden:

![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/doc/beheer/images/publish5.png)

Zodra die versie aangeklikt is, moet de URL van de pagina gekopieerd worden en kan de collectie op het ATP geupdate worden
door de nieuwe collectie te uploaden en de documentatie die op de gekopieerde URL staat ook mee te geven.