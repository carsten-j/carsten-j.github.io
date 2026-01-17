---
layout: single
title: Why you should care about equality in type dependent languages
date: '2016-06-01 18:02:39'
---

Last fall I [reviewed]({% post_url 2015-11-09-type-driven-development %}) the first five chapter of the book [Type-Driven Development with Idris](https://www.manning.com/books/type-driven-development-with-idris) with Idris by Edwin Brady.

Dependent types can be used for (at least) two purposes:

  * Add additional information to types, e.g. the length of a vector. The compiler can then type check (at compile type) that operations on a vectors that requires vectors of the same length actually has the same length
  * programming with dependent types can be used to "prove theorems"

The first part of Type-Driven Development with Idris focuses on the first aspect and I discussed this is my first review of the book. Now additional material has been released for reviewing and here I want to focus on chapter 8 dealing with Equality.

### Recap
Idris is not the only programming language with support for dependent types. I recently learned about [F\*](https://www.fstar-lang.org/) (pronounced F star) by Microsoft Research. The type system of F* supports dependent types. In my previous [post]({% post_url 2015-11-09-type-driven-development %}) I gave an example of a Money type dependent on time. Let me revise that example to use F*. This will serve both as reminder about dependent types and show an alternative but similar approach from F*.

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
I consider my native programming language to be C#. I have been programming C# since 2003 but the topic of equality in C# still pops up from time to time. You have to distinguish between reference and value types when comparing things. And when you want to implement `IEquatable<'T>` or `IComparable<'T>` there is quite a few thinks to remember. If you are into DDD then equality means something different for aggregates and value objects. Eventually you might get it right but there are lots of places where you can get it wrong. Even if you did read "Item 6: Understand the Relationships Among the Many Different Concepts of Equality" in the excellent book Effective C# by Bill Wagner.

The F# structural equality approach seems much easier to work from an application developer point of view. Comparing maps, set, and tuples just works out of the box. But even in F# equality is a [lengthy topic](https://blogs.msdn.microsoft.com/dsyme/2009/11/08/equality-and-comparison-constraints-in-f/).

but in the end does it matter if you made an programming error

The C# interface `IEquatable<T>` contains just one method:
{% highlight csharp %}
bool Equals(T other)
{% endhighlight %}
where `other` is of type `T` is an object to compare with this object. According to the [documentation](https://msdn.microsoft.com/en-us/library/ms131190%28v=vs.110%29.aspx) the method returns a `System.Boolean` that is
> __true__ if the current object is equal to the other parameter; otherwise, __false__.

However, this is an implementation detail. One cannot tell if you get the expected result just by looking at the type definition of `Equals`. An implementation of `Equals` that always returns `true` fulfills all the requirements but it will give you unexpected results when comparing objects.

Can we do better than above? The answer is yes but it requires a programming language that supports dependent types. In Idris the natural numbers are defined by the `Nat` type. Let us consider the dependent type
{% highlight ocaml %}
data EqNat : (num1 : Nat) -> (num2 : Nat) -> Type where
 Same : (num : Nat) -> EqNat num num
{% endhighlight %}
from chapter 8 in Type-Driven Development with Idris. This type is parameterized by the numbers `num1` and `num2` but if we have a value of type `Eqnat` then `num1` and `num2` must be equal because the only constructor `Same` for `EqNat` requires `num1` and `num2` to be equal for the type to be constructed. I assume that it is no coincidence that this resembles one of the mathematical properties of equality, namely reflexivity: `a = a` - an object is identical to itself.

The above dependent type definition for `EqNat` is also referred to as *propositional* equality sine any to values `num1` and `num2` can be *proposed* to be identical.

# Conclusion
Type-Driven Development with Idris is an excellent introduction not only to type-driven development but also to type theory[^1] . Usually the term *page turner* is used for fiction but I consider the term to be applicable to this book as well.

Type dependent languages might still not be applicable to enterprise software. But from a practical point of view you should still care about languages like Idris because eventually the might end up with a type system with more precise types. As a application developer that is a desirable situation. Quoting Jane Street’s Yaron Minsky we should strive to Make illegal states unrepresentable." and that is definitely easier with a more expressive type system. Imagine the day where an array comes with extra information about the size of the array and say hello to static checks for out of bounds exceptions.

### Footnotes
[^1]: I recommend the essay [Against a universal definition of 'type'](http://tomasp.net/academic/papers/against-types/) by Tomas Petricek for a general scientic discussion about what types are.
