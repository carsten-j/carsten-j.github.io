---
layout: post
title: "Raft og konsensus"
date: 2015-05-25 21:57:38 +0200
categories:  AkkaNET C# Raft algoritme distribueret Elasticsearch
---
[The morning paper](http://blog.acolyer.org/2015/03/01/cant-we-all-just-agree/) bragt for nogle måneder siden en række artikler om konsensus. Igennem flere år har [Paxos](https://en.wikipedia.org/wiki/Paxos_%28computer_science%29) være anset for standard algoritmen på området, men jeg husker tydeligt fra et kursus om distribuerede systerm på ITU, hvor vanskeligt det er at forstå både hvordan og hvorfor Paxos rent faktisk virker efter hensigten. Jeg blev derfor interesseret i en ny algoritme, Raft, som blev omtalt i ovenstående artikelserie. Raft virker både nem at forstå og ikke mindst at forklare, hvilket også bakkes op af studier [3].

<!--more-->

## Hvad betyder konsensus?

[Gyldendal Den store danske](http://www.denstoredanske.dk/Samfund,_jura_og_politik/Sociologi/Grupper/konsensus) omtaler konsensus som:

> overensstemmelse mellem medlemmerne i et socialt system

hvilket ikke gør os meget klogere i forhold til konsensus betragtet som et fænomen i software.

I modsætning til en social definition, hvor man i sidste ende kan acceptere, at vi bliver enige om regler for konsensus undervejs, så er der behov for en mere striks definition, hvis begrebet konsensus skal overføres til software.

I Introduction to Reliable and Secure Distributed Programming [1] defineres konsensus som følger:

Konsensus består af et forslag og en beslutning. En eller flere processer stiller et forslag som resten eller flertallet af resten af processerne er enige i. Udover et forslag og en række beslutninger omfatter konsensus også følgende egenskaber:

* Termination: Every correct process eventually decides some value.
* Validity: If a process decides v, then v was proposed by some process.
* Integrity: No process decides twice.
* Agreement: No two correct processes decide differently.

Egenskaberne omkring afslutning og integritet sikrer at processor tager præcis en beslutning. Gyldigheds egenskaben er med for at sikre at en proces ikke tager en beslutning som der ikke har været stillet forslag om. Alle fire egenskaber er vigtige men det må siges at være egenskaben enighed som for alvor definerer konsensus.

Hvis det man skal være enig om kan ændres over tid, så er det nødvendigt på en eller anden måde også at blive enige om tiden. Men som bekendt: "There is No Now" [5]. Dette er i øvrigt en glimrende kortfattet introduktion til begrebet tid i et distribueret system perspektiv. I Raft er det heldigvis ikke nødvendigt at være enige om det absolutte tidspunkt. Algoritmen er beskrevet i termer af perioder, hvilket gør det hele noget lettere.

Jeg har tidligere skrevet om mine oplevelser med Coursera kurset [Principles of Reactive Programming](  {% post_url 2014-01-06-principles-of-reactive-programming %}), hvor en del af indholdet var fokuseret mod [Akka](http://akka.io/). For nyligt er Akka blevet porteret til .NET platformen under navnet [Akka.NET](http://getakka.net/). Der findes allerede flere implementeringer af Raft baseret på [Scala og Akka](https://www.google.dk/search?q=scala%20akka%20raft&rct=j), så det var jo en oplagt ide at implementere (dele) af Raft med brug af Akka.NET.

# Raft
Raft er en distribueret konsensus algoritme som bruges i sammenhæng med en replikeret tilstandsmaskine. I et sådan setup replikeres en  tilstandsmaskiner på en række af servere og hver tilstandsmaskine kan operere uafhængig af de andre tilstandsmaskiner. Den distribuerede konsensus algoritme sikre at tilstandsmaskinerne (på et eller andet tidspunkt) har den samme tilstand også selvom flere af servere er nede eller af anden grund ikke svarer. Typisk vælger man 5 eller 7 noder, da dette tillader 2 til 3 serveren af være nede uden at algoritmen mister evnen til at træffe en flertalsbeslutning.

Du kan læse mere om Raft [her](https://raftconsensus.github.io/), og hvis du foretrækker en visuel forklaring så findes denne [illustration](http://thesecretlivesofdata.com/raft/).

Som jeg forstår det kan man ikke implmentere en konsensus algoritme, der opfylder ovenstående egenskaber i et asynkront setup. Raft kommer (igen som jeg forstår det) uden om dette ved at indføre en vis grad af tilfældighed i algoritmen. Fx har hver enkelt node har en follower timeout som med en indbygget grad af tilfældigt er med til at sikre, at ikke alle noder på stort set samme tidspunkt har timeout.

I Raft er hver enkelt server i en af tre tilstande: follower, candidate eller leader. Tilstandsmaskine for disse ser således ud:

![center](/images/raftStates.png)

Her ses et meget simpelt eksempler, hvor clusteret lige er startet op. Node 5 er efter en timeout periode end i candidate tilstanden og efter at have stemt på sig selv sender den en request vote besked til de resterende servere. Node 1 og 3 svarer og med i alt 5 noder er det nok at have et positivt svar fra i alt 2 noder udover noden selv. Node 5 er derfor her valgt som leder og vil ændre tilstand herefter.

![center](/images/raftElection.png)

## Implementering
Du kan finde en kopi af min implementering på [GitHub](https://github.com/carsten-j/Raft). Bemærk at jeg først lige er startet med Akka.NET, så der er sikkert kode som kan skrives enten smartere eller bedre. Forslag til forbedringer er som altid meget velkomne. Koden virker på OSX med Mono 4.0.1 og Xamarin Studio. Notationen i programmet lægger sig tæt op af [6].

## Test

Principielt kan man kun kommunikere med at actor ved at sende en besked. Hvordan automatiserer man test i et sådan system?

På nuværende tidspunkt finder man ikke meget om test i [dokumentationen](http://getakka.net/articles/intro/what-is-akka.html) for Akka.NET. Men da Akka.NET er en portering af Akka kan man lade sig inspirere af [dokumentation](http://doc.akka.io/docs/akka/snapshot/scala/testing.html) her. Der skelnes mellem unittests og integrationstest og du kan i mit Github repository for dette indlæg se et enkelt eksemplel på en integrationstest, hvor der testes at et givent Raft cluster har valgt en leder. Hvis du ved noget om test i asynkrone systemer baseret på Akka så hører jeg meget gerne om teststrategier.

## Logging

I et distribueret system vil mange af processerne som oftest ikke have en GUI, hvortil fejlbeskeder og lignende kan præsenteres. Evnen til at logge bliver derfor central. Akka.NET har flere muligheder på dette [område](http://getakka.net/articles/utilities/logging.html), hvor man blandt andet kan bruge logging frameworket [Serilog](http://serilog.net/).

Serilog passer fint ind i [ELK stakken](https://www.elastic.co/webinars/introduction-elk-stack).  I ELK står E for Elasticsearch som jeg tidligere har skrevet om her på [bloggen]({% post_url 2014-06-28-elasticsearch-the-definitive-guide %}). På OSX kan Elasticsearch installeres med

> brew install elasticsearch

fra en kommandolinie og herefter startes med

> ./bin/elasticsearch

Serilog kan skrive direkte til Elasticsearch, så der er i denne sammenhæng ikke behov for at bruge [Logstash](https://www.elastic.co/products/logstash) til log konsolidering.

På et nyligt overstået [meetup](http://www.meetup.com/Copenhagen-Net-User-Group/events/221363633/) møde demo'ede [Thomas Ardal](https://twitter.com/thomasardal) ELK stakken med Serilog, og han viste nogle ret cool dashboards fra [Kibana](https://www.elastic.co/products/kibana). Hvis man har behov for en GUI til Elasticsearch vil jeg anbefale [elasticsearch-gui](https://github.com/jettro/elasticsearch-gui) som er et plugin til Elasticseach.

Struktureret logning er også anbefalet af ThoughtWorks [Tech Radar](http://www.thoughtworks.com/radar/techniques/structured-logging) i begge 2015 udgaver.

## Næste skridt

Det er ikke utænkeligt at der kommer en opfølgning til dette indlæg, når funktionaliteten i Akka.NET bliver mere udviklet og bedre dokumenteret. Fx kunne det være oplagt at tage fat på emner som:

* Remoting
* Cluster
* Persistens storage
* Dynamic membership
* F# version

## Disclaimer
Lad være med at bruge din egen implementering af algoritmer som Raft og lignende. Det er ikke let at få dem implementeret korrekt og du bør fokusere på det som giver værdi for din forretning fremfor de bagvedliggende algoritmer. Det er til gengæld en udmærket ide at implementere Raft eller lignende, hvis du ønsker en bedre forståelse for virkemåden i algoritmen end man kan få alene ved at læse en artikel. Derfor. Koden på Github for dette blogindlæg er på ingen måde klar til produktion og afspejler heller ikke måden, jeg ville gribe implementeringen af produktionskode an på.

## Hvis du vil vide mere!

Hvis du vil videre mere om Akka.NET så er der den 28. maj et meetup møde med titlen [Scale Up and Out wiht Akka.NET](http://www.meetup.com/Copenhagen-Net-User-Group/events/221363653/) i København, hvor [Roger Alsing](https://twitter.com/rogeralsing) fortæller mere om Akka.NET.

## Hvis du vil vide endnu mere!

[1] Introduction to Reliable and Secure Distributed Programming, Christian Cachin, Rachid Guerraoui og Luis Rodgigues

[2] Raft Refloated: Do We Have Consensus?, Heidi Howard m.fl.

[3] In Search of an Understandable Consensus Algorithm (Extended Version), Diego Ongaro og John Ousterhout

[4] ARC: Analysis of Raft Consensus, Heidi Howard

[5] There is No Now, ACM Queue, Justin Sheehy

[6] Raft Pseudocode, https://github.com/ongardie/raft-pseudocode

[7] TLA+ specification for the Raft consensus algorithm, https://github.com/ongardie/raft.tla

[8] A Summary of TLA+, Leslie Lamport

[9] ZooKeeper, Distributed Process Coordination, Flavio Junqueira og Benjamin Reed
