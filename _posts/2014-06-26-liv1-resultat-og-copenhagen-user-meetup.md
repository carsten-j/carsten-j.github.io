---
layout: post
title: Liv1 resultat og Copenhagen useR meetup
date: '2014-06-26 18:25:48'
---

Jeg var til mit første møde i meetup gruppen Copenhagen useR i går. Faktisk opdagede jeg kun gruppen fordi arrangementet blev annonceret gennem en anden meetup gruppe F#unktionelle Københavnere, som jeg tidligere har nævnt her på bloggen. Mødets overskrift var Let's pipe it (F# + R + R TypeProvider) og aftenes to talere var 
[Stefan Milton Bache](https://twitter.com/stefanbache) og [Phil Trelford](http://trelford.com/blog/).

Stefan talte om R pakken magrittr og dens forward-pipe operator %>% som er inspireret af F#. Det virker som en fantastisk udvidelse af R som på meget kort tid har ændret på hele den måde man kan skrive R scripts på. Jeg viser et par simple eksempler nedenfor. Phil introducerede kort F# og talte derudover om type providers generelt og især om R type provideren som giver adgang til R via F#. Da jeg sidste år første gang brugte R type provider'en fra F# opdagede jeg, at man kan få nogle underlige resultater, hvis man bruger danske settings (altså , for decimalseparator). 

I sidste uge var jeg til eksamen i liv1. Det har været et super spændende og relevant kursus, hvor jeg har lært virkeligt meget. Eksamensresultatet kom i dag, og jeg fik 7. Det er faktisk rigtig godt tilfreds med givet at det er 18+ år siden, at jeg læste matematik og jeg har arbejdet fuldtid ved siden af. 

Her er en kort data analyse af det samlede eksamensresultat.

Indlæs diverse R biblioteker og data

{% highlight r %}
library(dplyr)
library(ggplot2)
library(magrittr)
file <- "/Users/carsten/Projects/blog/_knitr/liv1.csv"
df <- read.csv(file, sep = ";") %>% mutate(karakter=as.factor(resultat)) 
{% endhighlight %}
Karakter gennemsnittet er:

{% highlight r %}
summary(df$resultat)
{% endhighlight %}



{% highlight text %}
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  -3.000   0.000   4.000   4.519   7.000  12.000
{% endhighlight %}
Følgende eksempel viser nok ikke fuldt ud potentialet for den nye %>% operator, men det giver stadig et godt indtryk af den læsevenlighed man kan opnå. Vi ser, at 7 er den mest almindelige karakter og at næsten 27% er dumpet eksamen. Dog indeholder datasættet ikke information til at afgøre om karakteren -3 er givet for en dårlig besvarelse eller for udeblivelse fra eksamen.

{% highlight r %}
oversigt <-
  df %>%
  group_by(karakter) %>%
  summarise(antal = n()) %>%
  mutate(andel=antal/sum(antal)*100) %>%
  arrange(desc(karakter))
{% endhighlight %}
Karakterne vist i et histogram

{% highlight r %}
df %>% ggplot(aes(x=karakter)) + 
  geom_histogram(fill = "grey", colour="black")
{% endhighlight %}

![center](/../images/2014-06-26-liv1-resultat-og-copenhagen-user-meetup/unnamed-chunk-4-1.png) 

Fordelingen af de beståede karakterer

{% highlight r %}
df %>% 
  filter(resultat %in% c(2,4,7,10,12)) %>%
  ggplot(aes(x=resultat)) + geom_density()
{% endhighlight %}

![center](/../images/2014-06-26-liv1-resultat-og-copenhagen-user-meetup/unnamed-chunk-5-1.png) 
