---
layout: post
title: "Lessons learned from Advanced Distributed Systems Design course"
date: 2015-09-18 20:14:29 +0200
categories: Distributed Systems Design
---

I recently attended Udi Dahan's professional training course ["Advanced Distributed Systems Design with SOA and DDD"](http://udidahan.com/training/). 

<!--more-->

Within the .NET community Udi Dahan is probably best known for his work with the [NServiceBus](http://particular.net/nservicebus). I attended a talk by Udi Dahan at the [Warm]({% post_url 2014-01-14-prae-warm-crocodile-developer-conference-2014 %}) [Crocodile]({% post_url 2014-01-15-wcdc-2014-dag-1 %}) [Conference]({% post_url 2014-01-16-wcdc-2014-dag-2 %}) in Copenhagen 2014. The talk was inspiring and I wanted to learn more about the ideas presented so signing up for the course seemed like a great idea.

The course do not follow the typical technical course pattern:

> presentation of problem -> solution -> computer lab -> repeat

Instead the form was much more open ended centered around presentations given by Udi Dahan followed by discussions and questions. The course also included a couple of exercises but these were focused on design and not programming. 

This is an quite important fact to be aware of. If this style of learning do not suit you then I will be a long week of training. Personally I prefer this way of learning ["That Concentrates on Fundamental Principles Rather Than on Facts"](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004020) to quote my favorite inspiration for lifelong learning.

As the title of the course suggest the main topic was distributed systems. In recent years microservices have been an extremely hot topic almost to the extent of being the "silver bullet" that solves all IT related problems. I was quite please with Udi Dahan's opening remark:

> First law of distributed computing: DON'T

Building distributed systems is hard. So don't do it unless you absolute have to do it. If you must go ahead and build a distributed system then do not forget [The Eight Fallacies of Distributed Computing](https://web.archive.org/web/20160304135918/https://blogs.oracle.com/jag/resource/Fallacies.html).

## Main lessons learned

The two main lessons learned in the course can be summarized by:

  * Think again - do not mechanically repeat old habits
  
  * Always remember the [single responsibility principle](http://www.objectmentor.com/resources/articles/srp.pdf)

The single responsibility principle is part of the SOLID principles. This is required knowledge for software developers on all levels but I will not be talking about that here. If you are new to this topic I will recommend the book [Adaptive Code via C#: Agile coding with design patterns and SOLID principles](http://www.amzn.com/0735683204) as an excellent starting point.

## Think again

This blog post will be followed by a series of four (short) blog post: 

  * [Traditional layered architecture]({% post_url 2015-09-20-adsd-course-traditional-layered-architecture %})

  * Coupling is good!

  * Don't check for NULL!

  * Do Repeat Yourself!

Hopefully these blog post will create food for thought and cause you to rethink. Overall I had a great week with lots of fruitful and interesting discussions with fellow developers in addition to a well designed course. Udi Dahan really 

I will absolutely recommend this course but please remember to consider if you think the learning style is suitable for you before signing up.
