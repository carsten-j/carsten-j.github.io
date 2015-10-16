---
layout: post
title: Interactive Data Visualization for the Web
date: '2014-01-26 15:40:53'
categories: [bookReview, d3, dataVisualization]
---
# Interesting and thorough introduction to visualization with D3.

# Introduction
I am a huge fan of the data journalism and visualization created by The New York Times. Some of their interactive visualizations are created with the open source JavaScript library D3 (Data-Driven Documents) created and maintained by NYT employee Mike Bostock. I have for a long time wanted to learn more about the techniques to create such visualization so I decided to spent a weekend reading Interactive Data Visualization for the Web.

<!--more-->

<img src="http://akamaicovers.oreilly.com/images/0636920026938/cat.gif" alt="book cover">

# D3
After a short introduction to visualization and D3 then book opens with a long chapter about various web technologies but according to the book "it is not intended to teach the intricacies of any one web technology (HTML, CSS, JavaScript, SVG) in depth". My personal guess is that if you are interested in D3 then you are most likely already familiar with the above-said technologies and hence you will just skip that chapter. If you are unfamiliar with HTML, CSS, etc then you will no learn those from reading this book. Hence in both cases you don't really need this chapter and I would prefer completely to skip it and instead add more material about D3. That is after all what we are interested in.

The code samples for the book can be downloaded from Github and you basically just need a modern web browser to run then. I like the idea of using a couple of common examples throughout the book. This illustrates the process of how one start with a simple visualization and gradually make it more advanced by adding more features. However after having read half the book I found it really hard to understand that D3 can be used to create such advanced visualization as found on The New York Times website. Basically it would seem that the visualizations created in the first part of the just a well could have been created using Excel charts.

The real power of D3 is not revealed until the last part of the book where topics like Updates, Transitions, Motion, and Interactivity are covered. If you have knowledge about GUI frameworks you will not be surprised to discover that updating and interactions with the visualizations is based on event handling. The ability to create visualization transitioning into another visualization in just one line of code is amazing. By now I begin to understand the powerful capabilities of D3.

If you have interest in visualization then you probably already know the Choropleth map which is simply a geomap where different areas of the map is filled with different colors reflecting some associated data. A well known example is the US presidential election display states in either red or blue depending on who won that particular state. The book shows how to construct a Choropleth map with different green shapes for each US state corresponding to the agricultural productivity. The true strength of this topic lies in the fact that afterward Murray explains how to create similar visualization for other geographic areas so if you are more interested in visualizing European data you have all the tools necessary at your service.

# Conclusion
Interactive Data Visualization for the Web provides enough information about basic D3 concepts for one to be able to start creating your own interactive visualization. This is not an advanced book that will teach you to create complex visualizations but you will be able to use this book as a starting point for further exploration of D3. If one accepts this premise then I believe the book provides value for your time and money.
 
# Disclosure
I review for the O'Reilly Reader Review Program and I want to be transparent about my reviews so you should know that I received a free copy of this ebook in exchange of my review.

<a href="http://www.oreillynet.com/pub/blogger/carstenjørgensen?cmp=ex-orm-blgr-carsten-jørgensen"><img alt="I review for the O'Reilly Reader Review Program" src="http://cdn.oreillystatic.com/bloggers/blogger-review-badge-200.png" border="0" width="200" height="150"></a>

# Book details
Title: Interactive Data Visualization for the Web

Author: Scott Murray

Publisher: O'Reilly Media

ISBN-10: 1449339735

Release Date: March 2013
