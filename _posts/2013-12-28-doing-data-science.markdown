---
layout: post
title: Doing Data Science
date: '2013-12-28 20:54:17'
categories: [bookReview, datascience,R]
---
##More breadth than depth

What is data science? The book Doing Data Science not only explains what data science is but also provides a broad overview of methods and techniques that one must master in order to call one self a data scientist. The book is based on a course about data science given at Columbia University. However it is not to be considered as a text book about data science but more as a broad introduction to a number of topics in data science. 

<!--more-->

<img src="http://akamaicovers.oreilly.com/images/0636920028529/cat.gif" alt="book cover">

In the spring of 2013 I followed two Coursera courses. One about the statistical programming language R and one on Data Analysis. I had for some time been looking for a book that could be used as a follow-up reading on topics in data science. This was the reason I picked up "Doing Data Science".

The book begins with a chapter about what data science is all about is followed by four chapters on topics like statistical inference, explanatory data analysis, various machine learning algorithms, linear and logistic regression, and Naive Bayes. I have a background in both mathematics and statistics and I was able to understand these chapters but the material is covered in such broad terms that I find it hard to believe that a newcomer to this topics will understand or gain much knowledge from reading these chapters.  Basic math is presented about the models but without some kind of detailed explanation one cannot develop any deeper intuition for the approach explained. 

The best parts of the book is definitely chapter 6 to 8 and 10. In here we find interesting discussion about coverage of data science applied to financial modeling, extracting information from data, and social networks. I really enjoyed the examination of time stamped data, the Kaggle Model, feature selection, and case-attribute data versus social network data. The math behind these topics was however once again explained quite superficial.  Centrality measures is central to social network analysis but it is very hard to develop intuition for there measures without a more detailed explanation about the underlying math. These chapters contains lots of useful resources for finding additional information about the discussed topics.

Data visualization is an integral part of data science for communication results.  Beginners in the field of data science needs concrete and easy to follow instruction on how to get started with visualization.  Unfortunately the book focuses more on the use of data visualization in modern art projects. The content is simply to abstract for beginners to learn about the usage of visualization in data science.

When I was browsing the book before actual buying it I was kind thrilled to see that it covered topics like causality and epidemiology. Topics that I did not found covered in any other book about data science. However the chapter about epidemiology is not about using data science in epidemiology but 'just' about using data science to evaluate the methods used in epidemiology. Likewise there seems to be no link between data science and causality. I later discovered that the authors used an entire [blog post](http://columbiadatascience.com/2012/11/18/experiments-ab-testing-and-causal-modeling/) to explain why causality was part of the university course underlying the book. This material or parts of it should have made it into the book. I am still not convinced that causality is a topic in data science.

There are several examples in which the book assumes the reader to have knowledge of US government structure and organizations. Examples include page 292 when discussing US health care databases and page 298 where FDA is mentioned without further introduction or explanation about what FDA is. 

A book than contains programming examples should always make the code accessible to download. Typing in the code yourself is simply waste of time. It is possible to download some of the datasets used in the book through GitHub. But the code does not seem to be available. I also own the electronic version of the book and I tried to copy-paste some of the examples from the e-book but there are several examples of code that hasn't been proof written or tested prior to publication. The sample code misses references to required R libraries or refers to computer folder structures on some local Columbia University computer. The companion datasets that can be downloaded on GitHub consists of a number of Excel files. The R sample code uses the gdata package to load these Excel files into R for further analysis. It took be quite some time to figure out why this process didn't work on a Windows computer. The gdata package requires Perl to be installed on the computer and this is not default software on Windows. In my opinion one should always publish data in a simple format, e.g. csv files and definitely not proprietary formats like xls for Excel files.

Data Science is both science and a lot of practical experience. I guess the title of the book Doing Data Science tries to capture that. You need to do data science in order to learn it.  The covered topics are interesting but the material is more breadth than depth. Luckily there are lots of useful links and resources to additional materials. Personally I would prefer more details about the actual data science topics like e.g. extracting meaning from data and social network analysis and less focus on math. The book already requires some knowledge of math, statistics and programming, so why not presume that the reader has the background knowledge and dive straight into the data science discussions.

I really like the idea about having a lot of different people present various topics in data science and the book is well written and contains lots of useful resources for further studies of data science. I will recommend to book to people new to the subject but be aware of the fact that source code is not available and that is a major drawback.

This book review was also posted at [Amazon](http://www.amazon.com/review/R3PY8NEYN86ZLU/ref=cm_cr_rdp_perm?ie=UTF8&ASIN=1449358659&linkCode=&nodeID=&tag=).

<a href="http://oreilly.com/bloggers/"><img alt="I review for the O'Reilly Reader Review Program" src="http://cdn.oreillystatic.com/bloggers/blogger-review-badge-300.png" border="0" width="300" height="250"></a>

# Book details
Title: Doing Data Science, Straight Talk from the Frontline

Authors: Cathy O'Neil and Rachel Schutt

Publisher: O'Reilly Media

ISBN-10: 1449358659

Release Date: October 2013
