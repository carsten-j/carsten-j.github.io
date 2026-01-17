---
layout: single
title: "Dashboards i Grafana"
date: '2017-07-12 19:53:42'
---
Dette er det trejde og sidste indlæg i en serie om monitorering af applikations metrikker med InfluxDB, Grafana og C#.

  1. [Monitorering af applikations metrikker]({% post_url 2017-05-21-monitorering-af-applikations-metrikker %})
  2. [C# og InfluxDB]({% post_url 2017-05-31-c-sharp-og-influxdb %})
  3. [Dashboards i Grafana]({% post_url 2017-07-12-dashboards-i-grafana %})

Hvis du kender Elastic stakken, så kan du tænke på Grafana som et modstykke til Kibana. Grafana kan bruges til at lave visualiseringer og dashboards med data fra en række forskellige datasources.

De centrale begreber i Grafana er datasources og dashboards. En datasource peger på en kilde indeholdende data, mens et dashboard er en visualisering af data.

Der findes naturligvis et officielt Docker image for Grafana. Men hvis man skal have et fuld automatisk deployment af ikke bare selve Grafana, men også ens datasources og dashboards, så er man nød til selv at bygge et Docker image.

Grafana har et HTTP API, hvor man kan oprette datasources hhv. dashboards. Lad os se, hvordan det fungerer for en datasource. Jeg bruger samme "skabelon" af en shell script, som det der blev brugt til lave InfluxDB image'et.

I Dockerfilen
``` bash
FROM grafana/grafana:4.4.1

RUN apt-get update && apt-get install -y jq gettext

WORKDIR /etc/grafana
ADD datasources ./datasources  
ADD dashboards ./dashboards  

WORKDIR /app  
COPY entrypoint.sh ./  
RUN chmod u+x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
```
Konfigurationsfilen for Grafana findes i Docker image'et i folderen `/etc/Grafana`, så det virker oplagt at placere dashboards og datasources i en
underfolder til denne.

Her kopierer vi JSON repræsentationer af både datasources og dashboards til Docker image'et. Samtidig installeres `jq` og `gettext`. Mere herom senere.

``` bash
#!/usr/bin/env sh
if [ ! -f "/var/lib/grafana/.db" ]; then

    url="http://${GRAFANA_USER}:${GRAFANA_PASSWORD}@localhost:3000/"

    exec /run.sh $@ &

    # consider exiting to avoid infinite loop
    until curl -s ${url}"api/datasources" 2>/dev/null; do
        sleep 2
    done

    # try with -u for user:password
    for datasource in /etc/grafana/datasources/*.json; do
        curl "${url}api/datasources" \
            POST -H 'Content-Type: application/json' \
            --data "$(envsubst <$datasource)"
    done

    touch "/var/lib/grafana/.db"

    kill $(pgrep grafana)

fi

exec /run.sh $@
```

Udtrykket `envsubst <$datasource` erstatter environment variable fra datasource JSON filen med de variable som er defineret i `configuration.env` filen, som refereres i `docker-compose` filen. `envsubst` er en del af `gettext` som blev installeret i Docker image'et.

Men først vil jeg vise, at ovenstående script rent faktisk har fået sat en datasource op. Og dernæst viser jeg, hvordan man laver et dashboard. Så kan jeg eksportere dette dashboard og demonstrere, hvordan man kan importere det med et HTTP API kald. Det hele fremgår af denne screencast:

<div style="text-align:center" markdown="1">
<iframe width="560" height="315" src="https://www.youtube.com/embed/MdiaxvsAqI4" frameborder="0" allowfullscreen></iframe>
</div>

Det er vanskeligere at lave dashboards end datasources, da det format man via GUI'en kan eksporter, ikke er det samme JSON format, som det man bruger i HTTP API kaldet. Heldigvis er det let at transformere JSON filer med værktøjet [jq](https://stedolan.github.io/jq/).

På Grafanas website kan man se, hvilket JSON format datasources skal have til HTTP API kaldet. Denne tilføjelse

``` bash
for dashboard in /etc/grafana/dashboards/*.json; do
    dashboard_json=$(transform_dashboard_json $dashboard)
    curl "${url}api/dashboards/db" \
        POST -H 'Content-Type: application/json' \
        --data "$dashboard_json"
done
```
gør, at der nu også bliver lavet dashboards, når Docker image'et bliver bygget.

I følge dokumentationen for Grafana er det også muligt at tilføje dashboards via Konfigurationsfilen. Det har jeg ikke fået til at virke. Hvis du ved, hvordan det fungerer, så hører jeg meget gerne mere fra dig.

Jeg behandler her dashboards som kode, og man bør derfor overveje, om det giver værdi at versionsstyre sine dashboards. Desværre er JSON ekport af dashboards ikke umiddelbart til at rette i manuelt via en editor.

En Google søgning giver dog ikke mange løsninger på denne udfordring, Jeg kan kun finde to værketøjer, et i [Python](https://github.com/weaveworks/grafanalib) og et i [Go](https://www.djouxtech.net/posts/creating-grafana-dashboards-with-golang/) som adresserer dette. Ingen af disse virker til at være særligt aktive under udvikling.

Hvis man har mange dashboards at administrere, er der lidt hjælp at hente fra dette [tool](https://utkarshcmu.github.io/wizzy-site/home/use-cases/), som man fx kan bruge til at flytte dashboards fra en Grafana installation til en anden.

Dette var afslutningen på serien om monitorering af applikations metrikker med C#, InfluxDB og Grafana. Både InfluxDB og Grafana virker som modne teknologier, der er veldokumenterede og nemme at komme i gang med.

Den endelig version af koden findes på [GitHub](https://github.com/carsten-j/monitoring/releases/tag/v1.0),
