---
layout: post
title: Machine learning, nærmeste nabo, F#, NancyFX, Bootstrap og Sketch.js
date: '2014-11-19 19:28:59'
categories: [machineLearning, FSharp, NancyFX, Bootstrap, JavaScript, kNN]
---

Overskriften er noget af en mundfuld for undertegnede med en masse for mig ukendte teknologier. Men omvendt er det jo hele pointen med denne blog at lære noget nyt, så jeg kaster mig ud i det ...

<!--more-->

Hvis du kender app'en Mobilporto fra Post Danmark, så ved du, at de gammeldags frimærker nu kan erstattes af portokoder. I stedet for et frimærke får man en kode på 9 tegn som man så kan skrive på kuverten der hvor man tidligere placerede et frimærke. En portokode ser sådan ud

![center](/images/mobilporto.png)

Det velkendte frimærke er blevet erstattet af en smartphone app! Det giver god mening, da vi alligevel efterhånden sender så få breve og hvis man købte en hæfte med frimærker, så endte man altid i en situation, hvor portoen var steget inden man næste gang skulle bruge et frimærke. Tidligere blev posten sorteret manual på posthuset før den blev bragt ud. Den proces er siden blevet automatiseret til maskinel genkendelse af adresserne. På samme måde bliver portokoder nu scannet og genkendt automatisk. I denne blogpost skal vi se nærmere på denne proces og se eksempel på, hvordan genkendelse af tal kan ske digitalt.

