---
layout: post
title: "Getting Data"
published: false
categories: 
---

https://github.com/hadley/rvest
https://cpsievert.github.io/slides/web-scraping/#1
https://cpsievert.github.io/XML2R/
https://github.com/hadley/httr

# Er dette virkelig Data Science?
I den ideelle verden har vi et komplet datasæt til rådighed for vores kommende data analyse. Men det er den ideelle verden som så godt som aldrig findes. I virkelighedens verden kommer data fra mange forskellige _kilder_ og i mange forskellige _formater_. Derudover er datasæt ofte mangelfulde og/eller indeholder informationer som ikke er relevante for lige netop din analyse. Jobtitlen "Data Scientist" er tidligere blevet kaldet for det [21. århundredes mest sexede jobtitle](https://hbr.org/2012/10/data-scientist-the-sexiest-job-of-the-21st-century/)
men virkelighedens erfaringer fortæller os, at mellem [50% - 80%](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html?_r=0) af tidsforbruget i en data analyse går med indsamling, vask og manipulation af data. Hvor sexet er den opgave egentlig?

Tilbage til spørgsmålet. __Er dette virkelig Data Science?__ Ja og nej. I sig selv kan indlæsning, vask og manipulation af data næppe kaldes for data science. Men når svaret også er 'ja', så er det naturligvis fordi vi i virkelighedens verden er nød til at mestre denne disciplin for at kunne få skabt det datasæt, som vi skal bruge til selve data analysen.

# Indlæsning af data

Data kilde    | R udvidelsesbibliotek
------------- | --------------------- 
Excel         | XLConnect
XML           | [XMl](https://cran.r-project.org/web/packages/XML/index.html)
JSON          | [jsonlite](https://cran.r-project.org/web/packages/jsonlite/index.html)
SQL           | [rsqlserver](https://github.com/agstudy/rsqlserver) og [RODBC](https://cran.r-project.org/web/packages/RODBC/index.html) 
WEB           | [rvest](https://cran.r-project.org/web/packages/rvest/index.html) og [httr](https://cran.r-project.org/web/packages/httr/index.html)
 
 
 sql husk og dplyr
 https://cran.rstudio.com/web/packages/dplyr/vignettes/databases.html
 
 
 integration med sql server 2016
 
data science command line book 
alternativ og sikkert også python
gælder om ikke at være religiøs i valg af værktøjer 

excel
http://blog.datacamp.com/r-tutorial-read-excel-into-r/

rvest css selector vs xpath

# Data manipulation

 * Tidy data
 * dplyr grammatik
 * Regulære udtryk
 * Datoer


## Tidy data
We can say that a dataset is a collection of numbers or strings or both. If a value is number, it has quantitative character. If it is a string, it has qualitative character.

Tidy data sets are easy to manipulate, model and visualise, and have a specific structure. And therefore tidy data should fulfil Codd's 3rd normal form.

Each variable forms a column.
Each observation forms a row.
Each type of observational unit forms a table.
What is untidy data then? There are many ways data can be untidy. Wickham’s top five are as follows:

Column names represent data values instead of variable names
A single column contains data on multiple variables instead of a single variable
Variables are contained in both rows and columns instead of just columns
A single table contains more than one observational unit Data about an observational unit is spread across multiple data sets

bog link fra pinboard

## Regulære udtryk

## Datoer posix
 
## dplyr grammatik 
Hvis du kender Unix pipes og/eller Haskell F# er udvidelsespakken dplyr det helt rigtige valg for dig til data manipulation. dplyr er designet efter en filosofi, hvor de fem verber

Data kilde    | handling
------------- | --------------------- 
select        | udvælg kolonner
filter        | udvælg rækker
mutate        | tilføj nye kolonner eller overskriv eksisterende
arrange       | sortering af data
summarize     | aggregeringer som fx gennemsnit eller sum

i sammensætning er tilstrækkelige til at foretage så godt som alle data manipulationer. I sammensætning skal her opfattes i stil med Unix pipe operator. Hvis man fx har et datasæt

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
