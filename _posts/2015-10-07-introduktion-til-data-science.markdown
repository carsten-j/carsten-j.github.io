---
layout: post
title: "Introduktion til Data Science"
date: 2015-10-07 15:25:51 +0200
categories: data science markdown git github packrat r rstudio docker rocker
---
Det første kursus i Data Science specialisering fra John Hopkins Universitetet og Coursera er "The Data Scientist's Toolbox". Kurset fungerer som en introduktion til emnerne: data, spørgsmål og værktøjer med primær fokus på værktøjer, sekundært spørgsmål.

<!--more--> 

# Spørgsmål
Det absolut vigtigste at gøre sig klart i forbindelse med data analyse er at forstå, hvad det er for et spørgsmål, som vi ønsker at undersøge og/eller besvare. Der findes en række forskellige typer af spørgsmål som naturligvis har indflydelse på valg af værktøjer.

Kategorisering af spørgsmål:

  * Deskriptiv analyse = beskrivelse og opsummering af data
  * Eksplorativ analyse = er kendetegnet ved at udforske af data, ikke nødvendigvis særlig konkret og til dels knyttet til intuition
  * Statistisk inferens analyse = drage konklusioner om det generelle tilfælde (hele populationen) ud fra det enkelte tilfælde (en stikprøve). 
  * Prædiktiv analyse = måske bedre kendt og omtalt som "machine learning"
  * Kausal analyse = årsagssammenhæng

hvor rækkefølge i kategorisering ofte spiller en afgørende rolle for, hvor svært det er at lave den tilhørende analyse:

> Deskriptiv → Eksplorativ → Inferens → Prædiktiv → Kausal