Udgangspunktet for min udforskning af digital genkendelse af tal er en konkurrence på Kaggle.com. Du kan læse mere om detaljerne i konkurrencen [her](https://www.kaggle.com/c/digit-recognizer). Kaggle er et website, der organiserer konkurrencer i diverse machine learning discipliner. Hvis man gerne vil i gang med at lære om machine learning kan man på Kaggle også finde en række tutorials som hjælper en i gang. Datasættet til tal genkendelse er et klassisk datasæt også kendt som MNIST ("Modified National Institute of Standards and Technology")datasættet. Du kan læse og lære mere om datasættet [her](http://yann.lecun.com/exdb/mnist/index.html).

Selve datasættet består at over 40.000 observation, hvor der for hver observation er givet et tal og et "billede". Billedet er ikke en billede fil men repræsenteret ved de 28 x 28 pixels som udgør billedet. For hver pixel er der angivet en værdi mellem 0 og 255, hvor 0 indikere lys/hvid og 255 er mørk/sort. Billedet er altså givet ved 784 værdier: 

    000 001 002 003 ... 026 027
    028 029 030 031 ... 054 055
    056 057 058 059 ... 082 083
     |   |   |   |  ...  |   |
    728 729 730 731 ... 754 755
    756 757 758 759 ... 782 783 

og kan fx se således ud for et konkret eksempel 

![center](/images/kaggleDigitExample.png)

Det er målet med dette blog indlæg selv at skrive det software som kan bruges til tal genkendelsen, mens omkringliggende software som fx indlæsning af data fra filer vil ske med open source standard løsninger. Udover selve løsningen til genkendelse af tal vil opgaven også omfatte at bygge en webbaseret front-end, hvor man skal kunne skrive/tegne et tal, og så se om genkendelses algoritmen kan afgøre hvilket tal man har skrevet. Kernen i løsningen vil blive skrevet i F# mens web applikationen vil være baseret på .NET web frameworket NancyFX og C# samt JavaScript og Bootstrap. 

Wikipedia har følgende teksktuelle beskrivelse af algoritmen:

wikipedia:
> K-nærmeste-naboer (KNN) er en klassifikationsalgoritme baseret på tanken om, at to dataprøvers numeriske værdier vil være tæt på hinanden, hvis de er fra samme klasse. K'et i navnet hentyder til det antal naboer, man tager med i klassificeringen. Kigger man eksempelvis på de nærmeste 3 naboer, er det en 3-nærmeste-naboer klassifikator.
Til klassificering af en dataprøve beregnes for hver dataprøve i datasættet den euklidiske (Eller andre former) distance. For de k dataprøver, hvor distancen er lavest, vælges den klasse, hvor der er flest forekomster i de nærmeste dataprøver.

Algoritmen til bestemmelse af nærmeste nabo er ganske simpel og kan formuleres på følgende måde: For et given mængde af observation \(O\), hvor man for hver observation har en tuple (l, x) bestående af selve data \(x\) for observation og et label \(l\) indeholdende observations faktiske værdi. I tilfældes med tal genkendelse vil \(x\) være pixels i et billede af det tal, som vi ønsker at genkende og \(l\) vil være selve tallet.

{% highlight javascript %}
Input: y, X, dist
for alle observation (l, x) ∈ X
    beregn afstanden dist mellem y og x: dist(x, y)
Sorter de beregnede afstande |X| i stigende orden
Vælg de første k elementer
Foretag en gruppering af de labels som er blandt de første k elementer 
y sættes så til at have værdien for den gruppering som optræder hyppigst
{% endhighlight %}

Det er ovenstående algoritme, at jeg tager udgangspunkt i her. Til konkrete anvendelser er dette dog nok
for simpel en løsning. Hvis man blot skal pege på at par eksempler kan man fx nævne

* Performance. Som algoritmen er formuleret ovenfor er det klar, at der ikke er tale om en model der skalerer særlig godt. Hvis man har n observationer bestående, hvor hver observation er d-dimensionel så vil køretiden være af størrelsesorden O(dn), altså lineær.
* Isolering af tegn. I algoritmen er der slet ikke taget stilling til, hvordan man går fra en tal til de enkelte cifre i tallet.

Et central element i algoritmen er afstandsfunktionen \(dist\) som naturligt forudsætter at observationerne ligger i et metrisk rum. Valget af \(dist\) vil naturligvis afhænge af observationernes natur. Blandt de mere udbredte afstandsfunktioner kan nævnes

* Euklids
* Jaccard
* Levenshtein

Læs mere om de enkelte afstandsfunktioner i [1]. Tangent afstand defineret i [2] er interessant tager også hånd om problematik med roteret tegn

For at sikre at elementer som ligger tæt på \(y\) betyder mere i klassifiseringen af \(y\) kan man f.eks vælge at vægte observationer i \(X\). En udbredt vægtning er den inverse til distancen, \(1/dist\). Hvis et punkt ligger tæt på \(y\) vil det få en stor vægtning mens punkter langt fra \(y\) vil betyde mindre.

Der er flere muligheder for at optimere på performance så man undgår lineære køretiden. Fx ved brug af alternative [data strukturer](https://en.wikipedia.org/wiki/K-d_tree).

## F# backend
Datafilerne fra Kaggle er CSV filer. Der er ingen grund til at opfinde den dybe tallerken og skrive endnu en CSV læser, når der allerede findes en i FSharp.Data [projektet](https://fsharp.github.io/FSharp.Data/library/CsvProvider.html). Hvis man ser bort fra kode til at indlæse data og den konkrete implementering af afstandsfunktioner til kan 1 nærmeste nabo algoritmen udtrykkes med en enkelt kodelinie i F#

{% highlight fsharp %}
let getClosestObservation (observation : Observation) (xd : seq<Digit>) (dist : DistanceObservation) = 
    (PSeq.minBy (fun a -> dist observation a) xd).Label
{% endhighlight %}

Input er en observation, træningsdata (hvor vi kender både data og den værdi som data repræsenterer) samt en afstandsfunktion. I følge algoritmen beskrevet ovenfor vælger vi nu simpelthen det punkt i træningsdata som ligger tættest på observationen. Bemærk at vi bruger [`PSeq`](https://github.com/fsprojects/FSharp.Collections.ParallelSeq) fremfor bare `Seq`. De enkelte afstandsberegninger er uafhængige af hinanden og derfor kan man med fordel beregne dem parallelt. 

## Webapplikation

Hvis man ønsker at forbinde en F# backend med en webbaseret front-end vil det alt andet være lettere hvis man har en .NET baseret front-end. Standard løsningen er jo nok ASP.NET men der findes alternativer. Da jeg til dette projekt fint kan klare mig med en letvægtsløsning, har jeg i stedet valgt at bruge [NancyFX](http://nancyfx.org/). (som på mange måder minder om og er inspireret af [Sinatra](http://www.sinatrarb.com/). Det siges at navnet Nancy er valgt som reference til Nancy Sinatra datter af Frank Sinatra.

En webapplikation har brug for en GUI. Hvad gør man som backend udvikler uden det store kendskab til HTML, CSS og JavaScript. Svaret kunne være Bootstrap. Læs mere i min boganmeldese [Jump Start Bootstrap]({% post_url 2014-11-06-jump-start-bootstrap %}).

Som input kontrol til webapplikationer har jeg brugt [Sketch.js](http://intridea.github.io/sketch.js/) som er en HTML5 canvas kontrol samt tilhørende funktionalitet til at rette, slette og oploade det som bruger (i dette tilfælde) skriver på skærmen. Bemærk at der ikke er tale om touch-screen, men alene kontrol via mus eller touch-pad.

## Hvad mangler eller kunne være bedre

* I web applikationen er canvas'et ikke en responsive kontrol canvas, underlig resize problem
* Web applikationen bruger ikke MNIST datasættet til klassificering men derimod et mindre datasæt 
som jeg selv har konstrueret. Dette er primært for at undgå at skulle tage stilling til spørgsmål som:
skalering af orginale billede, konvertering til gråtonet billede, performance (kNN er lineær i køretid)
* Manglende test. Formålet med opgaven er at udforske et nyt område og ikke på at skrive produktionsklar kode.
* Næsten ingen erfaring med JavaScript m.v. så sig endelig til, hvis du spotter noget som kunne gøres bedre.
* Ingen validering af kvaliten af klassificeringen (man kunne fx bruge cross validation).

Koden til hele projektet findes på [Github](https://github.com/carsten-j/kNN). Jeg skal for en god ordens skyld gøre opmærksom på, at der på ingen måde er tale om produktionsklar kode. Hele projektets formål har været at tilegne sig (både domæne-specifik og teknisk) viden om områder, som jeg på forhånd ikke kendte til. Der findes masser af anerkendte open source løsning til nærmeste nabo algoritmen, og jeg vil bestemt ikke anbefale at man skriver sin egen med mindre formålet er læring. Hvis du skal bruge denne algoritmen i produktionssammenhæng, så kig fx nærmere på, hvad R tilbyder.

## Litteratur og henvisninger

[1] Mining of Massive Datasets af Jure Leskovec, Anand Rajaraman og Jeffrey D. Ullman

[2] The Elements of Statistical Learning af Trevor Hastie, Robert Tibshirani og Jerome Friedman
