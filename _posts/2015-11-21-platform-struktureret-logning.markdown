---
layout: post
title: Arkitektur ideer til en skalerbar platform for struktureret logging
date: 2015-11-21 20:13:51 +0200
---
Jeg har for nylig kigget på en case omkring logning, hvor en applikation asynkront skulle logge til en fil. Logning er for de flestes vedkommende næppe et kerne forretningsområde, hvorfor standard løsninger vil være at foretrække. Man bør fokusere på det som for alvor giver værdi!

Tidligere i år var jeg til et arrangement i [Copenhagen .NET User Group](http://www.meetup.com/Copenhagen-Net-User-Group/events/221363633/), hvor [Thomas Ardal](https://twitter.com/thomasardal) fortalte om [Serilog](http://serilog.net/) og Elasticsearch.

Serilog er et .NET bibliotek til struktureret logning. Hvis man for alvor skal skabe værdi af informationer i logfiler, skal man have en struktureret tilgang til det at danne logs. Informationerne i logfilerne kan ikke bare være fritekst, men skal have et fast format og struktur. Serilog giver selv dette lille eksempel på deres website:

{% highlight csharp %}
var position = new { Latitude = 25, Longitude = 134 };
var elapsedMs = 34;

log.Information("Processed {@Position} in {Elapsed:000} ms.",
                position, elapsedMs);
{% endhighlight %}
som resulterer i dette JSON format:
{% highlight json %}
{"Position": {"Latitude": 25, "Longitude": 134}, "Elapsed": 34}
{% endhighlight %}
Hvordan det præsenteres i en log afhænger af, hvor man sender data hen.

Formatet som gives til `log.Information` metoden kan ses som et simpelt DSL[1] udvidelse af .NET platformen streng formattering.

Hvilke krav skal man stille til en log platform? Der er sikkert mange, og flere end jeg lige nævner her. Men personligt ville jeg kigge efter muligheden for at

1. finde standard løsninger
2. have support for struktureret logging
3. samle logs fra mange forskellige systemer og applikation
4. kunne korrelerer logs fra forskellige kilder
5. håndtere ustabilitet i netværket uden at miste information
6. lave visualisering og/eller dashboards
7. analyse af begivenheder i noget der er tæt på realtid

På internettet er der rigtig meget snak om [ELK stakken](https://www.elastic.co/webinars/introduction-elk-stack) som en standard løsning for en log platform. Hovedparten af førnævnte krav er understøttet af ELK, og dette skal ikke være en detaljeret gennemgang af denne stak, men her kommer en ultrakort introduktion.

### Elasticsearch
[Elasticsearch](https://www.elastic.co/products/elasticsearch) er en server platform bygget på [Apache Lucene](https://lucene.apache.org/core/). Platformen tilbyder fuld-tekst søgninger og real-time analytics via et HTTP web interface. Data gemmes i et skemafrit JSON format. Jeg har tidligere skrevet et kort anmeldelse af bogen [Elasticsearch - The Definitive Guide]({% post_url 2014-06-28-elasticsearch-the-definitive-guide %}). Elasticsearch dækker krav 1, 4, og 7.

### Logstash
[Logstash](https://www.elastic.co/products/logstash) er en dataflow engine som kan processere logfiler og event data fra et utal af systemer. Arkitekturen i Logstash er bygget over 'pipes and filter' mønsteret, se fx [2].

![center](/images/logstash.png)

Plugins er hovedsageligt konfigurationsfiler som indlæses ved opstart af Logstash servicen. Logstash understøtter krav 1, 3, og 4.

### Kibana
[Kibana](https://www.elastic.co/products/kibana) er en analyse og visualisering platform som kører i en webbrowser. Man kan i en vis forstand se Kibana som en 'self-service' platform, da det ikke kræver programmering at udvikle dashboards og visualiseringen. Dette foregår alt sammen via konfigurering i webbrowseren. Kibana understøtter krav 6 og 7.

Se fx denne [artikel](http://blog.webkid.io/visualize-datasets-with-elk/) for et illustrativt lille eksempel på brugen af ELK stakken. ELK stakken er ikke .NET baseret, men den er supporteret på Windows.

Vi mangler at opfylde krav 2 og 5. Det er her, at Serilog [^1] kommer ind i billedet med support for struktureret logning. Serilog kan faktisk sende data direkte til Elasticsearch, men vælger man den løsning mister den support som Logstash giver for en række andre datakilder, som ikke kan kommunikere direkte med Elasticsearch.

Hvorfor har vi egentligt det 5. krav? Tidligere i år deltog jeg i kurset [Advanced Distributed Systems Design]({% post_url 2015-09-18-lessons-learned-from-advanced-distributed-systems-design-course %}), hvor vi brugte det meste af en formiddag på at gennemgå de [8 fejlslutninger (fallacies)](https://pages.cs.wisc.edu/~zuyu/files/fallacies.pdf) i distribuerede systemer. En af dem er

>  The network is reliable.

Hvis vi har et krav om at data ikke må gå tabt bliver vi nød til aktivt at understøtte det krav. Ellers vil vi før eller siden miste data pga ustabilitet i netværket.

Den udvidede dataflow for log informationer ender derfor med at være

![center](/images/dataflow.png)

Hvor vi udover ELK stakken og Serilog har tilføjet et message queue til persistering af logfiler.

Som message queue tænker jeg på at bruge [RabbitMQ](https://www.rabbitmq.com/) som dels har et input plugin til Logstash og RabbitMQ har fint support på .NET platformen. Her er en fin serie på [10 indlæg](http://dotnetcodr.com/2014/04/28/messaging-with-rabbitmq-and-net-c-part-1-foundations-and-setup/) om brugen af RabbitMQ i C#. Derudover kan RabbitMQ sikre persistens af logbeskeder, og der er understøttelse for publish / subscribe, så man kan sende logs asynkront til RabbitMQ fra ens C# applikation.

Hvis man ikke har brug for at persistere logfiler ville jeg overveje [Redis](http://redis.io/) som et alternativ til RabbitMQ. Redis er in-memory, hvilket giver god performance. Hvis man ikke er bundet af Windows platformen kunne det også være interessant at kigge nærmere på [Kafka](https://kafka.apache.org/). Logstash har input plugins til både Redis og Kafka.

Den overordnede arkitektur ender med at være som her

![center](/images/logplatform.png)

Den eneste komponent i løsningen som vi endnu ikke har talt om er 'shipper' [^2]. Et udtryk som man bruger hvis fx `App 1` af en eller anden grund ikke kan kommunikere direkte med RabbitMQ, og derfor har brug for en alternativ måde at kommunikere med RabbitMQ på.

Det samlede dataflow minder på rigtig mange måder og Extract, Transform, Load (ETL) processen fra data warehouses.

Da så godt som alle elementer i arkitekturen er standard løsninger vil de formodentligt uden videre kunne indarbejde i et devops scenario med fx [Puppet](https://puppetlabs.com/).

## Referencer

[1] Martin Fowler. Domain-specific language. Addison-Wesley Professional, 2010.

[2] Gregor Hohpe og Bobby Woolf. Enterprise Integration Patterns. Designing, Building, and Deploying Messaging Solutions. Addison-Wesley Professional, 2004.

[3] Jay Krebs. I Heart Logs. Event Data, Stream Processing, and Data Integration. O'Reilly, 2015.

[4] Martin Kleppmann. [Using logs to build a solid data infrastructure](http://www.confluent.io/blog/using-logs-to-build-a-solid-data-infrastructure-or-why-dual-writes-are-a-bad-idea/).

[5] Jay Krebs. [The Log: What every software engineer should know about real-time data's unifying abstraction](https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying).

## Links
[Load Balancing Logstash With AMQP](http://blog.lusis.org/blog/2012/01/31/load-balancing-logstash-with-amqp/)

[Using logstash, ElasticSearch and log4net for centralized logging in Windows](http://www.ben-morris.com/using-logstash-elasticsearch-and-log4net-for-centralized-logging-in-windows/)

[Dr. Strangelog (or: How I learned to stop worrying and Love the Logs)](http://steffen.sunlyng.net/post/dr-strangelog-or-how-i-learned-to-stop-worrying-and-love-the-logs1)

[ActiveMQ as a Message Broker for Logstash](http://blog.florian-hopf.de/2015/07/activemq-as-message-broker-for-logstash.html)

## Fodnoter

[^1]: Alternativer til Serilog kunne være: [Seq](https://getseq.net/), [Nlog](http://nlog-project.org/) og [Log4net](https://logging.apache.org/log4net/).

[^2]: Firmaet Elastic som står bag ELK stakken har for nyligt frigivet [Filebeat](https://www.elastic.co/products/beats/filebeat) som er en letvægts shipper komponent.
