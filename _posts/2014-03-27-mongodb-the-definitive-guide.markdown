---
layout: post
title: MongoDB The Definitive Guide
date: '2014-03-27 19:24:12'
categories: [bookReview, mongodb]
---
# Introduction
MongoDB is the only NoSql database in the [top 5](http://db-engines.com/en/ranking) most popular database management systems. I recently followed a course called MongoDB for Node.js Developers offered by [MongoDB University](https://university.mongodb.com/). 

<!--more-->

This is a highly recommendable course that runs regular. The course is self contained and hence I have been looking for a reference book for future use. I feel quite confident that MongoDB: The Definitive Guide is the right book for this.

<img src="http://akamaicovers.oreilly.com/images/0636920028031/cat.gif" alt="book cover">

# For developers
The query framework for MongoDB is quite easy to learn if you have a SQL background. More advanced querying involving aggregations is slightly more complex to understand. But the book explains this topic quite well.

The main challenge for developers with a SQL background will most likely be the document design. If you are used to working with normalized data and normal forms it will seem strange to denormalize information and embed one document within another. You were most likely taught that data duplication in tables is a bad thing. Chapter 8 contains useful information and guidelines for designing documents but if you are completely new to this topic then you will probably need further information before being comfortable designing more advanced documents.

The command line interface to the database works fine. However if you prefer a GUI based management tool there are a number of options. This is one of my few complaint about this book that I does not mention any third party tools at all.

Your application is up and running but somehow there seems to be performance issues with the database. What do you do? The book goes through a number of available tools that can be useful in such scenarios covering issues like what can this particular tool do for you and examples of how you use in practice.

# For database administrators
MongoDB was designed with scalability in mind. Replication and sharding are cornerstone aspects of a scalable application. The topics might primarily be of interests to database administrators but I would argue that good developers would want to know about these topics as well such that they can build applications that take advantages of these core MongoDB features. I really like the fact that the book covers topics for both developers and database administrators since it is my belief that the increased focus on DevOps will lead to developers more knowledgeable about database administrators tasks and vice verse.

# Conclusion
You can find a lot of useful resources about MongoDB on the official website but if you like me prefer to have a book to learn from then I will definitely recommend that you buy a copy of this book. It is a great reference book covering all aspects of MongoDB for both developers and database administrators.

I often find that books about programming languages and tools seems to claim that if you just use their specific solution then all your problems disappear. Kristina Chodorow is luckily more pragmatic. MongoDB is suited for a lot of different applications but there are limitations. I am happy to see that the author not only realizes this but also point out in which situations MongoDB might not be the best choice. I also really like the fact that this book covers topics targeting both developers and IT professionals such that all aspects of MongoDB are covering in just one book.s

# Disclosure
I review for the O`Reilly Reader Review Program and I want to be transparent about my reviews so you should know that I received a free copy of this eBook in exchange of my review.

<a href="http://oreilly.com/bloggers/"><img alt="I review for the O'Reilly Reader Review Program" src="http://cdn.oreillystatic.com/bloggers/blogger-review-badge-300.png" border="0" width="300" height="250"></a>

# Book details
Title: MongoDB: The Definitive Guide, 2nd Edition. Powerful and Scalable Data Storage

Author: Kristina Chodorow

Publisher: O'Reilly Media

ISBN-10: 1449344682

Release Date: May 2013
