---
layout: single
title: Rapport fra Pycon DE - dag 3
date: '2019-10-11 09:41:43'
---

Sidste dag på PyCon DE 2019. I forhold til .NET konferencer fornemmer man virkeligt en mere community-agtig atmosfære bag Python og hele øko-systemet omkring sproget. Hele konferencen er non-profit så et eventuelt overskud går tilbage til organisationen [NumFokus](https://numfocus.org/) som står bag projekter som fx NumPy og Pandas.

![center](/images/pyconde2.jpg)

## Fredag 2019-10-11

### Rethinking Open Source in the Era of Cloud & Machine Learning. Peter Wang
Key note. Masser af tanker om hvordan Open Source Software (OSS) skal forstås, og hvordan OSS kommer videre fx i et voksende community som Python.

### Introduction to automated testing with pytest. Raphael Pierzina
Da jeg allerede havde været til en tutorial om Pytest, var jeg lidt usikker på, om jeg ville lære noget nyt fra dette foredrag. Pierzina er Pytest maintainer og der var masser at lære om opbygning af test cases og organisering af test cases ved brug af fixtures og markers. Man kan mere med Pytest fixtures and med setup og teardown metoder som kendt fra xUnit. I Pytest kan en fixture fungere som dependency injection, hvor fixture funktionen bliver injected i ens test case. Markers er mærkater med metadata som kan tilknyttes test cases. Fx kan man have en skip mærkat, hvis man af eller eller anden grund ønsker at springe en test over. Men mærkater kan også bruges til at paramtrisere test cases så man nemmere kan skrive DRY kode.

### Abridged metaprogramming classics - this episode: pytest. Oliver Bestwalter
Metaprogrammering kan vist forklares ved at man bruger kode til at lave kode. Bag scenen bruger Pytest i høj grad brug af metaprogrammering. Bestwalter genskabte en lille del af Pytest ved at vise, hvordan man med Pythons metaprogrammering kan finde og eksvekvere test samt hvordan man kan dekorere test med fixtures og markers. 

### Parallel programming for python developers – Let’s Go(lang). Dominik Henter, Jéssica Lins
Jeg har længe haft kig på GoLang uden at få kigget nærmere på det. Mit første indtryk er, at GoLang på en del områder minder om Python, men der er mindst en central og afgørende forskel. Python er single-threaded hvorimod det er en hovedfeature i GoLang, at concurrency og parallelitet er bygget ind og let at bruge. Dominik og Jéssica gik gennem en live kode session, hvor de sammenlignede Python og GoLang. Desværre kom de ikke ind på, hvordan man kan kalde GoLang kode fra Python!

### Making the complex simple in data viz. Tania Vasilikioti
The Grammar of Graphics konceptet udviklet af L. Wilkinson er nok mest kendt fra R pakken ggplot2 men Python har faktisk også en pakke som understøtter The Grammar of Graphics. Den hedder [plotnine](https://plotnine.readthedocs.io/en/stable/#) og er måske værd at kigge nærmere på. 

# Opsummering
PyCon DE og PyData Berlin 2019 har været en virkelig god oplevelse. Jeg har følt mig inkluderet og hørt inspirerende foredrag og været til interessante tutorials. Jeg har fået en masse ideer til ting som jeg skal hjem og arbejde videre med. Desværre var oplæggene om Docker og Airflow sammenfaldende og her faldt valget på sessionerne om Docker. Jeg kunne godt bruge en workflow engine på arbejde til at skedulere jobs, og derfor ville det have været interessant at lære mere om Airflow, men det må blive en anden gang.

Tak for denne gang!