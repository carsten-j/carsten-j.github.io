---
layout: single
title: Data Algorithms
date: '2014-09-14 10:15:49'
categories: [bookReview, algorithms, bloomfilters, hadoop]
---
# Introduction
Many of the algorithms that we use in computer science originate from a pre Big Data period where the MapReduce framework did not exists. Many of these algorithms can however be applied in a Big Data setting if there are incorporated into the MapReduce framework. The approach taken is very practical focusing less on the theory behind the MapReduce framework so pick another book if your goal is to learn about MapReduce itself.

<!--more-->

<img src="http://akamaicovers.oreilly.com/images/0636920033950/cat.gif" alt="book cover">

The subtitle of the book is 'Recipes for scaling up with Hadoop and Spark' indicating that one do not need to read the book from start to finish in order to take advantage of the many practical examples. 

The data algorithms are divided up into 4 sections: 

 * Basic design patterns
 * Data mining and machine learning
 * Bioinformatics, genomics, and statistics
 * Optimization techniques

# MapReduce and Monoids
The content of the chapter "MapReduce and Monoids" was quite surprising to me. What do MapReduce and monoids have in common? A monoid is an algebraic structure S equipped with an identity element and an associative binary operation satisfying that the binary operation is closed under S. It turns out that there is a close relationship between monoids and the function "Fold" known from functional programming. Loosely said Fold can be though of as an example of a reducer in MapReduce and hence the connection between MapReduce and monoids.

# Bloom Filters
I did not even know the term probabilistic data structure before reading the section about Bloom Filters but it turns out that there exist a number of such [data structures](http://highlyscalable.wordpress.com/2012/05/01/probabilistic-structures-web-analytics-data-mining/).

A Bloom Filter is a probabilistic data structure with a build in method allowing for efficient testing for the presence of an element in some given set. Please refer to [Wikipedia](http://en.wikipedia.org/wiki/Bloom_filter) for further details. Joining two tables of considerable size can be a quite expensive operation. A Bloom Filter can in some cases be used in a MapReduce context to improve the efficientcy dramaticcaly of such a join.

# The algorithms are also useful outside the Hadoop context 
The book uses Java and Hadoop but many of the examples easily translates to other programming languages and frameworks. To prove this I have written a small example in F# for the Bloom Filter case of joining two tables. You can find the source code [here](https://github.com/carsten-j/BloomFilter/releases/tag/v1.0) and a blog post about the results [here]({% post_url 2014-09-13-bloom-filter-implementation-in-fsharp %}).

# Conclusion
The book covers an impressive number of data algorithms formulated within the MapReduce framework and the examples are easily reused in your own work. The source codes for the examples are unfortunately only available by copy-paste from the book (if the have the electronic version). Hence source code listings take up quite some space in the book and it would be preferably just to make the programs available on GitHub. Data Algorithms is a recommendable piece of work but please publish some electronic form of the source code.

# Disclosure
I review for the O`Reilly Reader Review Program and I want to be transparent about my reviews so you should know that I received a free copy of this eBook in exchange of my review.

<a href="http://oreilly.com/bloggers/"><img alt="I review for the O'Reilly Reader Review Program" src="http://cdn.oreillystatic.com/bloggers/blogger-review-badge-300.png" border="0" width="300" height="250"></a>

# Book details
Title: Data Algorithms. Recipes for Scaling Up with Hadoop and Spark

Author: Mahmoud Parsian

Publisher: O'Reilly Media

ISBN-10: 1491906189

Release Date: July 2015

