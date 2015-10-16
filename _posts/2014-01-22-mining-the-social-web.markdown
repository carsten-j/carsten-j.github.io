---
layout: post
title: Mining the Social Web
date: '2014-01-22 20:20:41'
categories: [bookReview, datascience, dataAnalysis, python,nosql,mongodb]
---
# Introduction
Last year I read an article in Nature about Paul Erdős’s on the occasion of his 100th birthday. Outside mathematical circles Erdős is most known for the so called Erdős number. There are several different definitions of the Erdős number but according to Wikipedia it is defines as the "'collaborative distance' between a person and mathematician Paul Erdős, as measured by authorship of mathematical papers". So if you co-authored a paper with Erdős your Erdős number is 1. Your number will be 2 if you co-authored a paper with an author who wrote a paper directly with Erdős and so forth. Analyzing Erdős numbers is an application of social network theory and ever since I read the article I wanted to learn more about data mining applied to modern social media platforms. When researching for a book on this topic I came across Mining the Social Web and the books very practical approach convinced me to that this was the book I wanted to read.

<!--more-->

<img src="http://akamaicovers.oreilly.com/images/0636920030195/cat.gif" alt="book cover">

# Virtual Machine experience
The book is accompanied with a Virtual Machine experience that sets new standards for interactions between technical programming books and the code samples provided by the book. In no time you are up and running with the code samples in a IPython notebook that also can be edited and used as basis for your own data mining experiments. I would really love to see this approach adopted by other programming books. 

The reader is gently guided through a software setup of VirtualBox and Vagrant and once these two programs have been installed it is just a matter of writing "vagrant up" in a terminal window and all of the necessary software used throughout the book will be installed and running in a virtual machine accessible through a web browser. Setting up the virtual machine might sound complicated but it is really quite easy. I tested the procedure for on both Mac and Windows and had no troubles getting the environment up and running in less than half an hour. And the really cool thing is that you don't have to install and manage a lot of dependencies yourself as well as you can delete everything afterwards just by deleting the virtual machine. The whole setup process is both described in the book and on videos found on the book's Github pages. 

# Data mining

Some knowledge and experience with Python is required fully understand the code samples. If you have experience from other modern programming languages you should not have troubles understanding basic Python code. So the choice of Python cannot be considered as a barrier for reading the book.

I am amazed of how well Russell mixes deep and complex theoretical knowledge with a very practical hands-on approach in such a way that both theory and code samples becomes very understandable. Not only does the book cover data mining of popular social media platforms as Twitter, LinkedIn, and Facebook but it also includes material on platforms as Google+ and Github which are usually not discussed in data mining books. After you have extracted data from some social media platform you need tools to analyze and visualize the data. Mining the Social Web gives an introduction to tools like Natural Language Toolkit and the JavaScript visualization library D3 and provides enough information for one to get started with such tools. Being able to store the extracted data is also an important feature and you will find code examples of storing data from Twitter in the popular noSQL database MongoDB.  

The books does not cover social network theory in general nor graph theory so if you are looking for a book with a theoretical approach then this book is not for you. However most chapters in the book ends with a list of additional resources that can be used for further research.

# Conclusion
This book is the best computer book I have read in several years. Social networks and data mining is a hot topic and reading Mining the Social Web will not only provide you knowledge about data mining but also supply practical code examples. In addition the books is an easy read and quite funny!

# Disclosure
I review for the O`Reilly Reader Review Program and I want to be transparent about my reviews so you should know that I received a free copy of this ebook in exchange of my review.

<a href="http://www.oreillynet.com/pub/blogger/carstenjørgensen?cmp=ex-orm-blgr-carsten-jørgensen"><img alt="I review for the O'Reilly Reader Review Program" src="http://cdn.oreillystatic.com/bloggers/blogger-review-badge-200.png" border="0" width="200" height="150"></a>

# Book details
Title: Mining the Social Web, 2nd Edition
Data Mining Facebook, Twitter, LinkedIn, Google+, GitHub, and More

Author: Matthew A. Russell

Publisher: O'Reilly Media

ISBN-10: 1449367615

Release Date: October 2013
