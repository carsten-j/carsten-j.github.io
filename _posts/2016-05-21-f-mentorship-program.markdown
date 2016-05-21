---
layout: post
title: F# Mentorship program
date: '2016-05-21 16:14:59'
---
Earlier this year I signed up for the F# [mentorship program](http://fsharp.org/mentorship/index.html) and I was lucky enough to be part of the first batch of 10 people selected for the program.

Just before Easter I was paired up with [Riccardo Terrell](https://twitter.com/trikace). Riccardo lives in the Washington DC area and currently works remotely for a startup company. Previously Riccardo was working for Microsoft. In addition Riccardo is active in the Washington DC F# [user group](https://twitter.com/DCFSharp).

For me the hard part about learning a new programming language is not learning the syntax of the language. The difficult part is to learn how to use the language. Typically, one can achieve the same effect by different constructions and figuring out what the optimal solution is the really hard part. Furthermore, one needs to find and use the right extensions, frameworks, and libraries.

During the mentorship program Riccardo and I discussed a number of topics including:

  * Finding cycles in directed graphs
  * F# consumer and producers for Apache Kafka [^1]
  * CQRS in a functional way
  * Type providers to access SQL databases
  * How to use the JSON type provider to validate data to and from MongoDB
  * RabbitMQ and how to handle state, e.g. connection to a queue by means of [State monad](http://fsprojects.github.io/FSharpx.Extras/), [Update monad](http://tomasp.net/blog/2014/update-monads/), MailboxProcessor, and [Akka.Net](http://getakka.net/)

I would like to thank both the [F# Software Foundation](http://fsharp.org/) for the opportunity to be part of the mentorship program as well as Riccardo Terrell for taking the time to act my mentor during the programs. It has been a interesting and unique experience and I learned a lot during the last 2 months. I definitely recommend that you sign up for the next run of the mentorship program!

### Things to remember before applying for the program
Think about how to handle time difference and if you are willing to accept it.
There is a 6-hour time difference between and since I work during day time it is not that easy to schedule talks.

You will have to commit to spending time programming in F#. Having a mentor is not enough. Fortunately, my mentor was very understanding during the periods where I was unable to work with F# due to day time job constraints.

### What's next?
The program is free of charge and I would like to "pay it forward" by helping out with some F# open source projects. I am open to suggestions so please ping me on [Twitter](https://twitter.com/carstenj) if you have any concrete ideas.

### Footnotes
[^1]: I am really looking forward to news about a F# API for Kafka from [Jet Technology](https://twitter.com/jettechnology)
