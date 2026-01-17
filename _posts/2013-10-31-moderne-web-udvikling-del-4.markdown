---
layout: single
title: Moderne web udvikling - del 4
date: '2013-10-31 20:45:48'
categories: [webDevelopment,angular.js,yo.bower,grunt,javascript]
---
I de forrige blogindlæg har vi koncentreret os om server-delen af web udvikling. I dette indlæg kigger vi nærmere på klienten. 

<!--more-->

## Klient og AngularJS
Oprindeligt var websider meget statiske af natur og blev mest brugt til at præsentere informationer. Igennem årene har det stille og roligt ændret sig til mere og mere dynamiske sider, hvor brugerne måske ikke længere skelner mellem om de bruger en *gammeldags* desktop applikation eller en mere moderne web app som fx Google Docs eller Microsoft Office 365. Hvis en sådan oplevelse skal være succesfuld kræver det mere og mere af klienten. I 2012 slog det for alvor igennem med JavaScript klient frameworks som AngularJS, Ember.js, Backbone.js og flere lignende frameworks. Fælles for disse er organiseringen af kodebasen efter et [Model-View-Controller](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) software arkitektur design pattern. Ideen bag MVC går helt tilbage til midten af 1970'erne, hvor MVC var en del af Smalltalk. Det kunne være interessant at vide mere om hvorfor der skulle gå mere end 40 år fra introduktionen af MVC i desktop programmer til udbredelsen i webapplikationer. Sig endelig til hvis du kender mere til den historie. Hele tankegangen bag responsive web applikationer er for omfattende et emne til dette indlæg, men det er samtidig et interessant emne som meget vel kan tages op på et senere tidspunkt på denne blog.

Jeg har valgt at kigge nærmere på AngularJS. Det kunne ligeså godt have været et af de andre frameworks, men nu er valget altså faldet på Angular. Det er mit indtryk at der overordnet arkitekturmæssigt ikke er den store forskel på de 3 førnævnte frameworks.

## Resourcer
Først vil jeg nævne de to resourcer, som jeg har haft størst udbytte af vedrørende AngularJS. Nemlig standardpakken [MEAN](http://www.mean.io) og bogen [AngularJS](http://www.amazon.com/dp/1449344852). MEAN er en virkelig god måde at komme hurtigt i gang på. Istedet for at bruge tid på en masse teknisk opsætning kloner man bare fra Github og så er man i gang. Perfekt til at få et overordnet indtryk.

## Karakteristika
Jeg vil fremhæve tre områder som jeg opfatter som centrale for AngularJS: 

* kodeorganisering med moduler og MVC
* unittest og dependency injection (DI)
* To-vejs data-binding og templates
* Deklarativ programmering

### Kodeorganisering med moduler og MVC
Som jeg forstår det, har mange oplevet at JavaScript kode ender som spagetti kode. I objekt orienterede programmeringssprog har man features som namespace og klasser som kan være med til at sikre en hensigtsmæssig organisering af ens kodebase. Sådanne features findes ikke i JavaScript. I Angular er det stadigt muligt at definere globale funktioner men best practice er at definere en række moduler som samler fælles funktionalitet. Moduler kan afhænge af andre moduler, og på den måde kan man styre sin applikations afhængigheder.

Ofte ses MVC som et design pattern men i praksis kan det også opfattes/bruges som en måde at organisere ens kode på.   

### Unittest og dependency injection (DI)
AngularJS er designet med henblik for at test skal være nemt. Der findes flere værktøjer: Karma og Jasmine som understøtter denne proces som både omfatter unit tests og integrationstest.

### To-vejs data-binding
Hvis du kommer fra en .NET baggrund og har kendskab til WPF emner som XAML, dependency properties og data binding og templates så vil du opleve at mange af ideerne og begreberne fra WPF har en analogi i AngularJS. 

Det er mit indtryk at man før JavaScript MVC frameworks brugte en del energi på at manipulere DOM (fx med jQuery) for at få opdatere klienten når data blev opdateret. 

### Deklarativ programmering
Oftest kender man en deklarativ programmeringsstil fra funktions- og logikprogrammeringssprog men den deklarative stil er vej at finde fodfæste andre steder også. Tank bare på LINQ fra .NET platformen. I AngularJS har man en række direktiver som kan flettes ind i HTML koden og på den måde være med til at styre fx hvilken controller som bruges af det valgte HTML element.
 
## AngularJS set oppefra 
![center](/images/angular.jpg)

## Tools
Der findes en række værktøjer som kan hjælpe med AngularJS udvikling. Jeg vil blot nævne nogle få stykker:

* [Yo](https://github.com/yeoman/yo) - i stedet for manuelt at oprette foldere, standard source og konfigurationsfiler m.v. kan man få det hele autogenereret med Yo. Til Yo kan man få en række generatorer her i blandt en som kan generere AngularsJS projekter. 
* [Bower](http://bower.io/) Bower styrer dine klient afhængigheder så du slipper for manuelt at downloade og installerede dine script. Tænk på Bower på klientsiden som en pendant til NPM for NodeJS.  
* [Grunt](http://gruntjs.com/) Grunt bruges til at automatisere bygge- og testprocessen.

Hvis man alligevel bruges alle disse 3 værktøjer så tag en kig på [Yeoman](http://gruntjs.com/) der bedst kan beskrives som et workflow der samler ovenstående værktøjer.

Næste udgave at moderne web udvikling vil fokusere på Microsoft platformen. Men i stedet for det traditionelle ASP.NET MVC valg kigger jeg nærmere på [Nancy](http://nancyfx.org/) med en anmeldelse af bogen [Mastering Web Application Development with AngularJS](http://www.packtpub.com/angularjs-web-application-development/book).