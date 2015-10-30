---
layout: post
title: "Getting Data"
published: false
categories: 
---
Det tredje kursus i programmet Data Science udbudt af John Hopkins Universitet under Coursera hedder "Getting and Cleaning Data". Dette er en kort sammenfatning af min oplevelse med kurset og en opsummering/huskeliste over nyttige udvidelsesbiblioteker til brug for indlæsning, vask og manipulation af datasæt.

# Er dette virkelig Data Science?
I den ideelle verden har vi et komplet datasæt til rådighed for vores kommende data analyse. Men det er den ideelle verden som så godt som aldrig findes. I virkelighedens verden kommer data fra mange forskellige _kilder_ og i mange forskellige _formater_. Derudover er datasæt ofte mangelfulde og/eller indeholder informationer som ikke er relevante for lige netop din analyse. Jobtitlen "Data Scientist" er tidligere blevet kaldet for det [21. århundredes mest sexede jobtitle](https://hbr.org/2012/10/data-scientist-the-sexiest-job-of-the-21st-century/)
men virkelighedens erfaringer fortæller os, at mellem [50% - 80%](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html?_r=0) af tidsforbruget i en data analyse går med indsamling, vask og manipulation af data. Hvor sexet er den opgave egentlig?

Tilbage til spørgsmålet. __Er dette virkelig Data Science?__ Ja og nej. I sig selv kan indlæsning, vask og manipulation af data næppe kaldes for data science. Men når svaret også er 'ja', så er det naturligvis fordi vi i virkelighedens verden er nød til at mestre denne disciplin for at kunne få skabt det datasæt, som vi skal bruge til selve data analysen.

# Indlæsning af data

Data kan som nævnt tidligere komme fra mange forskellige kilder og formater. Hvordan får man så læst data ind i R? Der findes heldigvis udvidelsesbibliotekter til rigtig mange standard formater. Her er blot en kort oversigt over nogle af de mest udbredte:

Data kilde    | R udvidelsesbibliotek
------------- | --------------------- 
Excel         | [XLConnect](https://cran.r-project.org/web/packages/XLConnect/index.html)
XML           | [XML2R](https://cran.r-project.org/web/packages/XML2R/index.html) og  [XMl](https://cran.r-project.org/web/packages/XML/index.html)
JSON          | [jsonlite](https://cran.r-project.org/web/packages/jsonlite/index.html)
SQL           | [rsqlserver](https://github.com/agstudy/rsqlserver) og [RODBC](https://cran.r-project.org/web/packages/RODBC/index.html) 
WEB           | [rvest](https://cran.r-project.org/web/packages/rvest/index.html) og [httr](https://cran.r-project.org/web/packages/httr/index.html)

Data i Excel ark kan være ret ustrukturet af natur, og der findes mange andre muligheder end XLConnect. Denne [artikel](http://blog.datacamp.com/r-tutorial-read-excel-into-r/) giver et godt overblik.

Web scraping er nærmest en kunst i sig selv. Et rigtig godt værktøj i den forbindelse er Chrome browser udvidelsen [SelectorGadget](https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb). For en hurtig gennemgang af mulighederne med SelectorGadget henvises til disse [slides](https://cpsievert.github.io/slides/web-scraping/#1)
 
Funktionalitet i mange af de ovennævnte udvidelsespakker er ikke unik for R. Et godt alternativ for dem med hang til kommandolinje værktøjer findes i den fine lille bog Data Science at the Command Line[1]. Der er intet til hinder for at bruge R til selve dataanalysen og andre værktøjer til indsamling mv. af data.

# Data manipulation

Nu er data indlæst i R. Kan man så gå i gang med selve dataanalysen? Næppe. Datasættet kan være både ufuldstændigt og organiseret på en måde som ikke er velegnet til videre bearbejdning. 

 * Tidy data
 * dplyr grammatik
 * Dato formater

Artiklen Tidy Data af Hadley Wickham er must-read om emnet. Kort sagt er tidy data kendetegnet ved

 * hver kolonne består af en variabel
 * hver række er en (og kun en) observation

Hvis du er bekendt med Codds normalformer for databaser så vil du genkende tidy data som opfyldende tredje normalform. For en alternativ gennemgang af tidy data begrebet henvises til den kommende bog Data Science with R af Garrett Grolemund. På bogen [website](http://garrettgman.github.io/tidying/) finder man eksempler på processen med at skabe et tidy datasæt.

## Dato formater
Det kan være svært at parse datoer, når man indlæser dato. Et givent datoformat afhænger af mange faktorere som fx geografi, kultur og anvendelse. Hvis man ikke har en Unix baggrund kan R's dato type godt synes lidt underligt. R's dato type kommer fra Unix Posix time som angiver tidspunkter (og dermed datoer) i antallet af sekunder efter kl. 00:00:00 den 1. januar 1970. Heldigvis er håndtering af datotyper rimelig nemt at gå til med udvidelsepakken [lubridate](https://cran.r-project.org/web/packages/lubridate/index.html)

## dplyr grammatik og magrittr
Hvis du kender Unix pipes og/eller Haskell F# er kombinationen af udvidelsespakkerne [magrittr og [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html) det helt rigtige valg for dig til data manipulation. dplyr er designet efter en filosofi, hvor de fem verber

funktionssammensætning (.) fra Haskell og forward operatoren |> i F#

Data kilde    | handling
------------- | --------------------- 
select        | udvælg kolonner
filter        | udvælg rækker
mutate        | tilføj nye kolonner eller overskriv eksisterende
arrange       | sortering af data
summarize     | aggregeringer som fx gennemsnit eller sum

i sammensætning er tilstrækkelige til at foretage så godt som alle data manipulationer. I sammensætning skal her opfattes i stil med Unix pipe operator. Hvis man fx har et datasæt

 sql husk og dplyr
 https://cran.rstudio.com/web/packages/dplyr/vignettes/databases.html


## diverse
R Cookbook

 
[1] Tidy data artikel 


@article{JSSv059i10,
   author = {Hadley  Wickham},
   title = {Tidy Data},
   journal = {Journal of Statistical Software},
   volume = {59},
   number = {1},
   year = {2014},
   keywords = {},
   abstract = {A huge amount of effort is spent cleaning data to get it ready for analysis, but there has been little research on how to make data cleaning as easy and effective as possible. This paper tackles a small, but important, component of data cleaning: data tidying. Tidy datasets are easy to manipulate, model and visualize, and have a specific structure: each variable is a column, each observation is a row, and each type of observational unit is a table. This framework makes it easy to tidy messy datasets because only a small set of tools are needed to deal with a wide range of un-tidy datasets. This structure also makes it easier to develop tidy tools for data analysis, tools that both input and output tidy datasets. The advantages of a consistent data structure and matching tools are demonstrated with a case study free from mundane data manipulation chores.},
 issn = {1548-7660},   pages = {1--23}   doi = {10.18637/jss.v059.i10},
   url = {http://www.jstatsoft.org/index.php/jss/article/view/v059i10}
}

@book{Janssens:2014:DSC:2755090,
 author = {Janssens, Jeroen},
 title = {Data Science at the Command Line: Facing the Future with Time-Tested Tools},
 year = {2014},
 isbn = {1491947853, 9781491947852},
 edition = {1st},
 publisher = {O'Reilly Media, Inc.},
} 

@book{Teetor:2011:RC:2011867,
 author = {Teetor, Paul},
 title = {R Cookbook},
 year = {2011},
 isbn = {0596809158, 9780596809157},
 edition = {1st},
 publisher = {O'Reilly Media, Inc.},
} 

@book{Grus15,
  abstract = {Data science libraries, frameworks, modules, and toolkits are great for doing data science, but they're also a good way to dive into the discipline without actually understanding data science. In this book, you'll learn how many of the most fundamental data science tools and algorithms work by implementing them from scratch. If you have an aptitude for mathematics and some programming skills, author Joel Grus will help you get comfortable with the math and statistics at the core of data science, and with hacking skills you need to get started as a data scientist.},
  added-at = {2015-08-24T15:11:50.000+0200},
  address = {Beijing},
  author = {Grus, Joel},
  biburl = {http://www.bibsonomy.org/bibtex/2586c25e1ad4630584da8af63b895871e/flint63},
  file = {O'Reilly eBook:2015/Grus15.pdf:PDF;O'Reilly Product page:http\://shop.oreilly.com/product/0636920033400.do:URL;Amazon Search inside:http\://www.amazon.de/gp/reader/149190142X/:URL},
  groups = {public},
  interhash = {021ad3a8e8d33b5b649751392f935ebc},
  intrahash = {586c25e1ad4630584da8af63b895871e},
  isbn = {978-1-4919-0142-7},
  keywords = {v1500 book ai software development data pattern recognition analysis python},
  publisher = {O'Reilly},
  timestamp = {2015-08-24T15:11:50.000+0200},
  title = {Data Science from Scratch: First Principles with Python},
  url = {http://my.safaribooksonline.com/97814919-01427},
  username = {flint63},
  year = 2015
}
