---
layout: post
title: Præ Warm Crocodile Developer Conference 2014
date: '2014-01-14 21:08:28'
categories: [wcdc2014, visualStudio, fsharp]
---
Kort efter opstartsmødet i meetup gruppen [F#unktionelle Københavnere]({% post_url 2013-11-20-hvilke-virksomheder-i-koebenhavn-bruger-funktionelle-sprog %}) blev der taget initiativ til at få Tomas Petricek til at holde et oplæg på gruppens andet møde, som skulle holdes dagen før WCDC 2014. Da Petricek alligevel var i København i forbindelsen med konferencen synes det oplagt at få ham til at tale i gruppen F#unktionelle Københavnere. Jeg kender ikke detaljerne, men arrangementet blev ændret og udvidet. Vistnok med Microsoft som sponsor, og det blev så til denne prækonference med tilføjelse af flere andre indlæg. 

<!--more-->

Der var tre talere til dagens prækonference, og programmet så sådan ud:

* Visual Studio 2013, Luke Hoban, Microsoft 
* From domain model to user interface, Tomas Petricek, PhD studerende, University of Cambridge 
* ASP.NET MVC & WebAPI alongside AngularJS, Scott Allen, CTO Medisolv 

Efter hvert indlæg var der et evalueringssystem, som jeg dog aldrig nåede at få styr på. Udenfor lokalet stod en kasse hvori man kunne lægge enten en grøn, en gul eller en rød seddel. Mit gæt er, at grøn betød 'ok', gul noget i stil med 'godkendt' og rød at der er plads til forbedring. Det er i hvert fald den betydning jeg lægger til grund for evalueringen her i indlægget.

### Visual Studio 2013, Luke Hoban, Microsoft
Første indlæg var om Visual Studio 2013 og en gennemgang af nye features. Vi oplever en generel trend i softwareudvikling, hvor man er på vej bort fra det traditionelle klient-server paradigme til en verden, hvor der mere er fokus på devices (smartphone, tablets, mobile apps) og services.  Denne trend ses nu også i VS2013, hvor den velkendte klient samt TFS udvides med en række cloudbaserede services som fx "Monoco", der er en letvægts cloudbaseret editor som dog ikke er tænkt som en afløser for desktop IDE, men mere som et supplement. En anden service er analyseværktøjet Online Application Insights som blandt andet kan bruges til performancemålinger af ens programmer.

Et stor del af indlægget opfattede jeg mere som en salgstale end et decideret fagligt indlæg. Det er dog positivt at se, at Microsoft i langt højere grad end tidligere både anerkender og indarbejder understøttelse for andre teknologier og værktøjer i Visual Studio end Microsoft's egne. Her kan man fx nævne type definitions til TypeScript som muliggør intellisense for tredjeparts JavaScript bibliotekter i Visual Studio og [Node.js Tools for Visual Studio](https://nodejstools.codeplex.com/).

### From domain model to user interface, Tomas Petricek, PhD studerende, University of Cambridge

Petricek starter med at spørge, hvor mange af deltagerne som enten kender F# og/eller har programmeret F#. Overraskende mange tilkendegav, at de både kender sproget og har brugt det. På opstartsmødet for F#unktionelle Københavnere tilbage i november 2013 fik jeg det modsatte indtryk (og indtil videre har jeg uden det store held [efterlyst virksomheder i Københavnerområdet]({% post_url 2013-11-20-hvilke-virksomheder-i-koebenhavn-bruger-funktionelle-sprog %}) som udvikler i funktionelle sprog.)

Vi vil vel allesammen gerne kunne udvikle software hurtigt, agilt og uden fejl. Petricek demonstrede, hvordan man i F# nemt kommer fra en prototype af ens domæne model til faktisk software. I Visual Studio findes en interaktiv afvikling af F#, som gør det nemt at prøve koden af mens man udvikler. Som eksempel byggede Petricek en domæne model omkring et kasseapparat. Modellen understøttede tilføjelse af varer, annulering af tilføjede varer samt en aggregeret opgørelse over varerne i ens indkøbskurv. Ideen er uden tvivl god, men jeg føler mig ikke overbevist om at eksemplet er kompliceret nok til, at man herfra kna konkludere at denne tilgang til softwareudvikling kan skalere til større projekter med mere komplicerede domæne modeller og et større antal projektdeltagere.

Som en del af domæne modellen blev der brugt F# featuren [Discriminated Unions](http://msdn.microsoft.com/en-us/library/dd233226.aspx) - DU. 

Discriminated Unions er en slags "sum" type, hvorved man kan definere typer som er en type udaf flere muligheder. Lad os se på et eksempel, hvor vi har brug for en type, der enten repræsenterer en bil eller en cykel. Hvis disse to typer er defineret ved deres respektive record typer:

```fsharp
type Car = {brand:string; model:string}  // record type 
type Bike = {brand:string; model:string}  // yet a record type 
```

Så kan vi nu definere 

```fsharp
type CarOrBike = 
  | C of Car
  | B of Bike
```
  
Her er værdier 'C' og 'B' tilfældige mærkater. 

DU var velkendt for undertegnede. Petricek kom med den interessante observation, at man kan tænke på Discriminated Unions som et simpelt (objekt-orienteret) klassehieraki, __HVOR__ forskellen er, at hvis man modellerer `CarOrBike` som et klassehieraki, så får man en model, hvor det er let at tilføje nye typer, men svært at tilføje nye metoder/funktioner. Hvis man derimod modellerer med DU, har man den præcis omvendte situation. Her er det let at tilføje nye funktioner men svært at tilføje nye typer (læs cases).

Den opmærksomme læser vil her komme til at tanke på design mønstret Visitor som netop er motiveret af muligheden for nemt at tilføje nye funktionalitet til et klassehieraki uden at ændre strukturen i hierakiet. 

Spørgsmålet er nu om Visitor er det tætteste man kommer på simulere DU i et objekt-orienteret sprog? Skriv en kommentar, hvis du har et bud på svaret.

![center](/images/petricek2.jpg)

Asynkron programmering med det nye `async` keyword var en del af F# før det blev tilgængelig i C# 5.0. Petricek udviklede en applikation ovenpå domæne modellen og vidste, hvordan man får en mere responsiv brugeroplevelse ved at bruge asynkrone kald fx i forbindelse med webservicekald. I den forbindelse fik vi uden tvivl dagens bedste citat:

>	async propagates like a virus but that is good when you change something that is blocking to nonblocking you actually need to do it everywhere otherwise there is no point. 

Hvis du ikke allerede har læst Petriceks bog [Real-World Functional Programming Book](http://functional-programming.net/) så er den yderst anbefalelsesværdig.

### ASP.NET MVC & WebAPI alongside AngularJS, Scott Allen, CTO Medisolv

Enten havde Scott Allen misforstået konferenceoplægget, eller også var han blevet fejlinformeret. I hvert fald havde Allen haft den opfattelse, at han her på prækonferencen havde op mod 8 timer og ikke den ene time, som han faktisk var tildelt. Og det er svært at skære ned på materiale fra 8 til 1 time, hvilket foredraget derfor også kom til at bære præg af.

Det blev aldrig klart for mig, hvad det præcise formål og pointe var med dette foredrag. Scott Allen viste os nogle nye MVC5 features samt kom med en kort introduktion til brugen af AngularJS sammen med ASP.NET WebAPI. For den nye MVC template i VS2013 er Bootstrap nu default. Brugen af Bootstrap og integration med Angular viser som nævnt tidligere, at Microsoft åbner mere om mere op for andre teknologier, hvilket jeg ser som en meget positiv vinkel.

Det mest interessant emne var helt klart omtalen af OWIN og Katana. Jeg fik det indtryk, at OWIN/Katana var en slags middleware lidt i stil med [Connect](http://www.senchalabs.org/connect/) til Node.js. 

Gennemgangen virkede temmelig rodet, og hvis jeg ikke selv tidligere her på bloggen havde skrevet [et indlæg]({% post_url 2013-10-31-moderne-web-udvikling-del-4 %}) om Angular, så tror jeg ikke, at jeg havde fået noget som helst ud af dette indlæg.

### Geekbeer på Nørrebro Bryghus
Det slår aldrig fejl med en god øl i godt selskab. Jeg smagte Lille Hop og Lazy Monday. Begge øl i pale ale typen. Lille Hop var i den lettere ende med en frisk citrussmag mens Lazy Monday havde noget mere fylde og bitterhed. Tak til [Steen Thrane](http://www.linkedin.com/in/steentj), [Michael Lund](https://twitter.com/iCodeIT_dk) og [Jakob Lindekilde](http://www.linkedin.com/in/jakoblindekilde) for godt selskab.
