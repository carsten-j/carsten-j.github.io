---
layout: post
title: Equality is (much) harder than I first believed
---

Last fall I [reviewed]({% post_url 2015-11-09-type-driven-development %}) the first five chapter of a book called [Type-Driven Development with Idris](https://www.manning.com/books/type-driven-development-with-idris) with Idris by Edwin Brady.

Dependent types can be used for (at least) two purposes:

  * Add additional information to a type, e.g. the length of a vector. The compiler can then type check (at compile type) that operations on a vectors that requires vectors of the same length actually has the same length
  * programming with dependent types can be used to "prove theorems"

The first part of Type-Driven Development with Idris focuses on the first aspect and I discussed this is my first review of the book. Now additional material has been released for reviewing and here I want to focus on chapter 8 dealing with Equality.

### Side note
Idris is not the only programming language with support for dependent types. I recently learned about [F\*](https://www.fstar-lang.org/) (pronounced F star) by Microsoft Research. The type system of F* supports dependent types. In my previous [post]({% post_url 2015-11-09-type-driven-development %}) I gave an example of a Money type dependent on time. Let me revise that example to use F*. This will serve both as reminder about dependent types and

F\* does not have a native `Date` data type. For the sake of the example we will just model time as a `int` representing a timeline. One way of defining a `Money` type indexed over time (here represented by a `int`) could be

{% highlight ocaml %}
type time = int
type money (t:time) =
  | Amount : x:int -> money t
{% endhighlight %}

An instance of a money type can be instantiated with the `Amount` constructor

{% highlight ocaml %}
val m1 : money 2
let m1 = Amount 4
{% endhighlight %}

Similar to the Idris example we can write an `add` function that only type check when we add `money` types with the same time value:

{% highlight ocaml %}
val add: #t:time -> money t -> money t -> Tot (money t)
let add #t (Amount x) (Amount y) = Amount (x + y)
{% endhighlight %}

If we define two additional `money` types:

{% highlight ocaml %}
val m2 : money 2
let m2 = Amount 3

val m3 : money 4
let m3 = Amount 7
{% endhighlight %}

then `let res1 = add m1 m2` will type check but `let res2 = add m1 m3` will not.

# Equality
I consider my native programming language to be C#. I have been programming C# since 2003 but the topic of equality in C# still pops up from time to time. You have to distinguish between reference and value types when comparing things. And when you want to implement `IEquatable<'T>` or `IComparable<'T>` there is quite a few thinks to remember. If you are into DDD the equality means something different for aggregates and value objects. Eventually you might get it right but there are lots of places where you can get it wrong. Even if you did read "Item 6: Understand the Relationships Among the Many Different Concepts of Equality" in the excellent book Effective C# by Bill Wagner.

F# structural equality approach seems much easier to work with. e.g comparing maps, set, and tuples
but still rather long topic insert link

but in the end does it matter if you made an programming error
