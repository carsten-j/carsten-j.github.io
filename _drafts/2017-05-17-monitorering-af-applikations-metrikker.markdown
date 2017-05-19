---
layout: post
title: Monitorering af applikations metrikker
date: '2017-05-17 15:22:39'
---

Jeg arbejder for tiden med opsamling af en række applikations metrikker, som det er nærliggende at gemme i en [tidsserie database (TSDB)](https://en.wikipedia.org/wiki/Time_series_database) som f.eks
[Graphite](https://graphiteapp.org), [Prometheus](https://prometheus.io) og [InfluxDB](https://www.influxdata.com).
Ved brug af visualiseringsværktøjer som fx Graphite, [Grafana](https://grafana.com), og [Chronograf](https://www.influxdata.com/products/open-source/#chronograf).

Vores platform team har allerede sat miljøer op med InfluxDB og Grafana, så det er nemt at komme igang. Dette blog indlæg handler om installation og opsætning af InfluxDB ,og det skal understreges, at jeg ikke ved, hvordan InfluxDB er sat op på mit arbejde. 

Et senere indlæg kommer til at handle om dashboards i Grafana. Jeg bruger Docker til at installere både InfluxDB og Grafana. Min Docker compose fil ser således ud

```
version: '3'

networks:
  default:
    external:
      name: my_isolated_bridge_network

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

På forhånd har jeg lavet et nyt netværk med kommandoen

```
docker network create --driver bridge my_isolated_bridge_network
```

wiki: A time series database (TSDB) is a software system that is optimized for handling time series data, arrays of numbers indexed by time

Time-Series Database (TSDB).

Graphite (again), Grafana, Kibana, 



config fil genereres med
docker run --rm influxdb influxd config > influxdb.conf


hvis man ikke bruger et netwærk, så danner compose et med navn {foldername}_default

When you run docker-compose up, the following happens:

A network called myapp_default is created.
A container is created using web’s configuration. It joins the network myapp_default under the name web.
A container is created using db’s configuration. It joins the network myapp_default under the name db.

https://docs.docker.com/compose/networking/


Control-a k
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty


docker-compose up -d
docker-compose stop

I tidligere version af Docker imaget for InfluxDB var det er web baseret adminstrator interface. Det er deprikeret fra version 1.1 og bliver fjernet i version 1.3. Jeg vil derfor vise, hvordan man enten kan bruge et HTTP API eller kommandolinien til at interagere med InfluxDB.

### HTTP API

Først opretter vi en database
```
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE mydb2"
```
og dernæst indsætte en måling
```
curl -i -XPOST 'http://localhost:8086/write?db=mydb' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000000'
```

### Kommandolinien

Commandline
docker run --network=my_isolated_bridge_network --rm --link=influxdb -it influxdb influx -host influxdb
link=influxdb match with compose file

Her skal ``network`` være identisk med det netværk som benytter i Docker compose filen og ``link`` skal sættes til det container navn som man har valgt for InfluxDB - her er det blot ``influxdb``.

Man kan så oprette en database med 
```
create database foobar
```
og indsætte en record med
```
use foobar
INSERT treasures,captain_id=pirate_king value=2
```
Hvis man vil se sine metrikker, kan man få et overblik med
```
show measurements
```
og data kan hentes med en SQL lignende syntax
```
select * from treasures
```

I næste indlæg ser jeg på, hvordan man kan sende data til InfluxDB fra et C# program.