---
layout: single
title: Moderne web udvikling - del 1
date: '2013-10-02 17:23:33'
categories: [webDevelopment,angularjs,javascript,node.js,mongodb,nosql]
---
Oprindeligt blev Javascript designet som en klient teknologi til brug i internet browsere. Vi har de senere år set en trend med at Javascript er blevet brugt mere og mere til flere og større projekter ikke bare på klientsiden men også på serverdelen  

<!--more-->

Dette var ikke udgangspunktet for Javascript som programmeringssprog, hvorfor det giver nogle udfordringer med blandt andet at organisere ens kodebase så man ikke ender med en omgang spagetti kode. 

Klient frameworks som [Angular](http://angularjs.org/) og [Ember](http://emberjs.com/) har set dagens lys og åbnet muligheder for bedre organisering af Javascript kode efter MVC design pattern. 

Samtidig ser vi eksempler på programmeringssprog som [Typescript](http://www.typescriptlang.org/) og [Coffeescript](http://coffeescript.org/) som giver nye muligheder for højere abstraktion i Javascript med indførelse af OO koncepter som klasser. Typescript giver også mulighed for indkapsling, nedarvning, moduler og interfaces og Javascript er en ægte delmængde af Typescript. Coffeescript har måske knapt så mange avancerede features men til gengæld en længere historik. Seneste version af Typescript har nu også generics som jo oprindeligt er inspireret af funktionelle programmeringssprog.

## Server

For at kunne afvikle Javascript uden for en internet browser har man i sagens natur brug for en platform som ikke er internet baseret. Node.js er en serverbaseret platform designet som en eventbaseret ikke-blokerende I/O model uafhængig af webbrowsere. Node.js blev introduceret af Ryan Dahl i 2009, og overordnet kan Node.js beskrives som:

> libuv + V8 + core library (JS/C++) = Node.js

hvor

- libuv - oprindeligt var Node.js ikke tilgængelig på Microsoft platformen fordi man brugte frameworket libev til at abstrahere [IOCP](http://en.wikipedia.org/wiki/Input/output_completion_port). Libuv erstattede senere libev og findes til flere platforme.
- V8 - Chromes built-in JavaScript engine.
- core library

Udover Node.js bruger jeg følgende moduler:

- [express](http://expressjs.com/). Express er et webudviklings framework bygget på node.js og Connect med inspiration hentet fra Sinatra.  Hvis du er teknisk begrænset til Microsoft platforment så er det måske værd at kigge nærmere på [NancyFX](http://nancyfx.org/) som er et lignende letvægts web framework til .NET. 
- [Connect](http://www.senchalabs.org/connect/) er et middleware framework med support for fx logging, cookies og sessions.
- [mongojs](https://github.com/gett/mongojs). MongoDB driver til Node.js
- [mongodepository](https://github.com/iainjmitchell/mongorepositiory). Brug af repository design pattern for database tilgang. Se mere nedenfor.
- [jasmine-node](https://github.com/mhevery/jasmine-node). En Node.js version af test frameworket jasmine til brug for test af asynkrone kald.

## Database

Data gemmes i den populære noSql database [MongoDB](http://www.mongodb.org/). Der findes en række forskellige MongoDB klienter hvoraf [Robomongo](http://robomongo.org) virker intuitiv og nem at komme i gang med.

Mongodb startes fra kommandolinien med ``mongod``. Der er også en kommandolinie klient ``mongo``. Herfra kan man vise de citater som findes i database:

{% highlight javascript %}
use quotes
show collections
db.find.quotes()
{% endhighlight %}

Endelig findes der 2 programmer til hhv at importere og eksportere data. Dette kan gøres på følgende måde:

    mongoexport -d quotes -c quotes -o quotes.json
    mongoimport -d quotes -c quotes --file quotes.json

### Design patterns
Det er næsten altid en god ide at sørge for et rent snit mellem forretningslogik og domæne klasser på den ene side og selve database tilgangen på den anden side. Et anerkendt pattern til den problemstilling er data mapper beskrevet i [1].

I midten af 1990'erne var der en vis tiltro til at objekt orienterede databaser ville være fremtiden. Det var de så ikke og RDBMS tog i mange år helt over. I en årrække var der derfor en del som havde svært ved at se det fornuftige i en skarp separation mellem forretningslogik og database tilgang. Nu ser billedet anderledes ud efter den populære fremgang for noSQL databaser. Hvis man udover at have bruge for at hente enkelte domæneklasser (læs rækker i SQL databaser) kan det give god mening også at bruge repository design pattern så et abstraktionslag mellem forretningslogikken og databaselogikken. Et repository pattern giver mulighed for at implementere SQL lignende forespørgsler for ens domæneklasser. Dette virker som en rigtig god ide for et REST API hvor man tilgår fx alle bøger, ordre eller noget helt tredje.

Man kan derudover udvide med unit of work pattern til at holde styr på hvilke domæneklasser som er ændret og som skal gemmes. I følge [1] er beskrivelsen af unit of work:

>  Maintains a list of objects affected by a business transaction and coordinates the writing out of changes and the resolution of concurrency problems.

Det er ikke klart for mig om unit of work giver mening sammen med noSQL databasen MongoDB som jo ikke er transaktionsbaseret. Hvis du ved noget om dette emne, så vil jeg mere gerne høre nærmere. 

## Klient

Indtil videre er projektet alene et REST lignende API. På et senere tidspunkt bygger jeg en webbaseret klient. Der er flere valgmuligheder som fx Angular og Ember som begge er MVC baserede klient frameworks.

## Andre værktøjer
Udover et ønske om at lære om moderne web udvikling vil jeg også forsøge at bruge andre værktøjer end Visual Studio. Indtil videre bruger jeg Sublime Text som editor, WebStorm som IDE og curl til kommandolinie test af web API'et

## Source kode

Source koden findes på GitHub. Jeg skal gøre opmærksom på, at koden ikke er velegnet til produktion. Projektet her er tænkt som learning by doing, og koden skal derfor ikke opfattes som best practice eller helt færdig. Hent projektet [her](https://github.com/carsten-j/QuoteApp)

## 
Senere indlæg i denne serie vil fokusere mere på unit test, authentication, cookies, sessions og kontinuert cloud deployment. 
Jeg tænker også at undersøge muligheden for at bruge message queue sammen med Node. Dart og LiveScript er også potentielle emner. Når jeg er igennem ovenstående emner, så vil jeg tage et kig på [Mean](http://www.mean.io/) som er en standard pakke indeholdede til at udvikle JavaScript baserede web applikationer baseret på Mongo, Express, Angular og Node.

## Litteratur og links
Der findes flere bøger om Node.js. Jeg har været godt tilfreds med [Node.js in Action](http://www.amazon.com/dp/1617290572).

Man kan finde masser af information om Node.js på internettet. Her er et kort udvalg af links som jeg har fundet inspiration fra til dette blog indlæg.

Disse to klassiske bøger indeholder flere information of data mapper, repository og unit of work patterns.

[1] http://www.amazon.com/dp/0321127420

[2] http://www.amazon.com/dp/0321125215

Asynkron unit test

[3] http://thewayofcode.wordpress.com/2013/04/21/how-to-build-and-test-rest-api-with-nodejs-express-mocha/

REST API i Node

[4] http://blog.modulus.io/nodejs-and-express-create-rest-api

Hvorfor overhovedet bruge Node

[5] http://www.toptal.com/nodejs/why-the-hell-would-i-use-node-js 