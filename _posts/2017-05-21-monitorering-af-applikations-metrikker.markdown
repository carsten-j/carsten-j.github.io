---
layout: post
title: Monitorering af applikations metrikker
date: '2017-05-21 07:42:37'
---

Dette er det første indlæg i en serie på i alt 3 indlæg om monitorering af applikations metrikker med InfluxDB, Grafana og C#.

  1. [Monitorering af applikations metrikker]({% post_url 2017-05-21-monitorering-af-applikations-metrikker %})
  2. [C# og InfluxDB]()
  3. Dashboards i Grafana

Jeg arbejder for tiden med opsamling af en række applikations metrikker, som det er nærliggende at gemme i en [tidsserie database (TSDB)](https://en.wikipedia.org/wiki/Time_series_database) som f.eks
[Graphite](https://graphiteapp.org), [Prometheus](https://prometheus.io) eller [InfluxDB](https://www.influxdata.com).
Ved brug af visualiseringsværktøjer som fx Graphite, [Grafana](https://grafana.com), og [Chronograf](https://www.influxdata.com/products/open-source/#chronograf) kan man nemt danne sig et overbliv over den historiske udvikling i ens metrikker. 

Vores platform team har allerede sat miljøer op med InfluxDB og Grafana, så det er nemt at komme igang. Dette blog indlæg handler om installation og opsætning af InfluxDB. Det skal understreges, at jeg ikke ved, hvordan InfluxDB er sat op på mit arbejde. 

Et senere indlæg kommer til at handle om dashboards i Grafana. Jeg bruger Docker til at installere både InfluxDB og Grafana. Min Docker compose fil ser således ud:

``` shell
version: '3'

networks:
  default:
    external:
      name: monitoring_network

services:

  influxdb:
    image: influxdb:latest
    container_name: influxdb
    ports:
      - "8086:8086"
    volumes:
      - ./data/influxdb_data:/var/lib/influxdb

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
    links:
      - influxdb
    volumes:
      - ./data/grafana_data:/var/lib/grafana
```

På forhånd har jeg lavet et nyt (Docker) netværk med kommandoen. Hvis man ikke bruger et eksplicit netværk vil Docker Compose lave et netværk med navn `<project_folder>_default`.

``` shell
docker network create --driver bridge monitoring_network
```

I tidligere version af Docker imaget for InfluxDB var der er webbaseret adminstrator interface. Dette bliver imidlertidig fjernet fra version 1.3. Jeg vil derfor vise, hvordan man enten kan bruge et HTTP API eller kommandolinien til at interagere med InfluxDB.
I et senere indlæg ser vi, hvordan man kan indsætte data fra C#.

### HTTP API

Først oprettes en database
``` shell
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE mydb"
```
og dernæst indsættes en måling
``` shell
curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary 'cpu_load,host=server01,region=north-europe value=0.42 1495351205000000000'
```

### Kommandolinien

På kommandolinien udføres
``` shell
docker run --network=monitoring_network --rm --link=influxdb -it influxdb influx -host influxdb
```
hvor `--network` sættes til navnet på ens Docker netværk og `--link` skal være container navnet for InfluxDB som angivet i Docker Compose filen.

Man kan så oprette en database med 
``` shell
CREATE DATABASE mydb
```
og indsætte en record med
``` shell
USE mydb
INSERT cpu_load,host=server01,region=north-europe value=0.42
```
Hvis man vil se sine metrikker, kan man få et overblik med
```
SHOW MEASUREMENTS
```
og data kan hentes med en SQL lignende syntax
```
SELECT * FROM cpu_load
```

I næste indlæg ser jeg på, hvordan man kan sende data til InfluxDB fra et C# program.

Koden findes på [GitHub](https://github.com/carsten-j/monitoring).