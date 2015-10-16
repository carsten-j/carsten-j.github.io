---
layout: post
title: Moderne web udvikling - del 2
date: '2013-10-06 18:03:33'
categories: [redis,webDevelopment,angularjs,javascript,node.js,mongodb,nosql]
---
Jeg fortsætter min opdagelsesrejse udi web udvikling og kigger denne gang på et par nyttige node værktøjer samt session management.

<!--more-->

## Værktøjer

WebStorm er et JavaScript IDE fra [JetBrains](http://www.jetbrains.com/webstorm/) som du sikkert allerede kender fra ReSharper (hvis du altså som undertegnede er .NET udvikler). WebStorm gør det blandt andet nemt at debugge Node programmer. Hvis man ønsker udelukkende at bruge open source værktøjer til Node udvikling så kan man naturligvis bruge en vilkårlig editor til at skrive kode i. Men hvad så med debugging? Løsningen er [node-inspector](https://github.com/node-inspector/node-inspector), som gør det muligt at debugge Node via Chrome.

Man starter en Node applikation fra kommandolinien med 

> node myApp.js

Hvis man alternativt bruger

> nodemon myApp.js

Så vil `nodemon` genstarte ens node server hvis man gemmer ændringer til ens sourcefiler. `nodemon` kan installeres på sædvanligvis med `npm`

I et produktionsmiljø er kravene nok anderledes. Man vil muligvis gerne genstarte ens server når source filer bliver opdateret, men derudover ønsker man måske også at genstarte serveren automatisk hvis den går ned. I sådanne situationer er det værd at kigge nærmere på de muligheder som kommandolinieværktøjet [pm2](https://github.com/Unitech/pm2)

> nodefly

## Sessions

Express har indbygget understøttelse for sessions via et simpelt JavaScript objekt `MemoryStore` som holdes i hukommelsen så længe serveren kører. Hvis serveren går ned mister man alle session informationer fra alle klienter.  Hvis den løsning er for skrøbelig bør man overveje at gemme sessions i en database. Et alternativ er at bruge noSQL databasen [Redis](http://redis.io/)  (REmote DIctionary Server) til at gemme sessions.  Blandt de ikke funktionelle krav der stilles til håndtering af sessions er, at det skal være hurtigt at læse og skrive data. Redis er udover at være en key-value database og kendt for at være meget hurtig. Som udgangspunkt holdes databasen i RAM men den kan også persisteres. Hvis man konfigurer Express til at bruge Redis som session store, så sørger Express for at data persisteres.

På Mac kan Redis installeres med [Homebrew](http://brew.sh/)  

> brew install redis

Redis startes fra kommandolinien med 

> redis-server /path/to/redis.conf

Hvis man ikke angiver en konfigurationsfil starter redis med en standardopsætning. Redis kommer også med en kommandolinie klient `redis-cli`. Indtil videre har jeg kun fundet en enkelt GUI klient [redsmin](https://redsmin.com/),  men den er stadig i betaversion og ikke offentlig tilgængelig.    

Bogen [Seven Databases in Seven Weeks](http://www.amazon.com/dp/1934356921) har en kort og præcis beskrivelse af redis og den kan varmt anbefales. For flere detaljer henvises til [Redis in Action](http://www.amazon.com/dp/1617290858).

I del 1 af serien om moderne web udvikling brugte vi MongoDB som database. Og nu tilføjer vi Redis til brug for session management. Giver det mening at bruge flere forskellige databaser i samme applikation? 

![center](/images/multipleDBs.jpg)

Det korte svar er *ja*. Det lidt længere er at der naturligvis både er fordele og ulemper. Hvis man bruger flere forskellige databaser, så er der flere api'er at lære, man skal kunne modellere data på flere måder og der er flere databaser at administrere. Omvendt kan man vælge den database som har styrker indenfor konkrete problemstillinger istedet for at presse samme database ned over alle forhold.

Det giver især god mening med flere forskellige databaser hvis det sker i sammenhæng med ændret strategi for integration af applikationer.

Der findes masser af eksempler på integration mellem forskellige applikationer ved at de deler samme database. Hvis man nu istedet integrerer via *HTTP* så kan hver enkelt applikation vælge den eller de databaser som passer til netop det domæne applikationen dækker over.

Jeg er på ingen måde den første som taler om dette. Martin Fowler har flere artikler om emnet [1] og [2]. 

[1] http://www.martinfowler.com/bliki/PolyglotPersistence.html

[2] http://www.martinfowler.com/bliki/DatabaseThaw.html
