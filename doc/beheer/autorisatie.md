# Beheren van autorisaties in de admin

Via de adminpagina van het API Test platform kunnen gebruikers autorisaties krijgen om bepaalde acties (bijv. het aanmaken van een test scenario) te verrichten voor specifieke API's via het web interface. In deze tutorial zal worden uitgelegd hoe deze autorisaties verstrekt kunnen worden aan gebruikers.

## Group aanmaken
Bij het betreden van de admin op https://api-test.nl/admin is de volgende pagina te zien. Om te beginnen zullen we een nieuwe `Group` aanmaken, dit kan door te klikken op `Groups` onder het tabje `Authenticatie`:
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/admin.png)

Op de groups pagina kunnen we een nieuwe groep toevoegen door te klikken op `Add group` rechtsbovenin:
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/admin_groups.png)

Hier kan een naam opgegeven worden voor de groep, en kan de groep aangemaakt worden door op `Save` te drukken. De permissies
hoeven nog niet geselecteerd te worden.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/create_group.png)

## Permissies instellen voor group
Vervolgens gaan we terug naar het admin dashboard, scrollen we naar het kopje `Miscellaneous` en klikken we op `Apis`
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/admin2.png)

Hier kunnen we de lijst zien van alle API's die ondersteund worden door het API Test Platform en kunnen we de API kiezen
waarvoor we rechten willen verstrekken. Voor deze tutorial gaan we een groep rechten geven voor de ATP API.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_admin.png)

Op de detail pagina van de gekozen API klikken we op de knop `Object permissions` rechtsbovenin
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/api_detail.png)

Op de object permissions pagina voeren we de naam van onze aangemaakte groep in bij `Group`, en klikken we op `Manage group`
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/object_perms1.png)

Op deze pagina kunnen de permissies voor de beheerders groep voor de ATP API (in dit geval) ingesteld worden,
als voorbeeld kiezen we hier alleen de permissie om bestaande environments aan te passen en klikken we vervolgens op save.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/object_perms2.png)

## Users toevoegen aan group

Als we weer teruggaan naar het admin dashboard en klikken op Authenticatie > Users, zien de we lijst met alle
bestaande gebruikers op het ATP. Kies hieruit de gebruikers die in de zojuist aangemaakte groep moeten komen. Klik op
een van de gebruikers en scroll naar het kopje `Permissions`. Selecteer onder `Available groups` de aangemaakte groep en klik
vervolgens op save.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/add_to_group.png)

## Permissies gebruiken op web interface
In deze tutorial hebben we een gebruiken permissie gegeven om bestaande provider test environments aan te passen
via het web interface. Als de gebruiker nu naar de provider tests van het ATP gaat en een environment aanklikt
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/env_list.png)

Dan is de `Modify environment` knop zichtbaar en kan de gebruiker de environment variabelen aanpassen, zonder dat deze
gebruiker toegang heeft tot het admin interface.
![](https://raw.githubusercontent.com/VNG-Realisatie/api-testvoorziening/master/tutorials/images/modify_env.png)