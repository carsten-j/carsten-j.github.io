---
layout: single
title: A F# Akka.NET actor example for pub-sub pattern with NATS server
date: '2016-07-01 18:02:39'
---
## Publish subscribe pattern

The [publish subscribe pattern](http://www.enterpriseintegrationpatterns.com/patterns/messaging/PublishSubscribeChannel.html) is definitely not a new software pattern but still very useful. Lots of people know the pattern as the Observer pattern from the GoF book. The basic
idea is to avoid point to point coupling between a publisher of messages and subscribers of the message.

![center](/images/pubSubPattern.png)

## NATS

NATS is an open source lightweight messaging system build with high performance in minds. To learn more about design goals, supported features, and what NATS does NOT provide please consult the [documentation](http://nats.io/documentation/).

This post is not meant as an introduction or tutorial about NATS so if you need to learn more about NATS I suggest that you visit the [NATS](http://nats.io/) website and watch [Simple Solutions for Complex Problems](https://www.youtube.com/watch?v=0h0t3og8llc) by [Tyler Treat](http://bravenewgeek.com/)
and optionally [Powered by NATS: Integration Patterns for Microservices Architectures](https://www.youtube.com/watch?v=f5gZdK8ir4M) by [David Williams](https://twitter.com/DavWilliams).

NATS is maybe not as well-known as Kafka or RabbitMQ so if you want to see a short comparison between Kafka, RabbitMQ, and NATS then I recommend this [blog post](https://seroter.wordpress.com/2016/05/16/modern-open-source-messaging-apache-kafka-rabbitmq-and-nats-in-action/).

There is an official C# client for NATS and you can see an example of the publish subscribe pattern in C# in the [GitHub repository](https://github.com/nats-io/csnats/tree/master/examples) for the C# client.

This example was inspired by a recent MeetUp [talk](http://www.slideshare.net/Apcera/actor-patterns-and-nats-boulder-meetup) at the NATS Boulder group discussing how to combine Akka and NATS and also on how to use NATS to implement a lightweight version of Akka. Akka is a JVM based implementation of the Actor model in Erlang. On the .NET platform we have [Akka.NET](http://getakka.net/) which also supports an F# API.

A NATS client can be in one of three states: disconnected, connected, or subscribed. This seems like a perfect fit for the Finite State Machine modelling one can do with Akka actors. The different states and transitions between states are:

![center](/images/fsm.png)

Before we get started we need to install and run the NATS server. Luckily there is an official Docker image so installing the server is a simple as

> docker pull nats

Starting the server is just as simple

> docker run -d --name nats-main -p 4222:4222 nats

Please see the [GitHub repositoy](https://github.com/carsten-j/NatsActor) for the implementation of a F# Akka.NET actor used for the pub-sub pattern and lets turn to an example using the NatsActor:

{% highlight ocaml %}
let cf = new ConnectionFactory()

let system = System.create "system" <| Configuration.load ()
let subscriber1 = spawn system "subscriber1" (natsActor cf)

subscriber1 <! Connect
subscriber1 <! Subscribe "foo"

let subscriber2 = spawn system "subscriber2" (natsActor cf)

subscriber2 <! Connect
subscriber2 <! Subscribe "*"

let publisher = spawn system "publisher" (natsActor cf)

publisher <! Connect
publisher <! Publish ("foo", "Hello World!")
publisher <! Publish ("bar", "Hello Again!")

subscriber2 <! Disconnect
publisher <! Publish ("foo", "Goodbye!")

subscriber1 <! Disconnect
publisher <! Publish ("foo", "Goodbye Again!")
publisher <! Disconnect
{% endhighlight %}

Executing this code yields

>   Actor: subscriber2 received message: Hello World!

>   Actor: subscriber1 received message: Hello World!

>   Actor: subscriber2 received message: Hello Again!

>   Actor: subscriber1 received message: Goodbye!

and you see that `subscriber2` receives both messages whereas `subscriber1` only receives the `"Hello World!"` message. Subscription tags can contain wildcards!

Notice that no one received the last message published. If no NATS clients subscribe to a subject then the message is lost.

## Ideas for improvements

* Build a Suave front-end with REST API that passed on the command to the backend through NATS
* Run everything is a docker cluster
* Akka.NET actors handles messages sequentially. In the example we just print the message. In case the backend operation is more time-consuming we might want to offload it to another actor for further processing, ie. writing to a database or similar.
* Replace NATS client with MyNatsClient that supports Rx
* Use Google Protocol Buffers for messages

## References

Design Patterns: Elements of Reusable Object-Oriented Software, Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides, Addison-Wesley, 1994

Enterprise Integraton Patterns, Gregor Hophe and Bobby Woolf, Addison-Wesley, 2004

Reactive Design Patterns, Roland Kuhn and Jamie Allen, Manning Publications, 2016

Reactive Messaging Patterns with the Actor Model, Vaughn Vernon, Addison-Wesley, 2016
