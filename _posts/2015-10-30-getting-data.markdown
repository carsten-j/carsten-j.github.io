---
layout: post
title: "Indlæsning, vask og manipulation af data"
date: 2015-10-30 17:13:51 +0200
---
Det tredje kursus i programmet Data Science udbudt af John Hopkins Universitet under Coursera hedder "Getting and Cleaning Data". Dette er en kort sammenfatning af min oplevelse med kurset og en opsummering/huskeliste over nyttige udvidelsesbiblioteker til brug for indlæsning, vask og manipulation af datasæt.

# Er dette virkelig Data Science?
I den ideelle verden har vi et komplet datasæt til rådighed for vores kommende data analyse. Men den ideelle verden findes så godt som aldrig. I virkelighedens verden kommer data fra mange forskellige _kilder_ og i mange forskellige _formater_. Derudover er datasæt ofte mangelfulde og/eller indeholder informationer som ikke er relevante for lige netop din analyse. Jobtitlen "Data Scientist" er tidligere blevet kaldet for det [21. århundredes mest sexede jobtitle](https://hbr.org/2012/10/data-scientist-the-sexiest-job-of-the-21st-century/),
men virkelighedens erfaringer fortæller os, at mellem [50% - 80%](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html?_r=0) af tidsforbruget i en data analyse går med indsamling, vask og manipulation af data. Hvor sexet er den opgave egentligt?

Tilbage til spørgsmålet. __Er dette virkelig Data Science?__ Ja og nej. I sig selv kan indlæsning, vask og manipulation af data næppe kaldes for data science. Men når svaret alligevel er 'ja', så er det naturligvis fordi vi i virkelighedens verden er nød til at mestre denne disciplin for at kunne få skabt det datasæt, som vi skal bruge til selve data analysen.

# Indlæsning af data

Data kan som nævnt tidligere komme fra mange forskellige kilder og formater. Hvordan får man så læst data ind i R? Der findes heldigvis udvidelsesbibliotekter til rigtig mange standard formater. Her er blot en kort oversigt over nogle af de mest udbredte:

Data kilde | R udvidelsesbibliotek
---------- | --------------------- 
Excel      | [XLConnect](https://cran.r-project.org/web/packages/XLConnect/index.html)
XML        | [XML2R](https://cran.r-project.org/web/packages/XML2R/index.html) og  [XMl](https://cran.r-project.org/web/packages/XML/index.html)
JSON       | [jsonlite](https://cran.r-project.org/web/packages/jsonlite/index.html)
SQL        | [rsqlserver](https://github.com/agstudy/rsqlserver) og [RODBC](https://cran.r-project.org/web/packages/RODBC/index.html) 
WEB        | [rvest](https://cran.r-project.org/web/packages/rvest/index.html) og [httr](https://cran.r-project.org/web/packages/httr/index.html)

Data i Excel ark kan være ret ustrukturet af natur, og der findes mange andre muligheder end XLConnect. Denne [artikel](http://blog.datacamp.com/r-tutorial-read-excel-into-r/) giver et godt overblik.

Web scraping er nærmest en kunst i sig selv. Et rigtig godt værktøj i den forbindelse er Chrome browser udvidelsen [SelectorGadget](https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb). For en hurtig gennemgang af mulighederne med SelectorGadget henvises til disse [slides](https://cpsievert.github.io/slides/web-scraping/#1).
 
### Om web scraping
Husk at checke robots.txt filen for websites for du går i gang med web scraping. Du bør overholde spillereglerne angivet i denne fil. Hvis man fx kigger på [O’Reillys webshop](http://shop.oreilly.com/) finder vi følgende indhold i deres [`http://shop.oreilly.com/robots.txt`](http://shop.oreilly.com/robots.txt) fil

{% highlight javascript %}
Crawl-delay: 30 
Request-rate: 1/30 
{% endhighlight %}

som betyder at man kun må foretage et request hver 30. sekund og at man yderligere kun må hente en side per 30. sekund. Der er andre linjer som angiver hvilke URL'er man må eller ikke må webscrape.
 
## Der er alternativer til R 
Funktionalitet i mange af de ovennævnte udvidelsespakker er ikke unik for R. Et godt alternativ for personer med hang til kommandolinje værktøjer findes i den fine lille bog Data Science at the Command Line[1]. Der er intet til hinder for at bruge R til selve dataanalysen og andre værktøjer til indsamling mv. af data.

# Data manipulation

Nu er data læst ind i R. Kan man så gå i gang med selve dataanalysen? Næppe. Datasættet kan være både ufuldstændigt og organiseret på en måde som slet ikke er velegnet til videre bearbejdning. Vi må i gang med data vask og manipulation først. Fra kurser skal nævnes følgende tre punkter:

 * Tidy data
 * dplyr grammatik og magrittr
 * Dato formater

## Tidy data
Artiklen Tidy Data af Hadley Wickham er must-read om emnet. Kort sagt er tidy data kendetegnet ved

 * hver kolonne består af en variabel
 * hver række er en (og kun en) observation

Hvis du er bekendt med Codds normalformer for databaser så vil du genkende tidy data som opfyldende tredje normalform. For en alternativ gennemgang af tidy data begrebet henvises til den kommende bog Data Science with R af Garrett Grolemund. På bogen [website](http://garrettgman.github.io/tidying/) finder man eksempler på processen med at skabe et tidy datasæt.

## dplyr grammatik og magrittr
Hvis du kender Unix pipes og/eller funktionssammensætning (.) fra Haskell og forward operatoren |> i F# er kombinationen af udvidelsespakkerne [magrittr og [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) det helt rigtige valg for dig til data manipulation. Grammatikken for dplyr er bygget op omkring verber, hvoraf nogle af de meste brugte er i nedenstående tabel

Verbum     | Handling
---------- | --------------------- 
select     | udvælg kolonner
filter     | udvælg rækker
mutate     | tilføj nye kolonner eller overskriv eksisterende
arrange    | sortering af data
summarise  | aggregeringer som fx gennemsnit eller sum
group_by   | gruppering af data

i sammensætning er tilstrækkelige til at foretage så godt som alle data manipulationer. I sammensætning skal her opfattes i stil med Unix pipe operator. Med det klassiske [iris datasæt](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/iris.html) kan man fx på en linie

{% highlight r %}
library(dplyr)
iris %>% 
  filter(Sepal.Length > 5.0) %>% 
  group_by(Species) %>% 
  summarise(mean = mean(Sepal.Length)) %>% 
  arrange(desc(mean))
{% endhighlight %}

udregne gennemsnittet af `Sepal.Length` for de rækker hvor `Sepal.Length` er større end 5.0 opdelt på art og sorteret efter faldende gennemsnittet.

En anden styrke ved dplyr er mulighed for at hente data direkte fra en database. Læs mere [her](https://cran.rstudio.com/web/packages/dplyr/vignettes/databases.html).

## Dato formater
Det kan være svært at parse datoer, når man indlæser dato. Et givent datoformat afhænger af mange faktorere som fx geografi, kultur og anvendelse. Hvis man ikke har en Unix baggrund kan R's dato type godt synes lidt underligt. R's dato type kommer fra Unix Posix time som angiver tidspunkter (og dermed datoer) i antallet af sekunder efter kl. 00:00:00 den 1. januar 1970. Heldigvis er håndtering af datotyper rimelig nemt at gå til med udvidelsepakken [lubridate](https://cran.r-project.org/web/packages/lubridate/index.html).

## Diverse
For nybegyndere i R programmeringsproget vil jeg anbefale bogen R Cookbook[3]. Den gennemgår en række eksempler på hvordan man udfører forskellige opgaver med R. Der er fx også et afsnit om data manipulation.

# Referencer
[1] Tidy data, Hadley  Wickham, Journal of Statistical Software, Vol 59, 2014 

[2] Data Science at the Command Line, Jeroen Janssens, O'Reilly Media, 2014

[3] R Cookbook, Paul Teetor, O'Reilly Media, 2011
