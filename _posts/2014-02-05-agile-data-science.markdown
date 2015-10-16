---
layout: post
title: Agile Data Science
date: '2014-02-05 19:58:04'
categories: [bookReview, hadoop, datascience,elasticsearch,mapreduce,bootstrap,d3, dataAnalysis]
---
# Introduction
The subtitle "Building Data Analytics Applications with Hadoop" of this book says more about the book than the actual title "Agile Data Science". 

<!--more-->

However the subtitle will probably fool most people. Before reading this book I believed that Hadoop with the the distributed file-system HDFS. If you are looking for a book about building applications on the of HDFS then this book IS NOT for you. It turns out that Hadoop is much more than just HDFS. 

<img src="http://akamaicovers.oreilly.com/images/0636920025054/cat.gif" alt="book cover">

# Agile methodology
Do not buy this book for learning about agile software development methodologies. There are some rather strange comments about personal and private space requirement for creative workers as well as mentioning of "Easy access to large-format printing is a requirement for the agile environment." The discussion about agile methods for working with data science is interesting. The basic question is if it is possible to bridge agile methods and data science since science in it's nature does not consists of a predefined set of tasks. It seems to me that the tools and software used in chapter 3 are called agile an hence is the process agile. In part II of the book the application build is chapter 3 is refined in a number of steps that the author calls iterative. But again, that does not make the process agile. I am not saying that the author is wrong but the point about the agile method and how process and tools interact to make the development agile is not entirely clear to me.

#Building a data science application with Hadoop
This is NOT a book about the inner workings of Hadoop. Please refer to "Hadoop: The Definitive Guide" by Tom White for O'Reilly Media for a thorough introduction to Hadoop. Instead the book takes a very practical approach and show us how to build agile applications using various Hadoop components like Pig, MapReduce, and the Avro serialization framework. In addition you will see how to move data into the popular noSQL database MongoDB and how to use ElasticSearch to search the data. Finally, all the collected data is accesses through a lightweight web application build with Python and Flask with visual enhancement made in Bootstrap and D3. 

Agile Data Science covers a lot of material and uses lots of different software and tools. If you want to run the examples in the book you have two options 1) a user-contributed Linux Vagrant image is available with most of the required software or 2) you can follow along the instructions given in the book and the accompanied Github project and install the software yourself. In either case you have to pay close attention to software versions. All of the examples work but it does require some effort the get them running and if you feel uncomfortable using a terminal and command line you might have a hard time playing with the examples. 

# Conclusion
Being able to work in an agile way with data science is quite important but I do not feel that the attempt made by the author convinced me that the suggested framework will work in a practical setting.

The main value of this book is definitely chapter 3 where Jurney show us how to go from zero to a working data science application. The application is literally build from ground up starting with data collection over storing data to build a web front-end. This chapter is alone worth the price of the entire book.

Part II of the books contains interesting material about data visualizations and prediction models. For many readers some prior knowledge about Naive Bayes and the Natural Language Toolkit would most likely be useful to fully understand the implications of the predictions made around what makes an email likely to receive a response.

# Disclosure
I review for the O`Reilly Reader Review Program and I want to be transparent about my reviews so you should know that I received a free copy of this ebook in exchange of my review.

<a href="http://oreilly.com/bloggers/"><img alt="I review for the O'Reilly Reader Review Program" src="http://cdn.oreillystatic.com/bloggers/blogger-review-badge-300.png" border="0" width="300" height="250"></a>

# Book details
Title: Agile Data Science, Building Data Analytics Applications with Hadoop

Author: Russell Jurney

Publisher: O'Reilly Media

ISBN-10: 1449326269

Release Date: October 2013
