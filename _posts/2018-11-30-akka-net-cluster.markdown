---
layout: post
title: Training course on Akka.NET with Aaron Stannard
date: '2018-11-30 19:32:14'
---

I recently attended a in-house Danske Bank training course on Actors using [Akka.NET](https://getakka.net/).

The course was taught by Aaron Stannard, CEO of [Petabridge](https://petabridge.com/). Aaron is one of the founding partners of the open source toolkit Akka.NET and therefore he is very knowledgeable about Akka.NET. Just very recently Aaron was on [.NET Rocks](https://www.dotnetrocks.com/default.aspx?ShowNum=1601) talking about the latest around Akka.NET.

In case you haven't heard about Akka.NET then it is a port of the [Akka](https://akka.io/) toolkit for the JVM platform. Akka is heavily inspired by [Erlang](https://www.erlang.org/). In recent time Erlang is perhaps most famous for powering the messaging app WhatsApp. Earlier on Erlang was know as the programming language used by Erichson to achieve an impressive high availability of 99.9999999% ("nine nines") uptimes.

Akka.NET is a toolkit that can be used to build reactive, concurrent, and distributed applications more easily. In some sense it is more object-oriented than traditional OO programming since the only was Actors (think of an Actor as a class) can communicate with each other is by sending messages.

My personal experience is that you are up for a steep learning curve when you start out with Akka.NET. Unlike other technologies (e.g. ASP.NET Core) there is not a lot of public available training material for Akka. The official documentation is fairly good but I would consider it more as a reference manual than actual training material.

If you are considering using Akka.NET for your next project I can definitely recommend Aaron as an instructor for one of their Petabridge courses. In Danske Bank we did a 3 days workshop covering more advanced topics like Actor design patterns, remoting, clustering, and streaming. Aaron did a great job of explaining the inner workings of Akka.NET and after the course he was also
very kind to help out with questions and issues arising in the aftermath of the course.

This blog post is not meant as an introduction to Akka.NET. For that I would recommend:

1. The free [bootcamp course](https://github.com/petabridge/akka-bootcamp) from Petabridge
2. The book [Reactive Applications with Akka.NET](https://www.manning.com/books/reactive-applications-with-akka-net) by Anthony Brown, Manning Publications
3. [Pluralsight](https://www.pluralsight.com/search?q=akka&categories=course) has several Akka related online training videos

    and for more advanced topics:

4. The book [Applied Akka Patterns](http://shop.oreilly.com/product/0636920043577.do) by Michael Nash, Wade Waldron, O'Reilly Media
5. The book [Reactive Messaging Patterns with the Actor Model](https://www.amazon.com/Vernon-Reactive-Messagi-Patt-Act_c1/dp/0133846830) by Vaughn Vernon (also known as author of the Blue Book on DDD), Addison-Wesley Professional

When I started out looking at Akka.NET I was hit by the fact that I could not find a lot of working examples of Akka cluster solutions. After the course I have been working on a sample and I want to share that with you. All source code is found on [Github](https://github.com/carsten-j/playWithAkkaCluster/releases/tag/v1.0) with full instruction on how to build and run the solution.

The solution covers topics like:

* [Akka Cluster](https://getakka.net/articles/clustering/cluster-overview.html#what-is-a-cluster)
* [Seed nodes](https://getakka.net/articles/clustering/cluster-overview.html#seed-node-configuration)
* [Routers](https://getakka.net/articles/clustering/cluster-routing.html)
* [Supervisor strategy](https://getakka.net/articles/concepts/supervision.html)
* [Split brain resolver](https://getakka.net/articles/clustering/split-brain-resolver.html)
* [Cluster node roles](https://getakka.net/articles/clustering/cluster-overview.html#key-terms)
* [Petabridge.Cmd](https://cmd.petabridge.com/) for command line cluster management

In the future I might extend it to also cover topics like

* [Cluster Client](https://getakka.net/articles/clustering/cluster-client.html)
* Custom serialization
* Cluster singleton
* Persistence

Here is the cluster

![center](/images/akkaCluster.png)

One last thing. I do not consider that code to be production ready. The repository is meant for experimenting and playing with Akka - not for creating a production ready solution. As of publication date of this blog post

Feel free to contact me if you have any question. I will be more than happy to try to answer any questions.
