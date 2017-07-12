---
layout: post
title: C# og InfluxDB
date: '2017-05-31 19:33:00'
---
Dette er det andet indlæg i en serie på i alt 3 indlæg om monitorering af applikations metrikker med InfluxDB, Grafana og C#.

  1. [Monitorering af applikations metrikker]({% post_url 2017-05-21-monitorering-af-applikations-metrikker %})
  2. [C# og InfluxDB]({% post_url 2017-05-31-c-sharp-og-influxdb %})
  3. [Dashboards i Grafana]({% post_url 2017-07-12-dashboards-i-grafana %})

I sidste blog indlæg så vi, hvordan man kan gemme data i InfluxDB fra enten et HTTP API eller kommandolinien. Men i virkeligheden ønsker vi at gemme data fra vores applikationer som fx web services, Windows service o.lign.

Før vi ser nærmere på en løsning for C#, er der lige et par praktiske opgaver, som skal løses. I forrige indlæg blev InfluxDB databasen enten oprettet via et HTTP API eller på kommandolinien. Det vil jeg meget hellere automatisere, som oprettelsen af databasen sker som en af Docker Compose.

Docker imaget for PostgreSQL databasen har en environment variabel `POSTGRES_DB` som man kan sætte til navnet på en databasen, som så bliver oprettet via Docker. InfluxDB har tilsyneladende ikke samme feature.

Men InfluxDB understøtter [best practices](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#entrypoint) for containere ved at implementere et `ENTRYPOINT` i deres image.

Ved brug af Dockerfilen:
``` shell
FROM influxdb:1.2.4-alpine

WORKDIR /app
COPY entrypoint.sh ./
RUN chmod u+x entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]  
```

og shell scriptet `entrypoint.sh`:
``` shell
#!/usr/bin/env sh

if [ ! -f "/var/lib/influxdb/.db" ]; then
	exec influxd &

	until wget "http://localhost:8086/ping" 2>/dev/null; do
		sleep 1
	done

	influx -host=localhost -port=8086 \
		-execute="CREATE DATABASE ${INFLUX_DATABASE} "

	influx -host=localhost -port=8086 \
		-execute="CREATE USER ${INFLUX_USER} " \
		"WITH PASSWORD ${INFLUX_PASSWORD} " \
		"WITH ALL PRIVILEGES"

	touch "/var/lib/influxdb/.db"

	kill -s TERM %1
fi

exec influxd
```

kan man få oprettet en databasen som en del af Docker. Databasen navnet m.v. kommer fra konfigureringsfilen `influxdb.env`. Jeg bruger filen `.db` til at afgøre om databasen allerede er oprettet. Hvis filen findes, så er databasen tidligere oprettet. Efter at InfluxDB er startet afvikles et `until` loop indtil InfluxDB svarer, når den ping'es.

Hvis du kender en bedre måde at gøre noget tilsvarende på, så vil jeg meget gerne høre om det.

Bemærk at scriptet ovenfor opretter en priviligeret bruger med mange rettigheder. I praksis vil man nok have en dedikeret InfluxDB applikations bruger som kun har skrive (og evt læse) rettigheder.

## C\# og InfluxDB
Jeg har fundet tre Nuget pakker [InfluxDB.Client.Net](https://github.com/AdysTech/InfluxDB.Client.Net), [InfluxDB.Net](https://github.com/ziyasal/InfluxDB.Net) og [InfluxDB .NET Collector](https://github.com/influxdata/influxdb-csharp) som gør det muligt at skrive data til InfluxDB fra C#.

Mit valg er faldet på InfluxDB .NET Collector. Det er godt nok en beta release, men det er Nicholas Blumhardt fra det meget populære [Serilog](https://serilog.net) som står bag (som det tænker jeg garanterer for kvaliteten). Indtil videre har det været en positiv oplevelse af bruge InfluxDB .NET Collector.

Den første use case, som har min interesse, er en situation, hvor jeg ønsker at tage tid på en forespørgsel samt registrere antallet af records som forespørgsel returnerer. Det kunne være noget i stil med

``` csharp
public IEnumerable<string> Get(int id)
{
  var tags = new Dictionary<string, string>();
  tags.Add("CorrelationId", Guid.NewGuid().ToString());

  using (var time = Metrics.Time("Query", tags))
  {
    var records = Query(id);
    Metrics.Measure("Records", records.Count(), tags);  
    return records;  
  }
}
```

Koden findes på [GitHub](https://github.com/carsten-j/monitoring). Bemærk at C# applikationen også afvikles i Docker. Faktisk bruger jeg den ny multi stage Dockerfile feature tilgængelig fra version 17.05.

Denne giver mulighed for både at compilere C# app i Docker og samtidig skabe et kompakt Docker image. I artiklen [Builder pattern vs. Multi-stage builds in Docker](http://blog.alexellis.io/mutli-stage-docker-builds/) kan du læse mere om teknikken.

``` bash
FROM microsoft/aspnetcore-build:2.0.0-preview1 as builder
WORKDIR app
ENV ASPNETCORE_URLS http://*:5000
EXPOSE 5000
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish --output out --configuration Release

FROM microsoft/aspnetcore:2.0.0-preview1
WORKDIR /app
COPY --from=builder app/out .
ENTRYPOINT ["dotnet", "aspnetcoreapp.dll"]
```

Hvis man nu starter alle containerne med
``` bash
docker-compose up -d
```
og browser til localhost:8000 og loader siden nogle gange, så får vi nogle metrikker i InfluxDB.

Start en kommandoline adgang til InfluxDB med

``` bash
docker run --network=monitoring_network --rm --link=influxdb -it influxdb influx -host influxdb
```
hvorfra man nu kan forespørge på data med
``` bash
use myaspnetcoreapp
show measurements
select * from "Query"
select * from "Records"
```

I næste indlæg sætter jeg et dashboard op i Grafana og viser, hvordan man kan udvide det officielle Grafana Docker image med automatisk opsætning af ens dashboards.