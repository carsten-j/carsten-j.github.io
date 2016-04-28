---
layout: post
title: Using Kafka on OSX with a F# producer and consumer
date: 2016-04-28 07:13:51
---
This is just a quick note on installing Kafka on OSX and how to produce and consum messages with a F# client.

## Installation

The easiast way to install [Apache Kafka](http://kafka.apache.org/) on OSX is probably with [Homebrew](http://brew.sh/)

Open your favorite terminale and issue the following command:

>  brew install kafka

This will also install [Zookeeper](https://zookeeper.apache.org/) which Kafka has a strong dependency on.

## Does it work

You can test the installation from the command line with the following few steps:

  * start the Zookeeper server:

>   zookeeper-server-start /usr/local/etc/kafka/zookeeper.properties

  * start the Kafka server:

>  kafka-server-start /usr/local/etc/kafka/server.properties

  * create a topic:

>  kafka-topics --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic testTopic

  * produce some messages:

>  kafka-console-producer --broker-list localhost:9092 --topic testTopic

  * consume the messages:

>  kafka-console-consumer --zookeeper localhost:2181 --topic testTopic --from-beginning

  * clean up messages:

>  kafka-topics --zookeeper 127.0.0.1:2181 --delete --topic testTopic

Your path must include Java for this to work. Hopefully the messages that you type into the producer command line ends up being printed on the consumer command line.

Here is a simple producer, that just pumps messages out quite fast:

{% highlight ocaml %}
open KafkaNet
open KafkaNet.Model
open KafkaNet.Protocol
open System
open System.Reactive
open System.Reactive.Linq

let produceWith (producer : Producer) topic messages =
      producer.SendMessageAsync(topic, messages)
      |> Async.AwaitTask
      |> ignore

[<EntryPoint>]
let main argv =
    let topic = "testTopic"
    let router =  new BrokerRouter(new KafkaOptions(new Uri("http://localhost:9092")))
    use producer = new Producer(router)

    let createAndSendMessage = (fun x -> [ new Message(x) ] |> produceWith producer topic)

    let obs = Observable.Interval(TimeSpan.FromSeconds(0.))
                |> Observable.subscribe(fun s -> createAndSendMessage (s.ToString()))

    Console.ReadKey() |> ignore
    producer.Dispose()
    0
{% endhighlight %}

The corresponding consumer looks like this. Please note the call to `Consume()` is a blocking call but by turning it into an observable sequence one can work around this.

{% highlight ocaml %}
open KafkaNet.Protocol
open System
open System.Reactive.Linq

let printMessage (message: Message) =
    let encoding = new System.Text.UTF8Encoding()
    message.Value
    |> encoding.GetString
    |> printfn "%s"  

[<EntryPoint>]
let main argv =
    let topic = "testTopic"
    let router =  new BrokerRouter(new KafkaOptions(new Uri("http://localhost:9092")))

    let consumer = new KafkaNet.Consumer(new ConsumerOptions(topic, router))
    consumer.SetOffsetPosition(new OffsetPosition(0, 0L))

    let observable = consumer.Consume()
                        |> Observable.ToObservable
                        |> Observable.subscribe(fun m -> printMessage m)
    0
{% endhighlight %}

# Please note
I do not consider the code snippets above production ready. There are a lot of configurations to take into account when deploying Kafka to production. Furthermore [kafka-net](https://github.com/Jroland/kafka-net) does not seem to be actively developed for the time being. The current version was build for kafka version 0.8.0 but the parts that I have played around with also works for version 0.9.0.

Kafta is consider to be very fast and one way to obtain low latency is by design choice. It is the responsibility of the consumers to keep track of where in the message partion the consumer has handled messages for. Kafka supports the consumer by offering a way to commit offset positions but this feature is not supported by  [kafka-net](https://github.com/Jroland/kafka-net).

# Conclusion
The Apache Kafka website lists four DotNet clients for Kafka. In addition to kafka-net used in the examples above the other three clients are:

  * [.NET Kafka Client](https://github.com/ExactTargetDev/kafka-net). This client was last updated 2 years ago.

  * [CSharpClient-for-Kafka](https://github.com/Microsoft/CSharpClient-for-Kafka) by Microsoft. The project has sparse documentation and no Nuget package.

  * [rdkafka-dotnet](https://github.com/ah-/rdkafka-dotnet). This project seems to be maintained but there a hardly any test coverage of the project.

Compared to the official Java API all four project seems to be missing quite a lot of functionality. If you are using Kafka from DotNet in production I would very much like to hear about your experience. Kafka itself appears to be an attractive choice for messaging infrastructure but the support from DotNet is rather limited.

## References

[1] [The Log: What every software engineer should know about real-time data's unifying abstraction](https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying).

[2] [Kafka by example: Kafka as Unix Pipes](https://logallthethings.com/2015/09/15/kafka-by-example-kafka-as-unix-pipes/).

[3] [Apache Kafka for Beginners](http://blog.cloudera.com/blog/2014/09/apache-kafka-for-beginners/).

[4] [Kafka in a Nutshell](http://sookocheff.com/post/kafka/kafka-in-a-nutshell/).

[5]  Kafka: The Definitive Guide. Real-time data and stream processing at scale by Neha Narkhede, Gwen Shapira, Todd Palino, O'Reilly Media, 2016.

[6]  ZooKeeper. Distributed Process Coordination by Flavio Junqueira, Benjamin Reed, O'Reilly Media, 2013.
