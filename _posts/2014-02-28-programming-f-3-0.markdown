---
layout: post
title: Programming F# 3.0
date: '2014-02-28 14:44:59'
categories: [bookReview, fsharp, functionalProgramming]
---
# Introduction
Functional programming is hot. In the media there is a lot of talk about the functional programming language Scala running on the JVM. Many well-known companies like Twitter, LinkedIn, The Guardian, and Coursera uses Scala. But who uses F#? And it is worth learning? The first question is hard to answer but I believe that quite a number of financial institutions is using F #. The second answer is easy to answer. I believe that learning F# will be beneficial at least if you already is working on the Microsoft platform. Knowing several programming languages will improve your general programming skills. Even if you cannot use F# directly in your daily life you will still be able to take advantage of knowing functional programming patterns. C# has a number of functional like features, e.g. LINQ and lambdas.

<!--more-->

<img src="http://akamaicovers.oreilly.com/images/0636920024033/cat.gif" alt="book cover">

# Basic FP constructs
Core functional programming (FP) language features like pattern matching, records, sequences, lazy evaluation, recursion, immutable data are well covered and will get you up and running with the basics of FP.

More complex topics like computational expressions and asynchronous programming are also covered. Maybe I should not tell you this but anyways. After you have read the chapter about computational expressions, you know the basics of monads. That is right. In addition, it wasn't even that difficult. In F# monads are called computational expressions. The Async keyword was introduced in F# long before the feature became a part of C# 5.0.

# More advanced features
[Units of measure](https://www.google.dk/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0ahUKEwjCt_ah2bXMAhUGAZoKHU3qDR4QFggbMAA&url=http%3A%2F%2Ftypesatwork.imm.dtu.dk%2Fmaterial%2FTaW_Paper_TypesAtWork_Kennedy.pdf&usg=AFQjCNExdPu_8jK95TuGCl12W9vZzfcRDg&sig2=KYluf4M-XvN0NksMtRJAXA) is strictly speaking not a functional programming feature. You might have heard of the 1999 loss of NASA’s Mars Climate Orbiter probe. This was due to a software bug caused by incompatible types. Being able to define units of measure can turn runtime errors into compile time errors resulting in more stable and bug free software solutions.

One of the most powerful selling points for F# is the type provider feature. Most software programs need to access outside data. F# is a strongly typed programming language but (and this is true for most programming languages) the type are all within the programming language. Outside world data may also have types but these will most likely be different types. F# type providers can be thought of as a bridge of programming languages types and the outside world data types. This may sound a bit abstract but it is a strong feature of the language.   

The book also contains a chapter about object-oriented programming in F# but if your main goal is to learn functional programming this is properly not relevant. However, it might be an advantage if you need to blend F# and C# using the interop features of the .NET platform.

# Conclusion
Programming F# 3.0 is a thorough introduction to F# and basic functional programming techniques. Type providers is such a powerful F# feature and I would like to see more time spent on this feature than on general .NET programming topics.

# Disclosure
I review for the O`Reilly Reader Review Program and I want to be transparent about my reviews so you should know that I received a free copy of this ebook in exchange of my review.

<a href="http://oreilly.com/bloggers/"><img alt="I review for the O'Reilly Reader Review Program" src="http://cdn.oreillystatic.com/bloggers/blogger-review-badge-300.png" border="0" width="300" height="250"></a>

# Book details
Title: Programming F# 3.0, 2nd Edition A comprehensive guide for writing simple code to solve complex problems

Author: Chris Smith

Publisher: O'Reilly Media

ISBN-10: 1449320295

Release Date: October 2012
