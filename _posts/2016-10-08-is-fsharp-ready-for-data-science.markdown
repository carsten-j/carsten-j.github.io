---
layout: single
title: Is F# ready for Machine Learning and Data Science?
date: '2016-10-08 19:22:39'
---
Recently I have been interested in learning more about machine learning. My go-to programming language these days is F# so naturally I turned to F# when looking into machine learning.

One can find lots of books about machine learning using either Python or R. The literature is more limited when it comes to F# but a quick search at Amazon resulted in two recent books:

* [F# for Machine Learning](https://www.amazon.com/F-Machine-Learning-Sudipta-Mukherjee/dp/1783989343) by Sudipta Mukherjee
* [Machine Learning Projects for .NET Developers](http://www.amzn.com/1430267674) by Mathias Brandewinder

In addition, there is quite a lot of useful information at the websites [FsLab](https://fslab.org/) and [Guide - Machine Learning with F#](http://fsharp.org/guides/machine-learning/). Most of the resources in the latter points to blog post about how to implement various Machine Learning algorithms in F#. My main interest is to use well proven and standard open source implementations.

When it comes to data manipulation F# really excels. The combination of the F# REPL and the [F# Data](http://fsharp.github.io/FSharp.Data/index.html) project works really well together.

The report [Analyzing and Visualizing Data with F#](http://www.oreilly.com/programming/free/analyzing-visualizing-data-f-sharp.csp) by Tomas Petricek provides a number of reasons for using F# for Data Science. The arguments focuses on topics like data access, correctness, efficiency, scaling, and integration. Personally I think the selling point would be strong platform support for visualization and standard algorithm implementation.

In the end Data Science and Machine Learning boils down to algorithms and models and the ability to create visualizations.

For visualization there is [XPlot](https://fslab.org/XPlot/) but it feels nowhere as mature as [Matplotlib](http://matplotlib.org/) for Python or [ggplot2](http://ggplot2.org/) for R.

It is possible to access R functionality through F# using the [R type provider](http://bluemountaincapital.github.io/FSharpRProvider/) but getting this to work in a productive environment on OSX is quite a hassle.

When it comes to algorithms and models for machine learning F# and in general the .NET platform seems to lack support.

Sure one can find a linear regression algorithm in [Math.NET Numerics](http://numerics.mathdotnet.com/) but more complex algorithm are hard to find in open source versions. One could argue that these algorithms could (to some degree easily) be implemented in F# but I want to apply these algorithms to solve problems. Not learn how to implement the algorithms.

What do you think? Is F# and .NET a great platform choice for doing machine learning? F# can be used for machine learning but I think it comes with a productivity price when it comes to using standard models and visualizations.

Please comment if you disagree. I would love to be proven wrong!
