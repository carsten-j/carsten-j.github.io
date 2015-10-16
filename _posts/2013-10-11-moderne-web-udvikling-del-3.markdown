---
layout: post
title: Moderne web udvikling - del 3
date: '2013-10-11 19:00:33'
categories: [webDevelopment,node.js,javascript]
---
Sommetider siger en tegning mere end 1000 ord.

<!--more-->

![center](/images/node.js.jpg)

1. indgående request bestående af task og callback funktion.
2. V8 engine checker om der er tale om I/O request. Event loop er single threaded.
3. hvis ja sendes request videre til libuv / thread pool.
4. på et tidspunkt bliver backend / thread pool færdig med request og sender response/event med callback.
5. når V8 næste gang har tid behandles response/callback og
6. sendes tilbage til klient

Det opsummerer min nuværende forståelse af Node’s virkemåde.