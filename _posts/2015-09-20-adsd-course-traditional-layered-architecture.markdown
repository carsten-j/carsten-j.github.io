---
layout: post
title: "ADSD course - Traditional layered architecture"
date: 2015-09-20 11:49:57 +0200
categories: Distributed Systems Design architecture
---
This is the first in a series of four blog post following up on a [training course]({% post_url 2015-09-18-lessons-learned-from-advanced-distributed-systems-design-course %}) I attended earlier this year.

<!--more-->

The views expressed here are solely mine. The inspiration came from course but the viewpoints presented here are not necessarily the viewpoints of Udi Dahan.

For years we have been using a layered architecture like the one depicted here:

![center](/images/layeredArchitecture1.jpg)

Detailed information about this architecture can be found [here](http://www.amzn.com/0131489062), [here](https://msdn.microsoft.com/en-us/library/ff648105.aspx), and [here](http://www.amzn.com/0471958697).

Do we really need three layers, a database, and multiple data transformations? This particular architectural style has been around for years. I do not want to go into details about why this architecture is useful but separation of concerns is the keyword here. When OO languages got popular we definitely needed the mapping layer between the OO language and the relation database - hence the ORM transformation.

This architecture can be deployed in a multi-tier environment for either a traditional client-server solution or a browser-webservice solution.

JavaScript was originally creating a part of the first web browser, Netscape,  but over the last 5 years the language has really emerged into a full stack all purpose programming language essentially being the lingua franca of the web. Quite a number of databases supports JSON. Even SQL Server 2016 will have a native JSON interface. JavaScript is everywhere! Why not just skip all the transformations and layers and use something simpler like:

![center](/images/simpleArchitecture1.jpg)

Separation of concerns is still important and this simplicity of the picture does not imply that the code running in the browser is one big chunk of spaghetti code. Popular JavaScript framework like [AngularJS](https://angularjs.org/) and [Backbone.js](http://backbonejs.org/) provides the means for structuring your app in a [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller).

An easy way to get started with this architecture would be [Azure DocumentDB](http://azure.microsoft.com/en-us/services/documentdb/).

I am not saying that this approach is applicable for all cases but the point is that technologies change and maybe we need to change our way of using these technologies - not just replacing one technology with another without reconsidering processes, patterns, and best practices as well.