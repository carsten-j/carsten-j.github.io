---
layout: single
title: Don't shoot yourself in the foot
date: '2025-12-29 11:41:52'
---

![center](/images/1766781564216.jpg)

Fresh out of university I started my professional career as a software developer. The first programming language I encountered was C, and you have most likely heard the saying before: C is often called the language that makes it easy to shoot yourself in the foot.

Now, around 30 years later, I get the same feeling when exploring the capabilities of LLMs and agentic code agents. These tools make it easy to produce working code here and now, but what happens in 3 or 6 months when I need to fix a bug in a codebase written by an agent? Will I even be able to do that?

The first two books I read after graduating were The C Programming Language by Kernighan & Ritchie and Types and Programming Languages by Pierce. The first book confirms that you can indeed shoot yourself in the foot. The second recently got me thinking about options for guiding agentic code agents. Pierce writes:

Informally, though, safe languages can be defined as ones that make it impossible to shoot yourself in the foot while programming.
This got me wondering: could we apply similar thinking to agent-generated code? Just before Christmas, a colleague, [Christian Dalager](https://www.linkedin.com/in/dalager/), introduced architectural test cases into our codebase — tests that verify the structure of our C# code itself. Could this be the answer? A kind of safety net ensuring that LLMs stick to your architectural decisions?