# Værktøjer
I data science programmet på John Hopkins Universitet / Coursera bruger man [R](https://www.r-project.org/). For undertegnede er et programmeringssprog bare et programmeringssprog. Der kan hurtig gå religion i debatten om det "bedste" programmeringssprog. Men for mig er og bliver det et værktøj, og jeg har det fint med de fleste valg. Ergo kommer det ikke her til at handle om den endeløse debat om R versus Python, som der ellers findes [masser](http://www.infoworld.com/article/2951779/application-development/in-data-science-the-r-language-is-swallowing-python.html) af [eksempler](http://sebastianraschka.com/blog/2015/why-python.html) [på](http://www.kdnuggets.com/2015/05/r-vs-python-data-science.html).

## Markdown
I R kan man kombinere tekst og kode til generering af rapporter, præsentation mv. Til dette formål bruger man [markdown](https://daringfireball.net/projects/markdown/) (som ikke er specifikt til R men et generelt tekst til HTML konverteringsværktøj) opfundet af [John Gruber](https://daringfireball.net/projects/markdown/). For at bruge markdown i RStudio installerer man udvidelsespakken [R Markdown](http://rmarkdown.rstudio.com/). R Markdown kan ses som [literate programming](https://en.wikipedia.org/wiki/Literate_programming) som defineret af Donald E. Knuth i bogen af samme navn [Literate Programming](http://www.amzn.com/0937073806).

## Git and GitHub
Distribuerede versions kontrol systemer som Mercurial og måske især Git er blevet virkelig populære. Især efter udbredelse af GitHub begyndende fra 2008. Det overrasker mig fortsat, hvis softwareudviklere ikke bruger versionsstyringsværktøjer som en del af deres professionelle virke. Men det er måske mere oplagt at forsøge at sikre at personer i data science branchen får lært versionsstyring fra starten. Måske kommer man med en uddannelsesmæssig baggrund, hvor der ikke har været fokus på versionsstyring. Selv har takket været en god "opdragelse" i [SimCorp](http://www.simcorp.com/) anvendt versionsstyring siden mit første job i 1995. I mange år stod den på [CVS/Unix](https://en.wikipedia.org/wiki/Concurrent_Versions_System) og Visual Source Safe/Windows.

Versionsstyring af kode kan ses som første skridt til at kunne genskabe tidligere resultater. Men hvis man vil være helt sikker på at kunne genskabe et tidligere resultat og/eller opførsel af software, så er det ikke nok. Udover at have styr på ens egen kode, er det også nødvendigt at have kontrol af ens udviklingsmiljø. Det omfatter som minimum

  * Versionen af R
  * Benyttede biblioteker, fx dplyr og deres versioner
  
## Packrat
Lad os forestille os at man arbejder på flere data analyse projekter i R, og at man i begge projekter bruger udvidelsespakken FOOBAR. Hvis nu der udkommer en ny version af FOOBAR med funktionalitet som man har behov for i det ene projekt, så vil man naturligt ønske at opgradere FOOBAR til den nyere version. Men hvis man har en global installation af FOOBAR, dvs en installation af FOOBAR som anvendes i alle ens projekter, så kan en opgradering af FOOBAR potentiel skabe problemer for de projekter som ikke nødvendigvis kræver en opdateret udgave af FOOBAR. 

I sådanne situationer er udvidelsespakken [Packrat](http://rstudio.github.io/packrat/rstudio.html) løsningen. Packrat giver mulighed for at installere udvidelsespakker til R lokalt til et givet projekt. På den måde kan man have FOOBAR installeret i flere versioner afhængigt af ens projekter.

## R (og RStudio)
Forskellige version af R kan have forskellig opførsel, fx pga fejlrettelser. Det sammen gælder ens IDE som fx RStudio. Hvordan versionsstyrer man R og RStudio? Tilbage i 1995 var det ikke en nem opgave og løsningen var at versionsstyre binære file, dvs selve de eksekverbare filer som fx selve compileren. Grundliggende er versionsstyring meget bedre egnet til tekstbaseret filformater, så det var på ingen måde en optimal løsningen. Men med lidt god vilje fungerede det i hverdagen. Er der i dag en bedre løsning? En mulighed er at bruge virtuelle maskiner eller container løsninger til at versionsstyre selve udviklingsmiljøet. Diskplads er billig, så det bør ikke have afgørende betydning at man skal have nogle VM's eller containere liggende.

### Docker
En hurtig og nem løsning kunne være Docker containere. Så vidt jeg ved findes der ikke en officiel R container, men der findes en populær udgave med R og RStudio Server kaldet [Rocker](https://ropensci.org/blog/2014/10/23/introducing-rocker/). Men denne kan man bruge RStudio gennem en browser. Dette er ikke en introduktion til Docker, så du må læse videre andre steder om containere og brugen af disse. Efterfølgende kan du tage et nærmere kig på denne [container](https://hub.docker.com/r/rocker/hadleyverse/), som du kan læse mere om [her](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image).

## R udvidelsespakker
Du har lavet en data analyse og til formålet skrevet R kode bestående af funktioner, scripts osv. Analysen bygger også på et eller flere datasæt. Hvordan gør man nemmest hele analysen tilgængelig for andre. Helst på en måde som gør det nemt for andre at reproducere og arbejde videre med dine resultater. Svaret er at skrive sine egne R udvidelsespakker. Du kan enten læse mere i bogen [R Packages](http://shop.oreilly.com/product/0636920034421.do) af Hadley Wickham, O'Reilly 2015 eller på bogen [interaktive website](http://r-pkgs.had.co.nz/). 

## Deployment
R scripts er i sagens natur retter mod interaktiv programmering. Men det er muligt at deploye R kode i produktion. Her er et par ressourcer:

  * [https://www.opencpu.org/download.html](https://www.opencpu.org/download.html)
  * [http://shiny.rstudio.com/](http://shiny.rstudio.com/)
  * [http://deployr.revolutionanalytics.com/](http://deployr.revolutionanalytics.com/)
  * [http://begriffs.com/posts/2015-04-10-deploying-predictive-models-in-R.html](http://begriffs.com/posts/2015-04-10-deploying-predictive-models-in-R.html)

Det kan få en kæmpe betydning for udbredelse af brugen af R at Microsoft SQL Server 2016 understøtter brugen af R direkte i databasen. Denne feature er endnu ikke offentlig tilgængelig men man kan se en demo i denne [video](https://channel9.msdn.com/Events/Ignite/2015/BRK2558). Det starter ca. 57 minutter inde i videoen.
