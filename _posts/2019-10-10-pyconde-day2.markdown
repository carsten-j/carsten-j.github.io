---
layout: single
title: Rapport fra Pycon DE - dag 2
date: '2019-10-10 15:32:25'
---

I dag var jeg primært inde og høre foredrag og kun en enkelt tutorial. Jeg fik en lille samling Anaconda lego figurer.

![center](/images/anaconda.jpg)

## Torsdag 2019-10-10

### Docker and Python - A Match made in Heaven. Dr. Hendrik Niemeyer
Niemeyer gav først en kort introduktion til Docker og Dockerfiler. Foredraget var møntet mod folk uden den store erfaring med Docker. Og derfor var det ikke særlig pædagogisk at vise Dockerfiler fyldt med begynderfejl. Jeg var der hovedsageligt for at høre anden halvdel af foredraget, som handlede om end-to-end test i Docker. Det var ganske godt og inspirerende. Jeg skal have set mere på det Python SDK som findes til Docker og i særdeleshed det plug-in til Pytest som hedder pytest-docker-compose. Nu tror jeg, at jeg ved, hvordan jeg kan lave end-to-end tests med database integration.

### 6 Years of Docker: The Good, the Bad and Python Packaging. Sebastian Neubauer
Masser af gode tips til udvikling på en lokal maskine stadigvæk i et Docker image. Jeg skal især have undersøgt alternativer til volumes som fx [docker-sync](https://docker-sync.readthedocs.io/en/latest/index.html#) og mount at Pip cache i en container.

### Dash: Interactive Data Visualization Web Apps with no Javascript. Dom Weldon
Dash komponenter er skrevet i React og det kom derfor som en overraskelse for mig, at alt Dash/Python kode eksekveres på serveren. Det har naturligvis en performance omkostning som afhængig af omstændigheder kan være acceptabel. Eksempler på Dash hjemmesiden er meget simple og giver derfor ikke svar på spørgmål som fx hvordan man kan organisere en lidt større Dash applikatione. Her havde Dom gode input, som jeg glæder mig til at udforske nærmere.

### Panel: Turn any notebook into a deployable dashboard. Philipp Rudiger
Python pakken Panel minder på mange måder om Dash. Udgangspunktet er dog her en Jupyter Notebook som man så kan gøre til en selvstændig web app. I forhold til Dash skiller Panel sig ud ved at tilbyde integration til mange flere visualiseringspakker end blot Plotly (som ligger bag Dash). Derudover har Panel et embedded mode, så man delvis kan undgå at al koden eksekveres på serveren.

### Kubernetes 101 for Python Developers. Christian Barra
K8S har helt sikkert en berettigelse, men Barra formodede ikke at levere den. For mig var denne tutorial et typisk eksempel på det, som jeg kalder teknologiforelskelse. Kubernetes er cool så lad os bruge det uden at overveje, om det er den rigtige løsning. Jeg fik dog stadig noget ud af det. Og fik blandt andet lært at man kan have flere targets i en Dockerfile.

### Dr. Schmood's Notebook of Python Calisthenics and Orthodontia. David Schmudde
Jupyter Notebooks er en fantastisk værktøj. Men det har sige svagheder som blandt andet er 1) det er svært at ræsonere om resultater fra beregningen af celler, da man ikke kan se, om cellerne er ekskvereret i rækkefølge frem til den aktive celle og 2) en af de mest udbredte datastrukturer i Notebooks, Pandas data frame er mutable (er der en godt ord på dansk for dette?). Man kan løse nogle af udfordringer i 2) ved at bruge datastrukturen [Static Frame](https://static-frame.readthedocs.io/en/latest/index.html) som alternativ til Pandas. Det er langt mere vanskeligt med 1) men det findes eksempler på Notebooks som fx [Nextjournal](https://nextjournal.com/) som giver mere reproducerbare resultater.

### Static Typing in Python. Dustin Ingram
Jeg har udviklet i Python i ca. et halvt år og til tider savner jeg den sikkerhed man får fra en kompileret sprog som er statisk checket. Derfor var det meget spændende at høre om muligheder for statiske kodecheck i Python. Jeg skal helt sikkert kigge mere på MyPy, Pytype og Pyre. Jeg har sat artiklen [Our journey to type checking 4 million lines of Python](https://blogs.dropbox.com/tech/2019/09/our-journey-to-type-checking-4-million-lines-of-python/) fra Dropbox på læselisten.
