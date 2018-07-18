---
layout: post
title: Review of the Fast Track to Chaos Engineering course
date: '2018-07-18 17:33:41'
---

Most people do not know the discipline chaos engineering. People that have heard of chaos engineering often refers to it as randomly terminating processes in your production environment. Maybe that was what Netflix did with their famous tool Chaos Monkey. What does a more elaborated definition says about chaos engineering and can you apply chaos engineering even if you not working for companies like Netflix? I was curious to learn more about such questions when I earlier this month attended the Fast Track to Chaos Engineering course with [Russ Miles](https://twitter.com/russmiles) at [skills matter](https://skillsmatter.com/) in London.

Here is a link to a detailed overview of the [course programme](http://www.russmiles.com/fast-track-to-chaos-engineering.html).

I will not go into details about chaos engineering as such here. Please refer to the currently only book available on the subject for a proper introduction to chaos engineering. The book is called "Chaos Engineering -
Building Confidence in System Behavior through Experiments" and can be downloaded as a free [ebook](https://www.oreilly.com/webops-perf/free/chaos-engineering.csp) from O'Reilly.

## Day 1
I really liked that we spend most of the first day discussing ideas, concepts, and theory before jumping into code samples and tools. There seems to be quite a few misconceptions about what chaos engineering is and what it can do for you, so getting that straight was really great.

Personally I do not like courses where the presenter uses slides and browse through hundreds of them in no time. So I appreciate that Russ took the time to write on the whiteboard while explaining the theory. The weakness in this setup is that there is no kind of course materials or documentation other that the notes that I took during the course. Afterwards I really miss that. I believe that I managed to write down the most things presented but I have a feeling that I might have missed some points since it can be hard to both listen, understand, and write at the same time.

## Day 2

We started day 2 by diving into the [Chaos Toolkit](https://chaostoolkit.org/) which is an open source tool for defining, creating, and executing chaos experiments. The only requirement is that you have a recent Python installation. A central part of day 2 was to create and execute one or more chaos experiment(s) against your own system or a system of your choice. I really like the idea that you in a course context work in an environment that is familiar and relevant to your work. At first is seemed very unlikely that you can have an tool flexible enough to work on any kind of system (pick whatever programming language, infrastructure components etc you use) but after working with the chaos toolkit for a while you realise that this is indeed possible.

## Day 3
The last day started 45 minutes late and ended 1:15 before time. So basically we "lost" 2 hours here. I explicit asked the course organisers when the course would finish on the last day and were told 17:00.

Day 1 focused on theory and day 2 on the chaos toolkit. The topics for day 3 were more diverse and included among other topics on

*   organisational issues when implementing chaos engineering
*   chaos maturity
*   security analysis through chaos engineering
*   pros and cons on running chaos experiments on build servers and as part of CI/CD

All of the above topics are interesting but all the course participants were newcomers to chaos engineering and one need to be able to walk before attempting to run. So personally I would have preferred that we spend more time on the topics from day 1 and 2 before diving into more advanced topics.

For day 1 and 2 we were following the same theme all day and that made those day feel more consistent and complete. On day 3 we went through a lot of topics making it harder to follow.

# Conclusion
Overall I was quite impressed with the course and the presenter. I think it was a really good opportunity to dig into the world of chaos engineering and to learn about concepts and tools. Russ was very good at putting things into perspective and I learned a lot.

Day 1 was very compressed and we had a lot of extra time last day 3 so I would have preferred that we spend more time going through the material covered during day 1.

Here after the course I really miss having some kind of course materials and/or documentation.
