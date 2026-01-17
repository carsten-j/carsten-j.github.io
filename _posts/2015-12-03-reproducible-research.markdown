---
layout: single
title: Reproducerbar forskning
date: 2015-12-03 21:13:51 +0200
---
Titlen på det 5. kursus i Data Science programmet på Coursera er "Reproducible Reseach" [^1]. Måske ville det være mere korrekt at kalde kurset enten Reproducible Data Analysis (RDA) eller Literate Statistical Programming (LST) fremfor Reproducible Research (RR). 

I begrebet reproducerbar forskning ligger der vel både at man 

1. kan (gen-)beregne resultaterne og ikke mindst 
2. at man kan genskabe forsøget med samme konsistente resultat. 

Kurset "Reproducible Reseach" handler alene om muligheden for at genberegne resultater, og derfor ville det være at foretrække med en lidt mere sigende kursustitel.

# Reproducerbar data analyse
Der indgår (mindst) fire elementer i begrebet reproducerbar data analyse. Hvis det skal være muligt for andre at checke og kontrollere ens beregninger kræver det adgang til:

* Det rå datasæt
* Koden brugt til beregningerne
* Dokumentation af både datasæt og kode

Derudover skal man have en uafhængig både at 

* distribuerede ovennævnte elementer på 

Der er flere eksempler på websites som udbyder reproducerbar data analyse som en service. Prøv fx at kigge på [LCAV Reproducible Research Repository](http://rr.epfl.ch/).

Ideen om Literate Statistical Programming kommer fra Literate Programming som især er kendt fra Donald E. Knuths [artikel](http://www.literateprogramming.com/knuthweb.pdf) om emnet. Den grundliggende ide er at kombinere maskinlæsbar programmeringssprog og menneskelæsbar tekst i et samlet dokument og så ved hjælp af to værktøjer 'weave' og 'tangle' kunne skabe enten et rent maskinlæsbart eller menneskelæsbart dokument.

# Værktøjer

De centrale værktøjer i kurset er Git, Markdown og Knitr. De to første har jeg allerede omtalt i forbindelse med tidligere blog indlæg om data science specialiseringen. 

## Knitr
[Knitr](http://yihui.name/knitr/) udvidelsesbibliotektet bygger på literate programming tankegangen. Man kombinere tekst skrevet i markdown med R kode. Når man så 'knitr' ens dokument får man ikke bare R koden med i output med og resultatet af at afvikle koden inkl fx plot og grafer. Man kan både generere output i HTML og PDF format.

RStudio understøtter knitr, men ikke som wysiwyg editor. Når man har tilføjet enten ny tekst eller R kode er det nødvendigt at "knitr'e" igen. Det kan i længden føles som en lidt tung proces. Hvis man hellere vil skrive i et mere interaktivt miljø kan det anbefales at installere udvidelsesbibliotektet [editR](https://github.com/swarm-lab/editR). Men editR kan man have side-by-side editering og visning af det færdige resultat. EditR er fortsat under udvikling og ikke 100% stabil.

For en mere fuldstændig gennemgang af knitr henvises til [3].

## Reproducerbare data
Hvis du har brug for tilfældige men alligevel reproducerbare data, så vil jeg anbefale at du tager et kig på udvidelsesbiblioteket [Wakefield](https://github.com/trinker/wakefield) og ser på fx dette [eksempel](http://blog.revolutionanalytics.com/2015/11/using-the-wakefield-package-to-easily-generate-reproducible-sample-data.html).

Hvis du vil læse mere om reproducerbar forskning kan jeg anbefale websitet [Reproducible Research](http://reproducibleresearch.net/)

# Andre initiativer
Der findes andre områder end forskning, hvor man også interesserer sig for reproducerbare løsninger. Her er et eksempler hentet fra [data-drevet journalistik](http://thegamma.net/)

Hvis du bruger [StackOverflow](https://stackoverflow.com/) ved du allerede, at svarene bliver bedre jo mere præcis du selv er i stand til at formulere et spørgsmål og give et konkret eksempel. Det handler altså i bund og grund også om at kunne reproducere et eksempel. Næste gang du skal stille et R relateret spørgsmål, bør du tage et kig på udvidelsespakken [repexp](https://github.com/jennybc/reprex). Navnet repexp henviser til {repr}oducible {ex}ample, og er navngivet af Romain Francois på [Twitter](https://twitter.com/romain_francois/status/530011023743655936).

## Referencer

[1] Reproducible Research with R and RStudio (Second Edition), Christopher Gandrud, CRC Press/Chapman & Hall, 2015. Man kan selv "reproducere"" denne bog via bogen [GitHub](https://github.com/christophergandrud/Rep-Res-Book) side 

[2] Implementing Reproducible Research, Victoria Stodden, Friedrich Leisch, Roger D. Peng, CRC Press/Chapman & Hall, 2014. Denne bog findes også i en online udgave på [https://osf.io/s9tya/](https://osf.io/s9tya/)

[3] Dynamic Documents with R and knitr, Second Edition,  Yihui Xie, Chapman & Hall/CRC The R Series, 2015.

## Fodnoter
[^1]: Det bliver det sidste indlæg fra data science specialisering programmet for et stykke tid. Jeg har fået nyt [job]({% post_url 2015-11-30-nyt-job %}), og indtil jeg er kommet godt i gang med det, tager jeg ikke flere data science kurser på Coursera.

