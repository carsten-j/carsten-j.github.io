---
layout: post
title: "Reactive Extensions in Action"
date: 2015-08-29 09:47:36 +0200
categories: dotnet reactive rx csharp
---

This is a short review of a forthcoming book Reactive Extensions in Action by Tamir Dresher for Manning Publications.

<!--more-->

The book is a Manning Early Access Program (MEAP) publication. Hence the statements, comments and criticism made is this early review might not be valid for the final version of the book. This review is based on chapter 1 to 4.

<img src="https://images.manning.com/255/340/resize/book/5/b79ac99-81ba-493f-9005-9f5dc4a08373/Dresher-RE-MEAP-HI.png" alt="book cover">

I will however try to do my best and either update this review for later versions of the book or write a new blog post after the final publication of the book.

Last year I followed a MOOC Coursera course entitled ["Principles of Reactive Programming"](https://www.coursera.org/course/reactive). The course consisted of three parts:

* Futures
* The Reactive Extension library
* The Akka framework

Please refer to my earlier [blog post (in Danish :-)]({% post_url 2014-01-06-principles-of-reactive-programming %}) for a more detailed description of the course.

The Reactive extension part was taught by Erik Meijer and the course material was based on the JVM version of Reactive extensions. Meijer is one of the main architects behind reactive extensions and the presentations were both interesting and useful.

I am primarily a .NET developer so naturally I was looking for Rx resources written about Rx and the .NET platform - without to much luck. Maybe the "Reaction Extensions in Action" book can fill a gap here.

Reaction Extensions in Action kicks off with a general introduction to reactive programming and some insight about the origin of Rx library as well as the relationship between the tenets of [The Reactive Manifest](http://www.reactivemanifesto.org/) and Rx.

Chapter 2 starts begins with the presentation of problem followed by a solution that does not incorporate the Rx library. I guess that the solution is in line with what most developers would come up with if they don't know about Rx. Afterward another solution is presented this time base on Rx. The author clearly demonstrates how this improves the first solution. I believe this is an approach most newcomers to Rx can benefit from.

Functional programming styles in C# is not a new subject and yet the book devotes an entire chapter to this topic. I do no really appreciate this chapter. If I buy a book about Rx then I don’t expect an entire chapter about topics like LINQ, extension method, anonymous methods, lambda expressions, design patterns, and delegates. None of this is new in the .NET framework and multiple alternative resources are already covering these topics [1].

I would say that Reactive Extensions in Action is a book for developers just starting out on a reactive programming journey and as such it will probably make a good read. However the book is still work in progress and it is to early to say if the book is recommendable or not.

[1] Real-world Functional Programming in F# and C#. Manning Publication. T. Petricek and J. Skeet.

# Disclosure
Manning Publication have a [manuscript review program](http://www.manning.com/manuscript-reviews) and I want to be transparent about my reviews so you should know that will receive a complimentary copy of the eBook as well as the printed book once it is final. I did not pay for the early version of the book.

# Book details
Title: Reactive Extensions in Action with examples in C#

Author: Tamir Dresher

Publisher: Manning Publications

ISBN-10: 9781617293061

Release Date: MEAP began July 2015
