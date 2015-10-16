---
layout: post
title: "R programmering"
date: 2015-10-16 17:15:51 +0200
---

Andet kursus i data science programmet på Coursera / Hopkins University er et kursus i R programmering. Jeg har ikke tænkt mig at skrive (endnu) en R tutorial, så dette skal mere læses som en huskeliste til mig selv.

Mit første indtryk af R er, at der er virkelig mange måder at opnå det samme resultat på. Det handler i høj grad om at finde de udvidelsesbiblioteker som stiller den ønskede funtionalitet til rådighed på en måde som passer netop dig.

# Udvidelsesbiblioteker

 * [dplyr](https://github.com/hadley/dplyr) - data manipulation i velkendt Unix "pipe and filter" stil.
 * [magrittr](https://github.com/smbache/magrittr) - `%>%` operator i stil med funktionssammensætning `(.)` fra Haskell og forward operatoren `|>` i F#
 * [tidyr](https://github.com/hadley/tidyr) - funktionalitet til at gøre et datasæt 'tidy' [1]. Læs mere nedenfor.
 * [devtools](https://github.com/hadley/devtools) - hjælpefunktioner som gør det nemt selv at skrive udvidelsesbiblioteker
 * [ggplot2](http://ggplot2.org/book/) - grafer og plots
 * [readr](https://github.com/hadley/readr) - forbedret funktionalitet til at læse csv filer i forhold til den indbyggede `read.csv` funktion
 * [lintr](https://github.com/jimhester/lintr) - statisk kode analyse  https://github.com/jimhester/lintr
 * [formatR](https://github.com/yihui/formatR) - formattering af kode
 * [testhat](https://github.com/hadley/testthat) - unit test
 * [purrr](https://github.com/hadley/purrr) - functional programming med velkendte funktioner i stil med `map`, `fold` og `zip`.

R har basis funktionalitet til grafer, men jeg kan bedre lide ggplot2, som udover at kunne lave plots også er en hel grammatik (eller DSL) for grafer. Det tiltaler 'LaTex'-nørden i mig.

## Tidy data
Det er ofte nødvendigt at forberede data før man kan lave en egentlig analyse. Det er her at begrebet 'tidy' data kommer ind. De to vigtigste karakteristika ved tidy data er:

  * Hver kolonne består af en variabel
  * Hver række er en (og kun en) observation

Hvis man har et datasæt som ikke overholder disse regler, er der god hjælp at hente i tidyr udvidelsesbiblioteket.

## Non standard evaluation og dplyr
Med dplyr kan man fx skrive

{% highlight r %}
mtcars %>% summarise(mean(mpg))
{% endhighlight %}
hvor man med udgangspunkt i datasættet mtcars udregner gennemsnittet for variablen `mpg`. Men hvad nu hvis man som input argumenter til en funktion ønsker at angive hvilke variable som der skal beregnes gennemsnit for. R har ikke mange datatyper som input vil her typisk være en streng `"mpg"`. Hvordan oversætter man strengen `"mgp"` til variablen `mgp`?

Svaret skal findes i begrebet Non Standard Evaluation (NSE). Lad os starte med et andet eksempel end det førnævnte. Hvis man enten kender til R, kan man nemt blive overrasket over dette lille eksempel


{% highlight r %}
x <- seq(0, 2 * pi, length = 100)
cosx <- cos(x)
plot(x, cosx, type = "l")
{% endhighlight %}

![center](/../images/2015-10-16-r-programmering/unnamed-chunk-3-1.png) 

Hvad er der "galt" med denne graf? Et godt tip er at se nærmere på akserne. Hvordan blev argumenter x og cosx til funktionen plot lavet om til labels på akserne. I hovedparten af programmeringsprog kan man inde i funktionen plot kun tilgå selve værdien af argumenterne x og cosx. Men i R kan man også tilgå den kode som bruge til at udregne værdien af variblene x og cosx. Det er dette 'trick' som kaldes NSE.

For mere information om NSE kan man enten læse om brugen af NSE i [dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/nse.html) eller mere generelt om NSE [her](http://adv-r.had.co.nz/Computing-on-the-language.html#capturing-expressions).

Funktioner i dplyr kaldes som default i NSE mode, hvilket gør det vanskeligt at bruge dem i en mere dynamisk ramme, hvor nogle af argumenter fx er givet ved en streng. Heldigvis har næsten alle dplyr funktion en udgave som er prefixet med underscore, fx summarize_. Forskellen er at udgaverne der er prefixet med _ kaldes med Standard Evaluation. 

{% highlight r %}
summarise_(mtcars, "mean(mpg)")
{% endhighlight %}

Det tog mig en aften at regne ud. Men jeg husker det til næste gang!

# Projekt opsætning
Bogen [R Packages](http://shop.oreilly.com/product/0636920034421.do) eller [online](http://r-pkgs.had.co.nz/) har en fin gennemgang af organiseringen af R udvidelsesbiblioteker. Og uanset om man er ved at skrive en udvidelsepakke eller ej, er det altid en god ide at bruge samme skabelon til at organisere ens filer efter.

Det er her at [Yeoman](http://yeoman.io/) kommer ind i billedet. Selvom Yeoman beskrives som "the web's scaffolding tool for modern webapps" så kan Yeoman sagtens også bruges til andre formål, fx til at danne en folder skabelon for R udvidelsespakker.

Det engelske ord "scaffolding" har vist endnu ingen dansk oversættelse, når ordet bruges i kontekt med at danne en folder skabelon, som man bygger en applikation udfra. En skabelon skal her forstås som en bestemt måde at organisere filer på i en række foldere. Til dette formål er værktøjet Yeoman suverænt. Jeg har taget udgangspunkt i denne [generator](https://github.com/kirillseva/generator-newpackage) til at skabe R udvidelsespakker og dernæst tilpasset den til mine [ønsker](https://github.com/carsten-j/generator-newpackage).

# Resourcer
Indtil videre er min absolutte favorit bog om R denne her: [Advanced R Programming](http://www.amzn.com/1466586966) af Hadley Wickham. Der findes også en [online](http://adv-r.had.co.nz/) udgave. 

For hurtigt at komme i gang med konkrete opgaver kan jeg også anbefale [R Cookbook](http://www.amzn.com/0596809158) af Paul Teetor. Denne findes også [online](http://www.cookbook-r.com/).

Det indbyggede dokumentationssystem i R er nu også ganske godt. Hvis man har brug for hjælp om funktionen setwd() skriver man på kommandolinien blot


{% highlight r %}
?setwd()
{% endhighlight %}

# Integration til andre programmeringssprog
R beskyldes ofte for at være et programmeringsprog med dårlig performance. Mine egne erfaringer er endnu for begrænsede til at jeg kan udtale mig om dette. Selve R er et fortolket sprog, hvilket i sig selv ofte giver dårligere performance end kompilerede sprog. Men en masse kernefunktionalitet i R er skrevet i Fortran, C og C++. Det virker umiddelbart lige til at kalde fx C++ kode fra R. Læs mere i bogen [Seamless R and C++ Integration with Rcpp](http://www.amzn.com/1461468671) af Dirk Eddelbuettel eller i artiklen [Rcpp: Seamless R and C++ Integration](http://www.jstatsoft.org/index.php/jss/article/view/v040i08/v40i08.pdf) 
af Dirk Eddelbuettel og Romain Francois.

Der er også spændende integrationer til funktionsprogrammeringsprogene F# og Haskell. 

F# har en R type provider som gør det muligt at kalde R funktionalitet fra F# på en typestærk måde. Hvis du kører med danske sprog indstillinger var det for mig nødvendigt at kalde 

{% highlight fsharp %}
R.Sys_setlocale("LC_ALL", "us")   
{% endhighlight %}

fra ens F# kode. Eller får jeg underlige fejl og mystiske float afrundinger.

Projektet [HaskellR](http://www.tweag.io/blog/programming-r-at-native-speed-using-haskell) ser ser også rigtig spændende ud. Bemærk at man også kan afvikle det hele i [Jupyter](https://jupyter.org/). 

[1] http://vita.had.co.nz/papers/tidy-data.pdf
