---
layout: post
title: Lær MongoDB på 8 uger
date: '2013-10-30 21:29:37'
categories: [mooc,nosql,mongodb]
---
[MongoDB University](https://education.mongodb.com/) har et godt tilbud til dig! Et introduktionskursus til den populære noSQL database MongoDB på bare 8 uger. Det startede i sidste uge, så man kan stadig nå at være med. Den eneste forudsætning er basal viden om JavaScript og NodeJS.

<!--more-->

![center](/images/mongoDB.png)

Kan det virkelig passe at der ikke er nogen simpel måde at vælge det dokument i en Mongo kollektion, hvor et givet felt har minimum værdien i hele kollektionen? Skal man bruge `sort` og `limit` til dette? Fx som i

{% highlight javascript %}
db.weather.find( { "Wind Direction" : { $gte : 180, $lte: 360}} , {State : true, Temperature : true} ).sort( { Temperature: 1 } ).limit(1)
{% endhighlight %}

Det må da kunne gøres mere elegant!

**Opdatering 31/10-2013**

Der findes to andre måder at finde minimum for et givet felt. Så man har altså tre teknikker til at bestemme minimum:

1. `find(<query>).sort(...).limit(1)`
* aggregate framework med `group`og `$min`operator
* map reduce framework

Hvis man skal finde absolut minimum for et felt uden nogen form for gruppering, så bruger man metode 1. ellers vælges 2. Map reduce benyttes kun for situationer, hvor det er umuligt at bruge de to andre teknikker.


