---
layout: single
title: Why you should care about Dependent Types
date: 2015-11-09 20:13:51 +0200
---
I recently watched a talk by Philip Wadler recorded at the Strangeloop 2015 conference. The title of the talk is ["Propositions as types"](https://www.youtube.com/watch?v=IOiZatlZtGU) and it is both recommendable and very inspiring. There is also a [paper](http://homepages.inf.ed.ac.uk/wadler/papers/propositions-as-types/propositions-as-types.pdf) with the same title containing even more details.

Around 24:30 minutes into the talk Wadler mentions dependent types which was a new concept for me, and to be honest I am not sure I quite got his point.

A few days after watching the talk, I received an email from Manning Publications with a review request of a book with the title [Type-Driven Development with Idris](https://www.manning.com/books/type-driven-development-with-idris). It turns out that [Idris](http://www.idris-lang.org/) is a programming language with [Dependent Types](https://en.wikipedia.org/wiki/Dependent_type). What a perfect opportunity to learn more about Dependent Types.

Much of the material about dependent types found on-line deals just as much with type theory and proof assistants as with dependent types. I am a non-type theorist software developer who cares about craftsmanship and practical approaches to software development so why should I care about dependent types?

The the book got me thinking about types and programming languages in general and development of types (systems) in particular. I have been developing software for 20 years and remember the first versions of the .NET platform and the `List` class that stored data of the type `System.Object`. It was easy to add new items to lists but extracting data required a lot of casting, leading to poor performance. It did not add to readability that `List`s could contain items of different types. It was a big step forward when generics were introduced in the .NET framework version 2.0. Great type improvement and the expressiveness of generics was just cool. Another example comes from the functional programming language F#. For data types that includes some kind of unit, e.g. miles per hour, US dollars, weight etc. it can be quite cumbersome to ensure that you only do valid operations on the data type. For instance you want to avoid adding two amounts where one is quoted in US dollar and the other in Euro. F# has a language feature called unit of measure to help with such scenarios.

{% highlight ocaml %}
[<Measure>] type USD
[<Measure>] type EUR

let tenBucks = 10.0<USD>    

// Here type inference is used to figure out the type of twentyBucks
let twentyBucks = tenBucks * 2.0

// type inference for input and output
let addFiftyCents cents = cents + 0.5<USD>    

// Ups. Type error. One cannot add EUR and USD
// with explicit defining the operation
// The error message is:
// "The unit of measure 'USD' does not match the unit
// of measure 'EUR'"
let totalAmount = 1.0<EUR> + 1.0<USD>
{% endhighlight %}

Loosely said I will argue that

>  better type systems -> more expressiveness programming languages  -> better programs

and I will examine dependent types in this light.

# Dependent types
According to Type-driven Development with Idris a dependent type is

> A type which is computed from (or parameterised by) some other value is called a dependent type.

Does this make generics like `List<string>` a dependent type? No - a dependent type does not depend upon another type but upon a value. The canonical example seems to be a vector of a certain fixed length.

Most functional programming languages have a zip function that takes two input lists and 'zips' them together into a single list of pairs. So if we have lists `[1; 2; 3]` and `[4; 5; 6]` zipping the together yields `[(1, 4); (2, 5); (3, 6)]`. Consider the case where the input lists don't have the same length, e.g. `[1; 2; 3]` and `[4; 5]`. What will/should zip do?

In F# one will get an runtime error when executing
{% highlight ocaml %}
List.zip  [1; 2; 3] [4 ; 5]
{% endhighlight %}
In Haskell the behavior is different. Here will
{% highlight haskell %}
zip [1, 2, 3] [4, 5]
{% endhighlight %}
produce the result `[(1, 4), (2, 5)]`. Is one result/behavior better than the other? Not really - it it more just a matter of choice. It would be better if we a compile time could detect that we are trying to zip lists of different length. Let us look at the definition of zip in Idris from the `Data.Vect` module

{% highlight idris %}
zip : Vect n a -> Vect n b -> Vect n (a, b)
{% endhighlight %}
This is valid Idris syntax but to be more explicit one could also write
{% highlight idris %}
zip : {a : Type} -> {b : Type} -> {n : Nat} ->
      Vect n a -> Vect n b -> Vect n (a, b)
{% endhighlight %}
Here we have a vector containing elements of type `a` of length `n` and a another vector with elements of type `b` and of the SAME length `n`. The type `Nat` represent positive natural numbers. The resulting vector will also have length `n`. The `Vect` type is here a dependent type since it depends on the value of `n`. With such a type system we can at the time of the type checking catch errors like trying to zip together lists of different length.

In this example the type `Vect` is a dependent type since it depend upon `n`. By now you should have a first understanding of dependent types.

The title of the books was however _Type-Driven development with Idris_, no talk of dependent types here. So what is type-driven development?

# Type-driven development
It would be natural to abbreviate type-driven development with TDD, but that acronym is already taken by Test Driven Development. I believe there is a relationship between type-driven development and TDD. To quote Martin Fowler: "Test-Driven Development (TDD) is a technique for building software that guides software development by writing tests." TDD originates from the Extreme Programming movement initiated by Kent Beck. One of the fundamental ideas in TDD is to let tests drive software development and hence software design. TDD does _NOT_ as such guarantee that you end of with well-designed software! The steps in the TDD process are:

  1. Decide upon some new functionality you want to add and write a (failing) test for it.
  2. Implement the feature until the test passes.
  3. Refactor your code to until your are happy with the design.

These steps can be refined and rephrased but most definitions I have seen are essentially captured by the above mentioned steps. Let us say you use an `Integer` type as part of your implementation and let us assume that you only want to allow the values 0, 15, 30, and 40. Should you then have added tests checking that your variable capturing these values do not take any other values? At first it feels like a good idea to create a test for that. But wait a minute - would it not be better if your variable could only contain the values 0, 15, 30, and 40?[^1]

I really like the quote: [Make illegal states unrepresentable](https://vimeo.com/14313378) by Yaron Minsky from [Jane Street](https://www.janestreet.com/). The phrase is mentioned around 18:00 minutes into the talk. For me this captures the essence of type-driven development and as such it fits perfectly into TDD by adding an extra step:

<ol start="0">
0. To the extent possible use type definitions to make illegal states unrepresentable
</ol>

The book Type-driven Development with Idris contains numerous example on how to design functionality around types in such a way that illegal states are unrepresentable. Just like the `zip` example above.

Please note that type-driven development is __NOT__ limited to languages with support for dependent types. Dependent types just ensure that some check can be done by the type checker. But the concept of Type-driven development can easily be applied to other programming languages as well.

Several people in the F# community seem to promote it. Tomas Petricek calls it [Type-First Development](http://tomasp.net/blog/type-first-development.aspx/) or TFD to avoid the acronym clashes with TDD. Another example comes from Scott Wlaschin who has an entire series about [designing with types](http://fsharpforfunandprofit.com/posts/designing-with-types-intro/) in F#.

Petricek was inspired by this blog post on [type driven design](https://www.tikalk.com/posts/2011/11/29/type-driven-design/). Unfortunately the blog post does not state who wrote it but this quote:

> When writing code in a statically typed language sometimes types are considered as orthogonal to the logic of the code. We write them to appease the compiler, or get performance or intellisense & navigation, but all of these has no relation to the code itself. This is wrong.

It just another argument for adding the extra initial step 0. to TDD.

# Pros and cons of dependent types

When you read Type-driven Development with Idris there is no mentioning of the downside of dependent types. But there must be downsides. Otherwise dependent types would be present in more widely used programming languages. I asked the Idris community about [drawbacks](https://groups.google.com/forum/#!topic/idris-lang/7GmLjNKRuQ4) and here are some of the [comments](https://groups.google.com/forum/#!topic/idris-lang/qgio0b1Aums) made:

  * Type inference algorithm are usually not as strong in dependent typed languages
  * Error messages can be pretty hard to decipher[^2]
  * Code re-use becomes more difficult. It's quite common to define a bunch of different versions of the List type, each of which guarantees a different invariant.
  * There are fewer examples, the concepts are less ubiquitous in the mainstream, the community is smaller, and there are fewer good/introductory resources[^3]

Wikipedia adds this [one](https://en.wikipedia.org/wiki/Dependent_type):

  * Dependent types add complexity to a type system. Deciding the equality of dependent types in a program may require computations. If arbitrary values are allowed in dependent types, then deciding type equality may involve deciding whether two arbitrary programs produce the same result; hence type checking may become undecidable.

The book Seven More Languages in Seven Days[4] has a chapter about Idris that states the following disadvantage

  * There’s a downside to that extra information in dependent types: you have to take the time to express them. The learning curve is steep, even more so than for Haskell, and the code can be quite dense. Idris is not for everyone.

The Idris community disagrees weather the following is an advantage or disadvantage:
  * All functions must be type annotated.

This is unlike Haskell where it is optional to type annotate functions. Personally I believe that explicit is better than implicit argument applied here. Type annotations adds readability and makes the intended use more obvious.

# What is in it for me?

  * Lots of programming languages are similar. Maybe the language features are named differently but in many cases you can do more or less the same with different languages. Idris is not like that. Dependent types is not a common feature. Learning about dependent types in itself can broaden your way of thinking.
  * TDD is popular and can definitely benefit from adding the type-driven development approach into the TDD process.
  * One can design application specific function invariant with dependent types that are beyond the scope of mainstream programming languages.
  * More expressiveness in the programming language makes it easier to make illegal states unrepresentable.

In have worked in the financial service industry for 15 years and the _one example_ that comes into mind when exploring dependent types is `Money`. Money is money so why should we care to model money as an dependent type. And what should it depend upon? Due to interest rates one dollar today is __NOT__ the same as a dollar tomorrow. Money depends on time and you need to discount amounts of money to the same point in time if you want to add or compare amounts of money.  

Idris does not seem to have a native `Date` data type. For the example we just model time as a `Double` representing a timeline. One way of defining a `Money` type indexed over time (here represented by a `Double`) could be

{% highlight idris %}
data Money : (time : Double) -> Type where
  Amount : (x : Double) -> Money time
{% endhighlight %}

We can the define an `add` function that only works for equal times
{% highlight idris %}
add : Money t -> Money t -> Money t
add (Amount x) (Amount y) = Amount(x + y)
{% endhighlight %}

With these definitions we can

{% highlight idris %}
m1 : Money 2.0
m1 = Amount 4.0

m2 : Money 2.0
m2 = Amount 3.5

m3 : Money 2.0
m3 = add m1 m2
{% endhighlight %}

However with
{% highlight idris %}
m4 : Money 3.0
m4 = Amount 5.0
{% endhighlight %}

The following function call will not type check
{% highlight idris %}
add m1 m4
{% endhighlight %}

By design[^4] we have eliminated a source of potential errors simply because one can only add money instances indexed with the same timestamp. If necessary one could also add currency to obtain the same effect as with unit of measure in F#.
More  with dependent types

# (Faking) Dependent types in more accesible languages

### Scala
Scala has a language feature called path-dependent types that you can read more about in a paper called [Foundations of Path-Dependent Types](http://lampwww.epfl.ch/~amin/dot/fpdt.pdf) co-authored by Martin Odersky.

### Go
In Go you specify an array type with a length and an element type. So a fixed size array of length 3 containing integers is defined like
{% highlight go %}
var a [3]int
{% endhighlight %}
Since the array length is part of the type we have that `[3]int` and `[7]int` are distinct incompatible types.

### Haskell
Haskell does not do have dependent types but a lot of work is going on in this field. The GHC website has an [overview](https://ghc.haskell.org/trac/ghc/wiki/DependentHaskell) of thoughts about adding dependent types. It is however possible with existing language features like e.g. `DataKinds` and `TypeFamilies` to implement fixed-length vector types. See [here](hhttps://www.schoolofhaskell.com/user/konn/prove-your-haskell-for-great-safety/dependent-types-in-haskell) and [here](http://blog.jle.im/entry/fixed-length-vector-types-in-haskell-2015) for some examples.

# Conclusion
As I understand it Idris is designed to be a general purpose dependently typed programming language more than a proof assistant. But since Idris has deep knowledge about the type definition of your functions it is still possible to use the "expression search" feature to help with the implementation. It is my understandint that this goes in the direction of proof assistants and that is a completely different story that I might explore in a blog post some other day.

Type-Driven Development in Idris opened a completly new world for me with dependent types and the practice of actively using the type system in the design phase. If you are looking for ways to take your knowledge about functional programming to the next level then Type-Driven Development in Idris is definitely recommendable.

Please remember that the Type-Driven Development in Idris is a MEAP book meaning that it is not the final publication. Currently chapter 1 - 4 is available. I am really looking forward to the next chapters.

## References

[1] Type-driven Development with Idris, Edwin Brady, Manning Publications. This is work in progress and currently only the first 5 chapters are available.

[2] Idris, a general-purpose dependently typed programming language: Design and implementation, Edwin Brady, Journal of Functional Programming / Volume 23 / Issue 05 / 2013, pp 552 - 593

[3] Programming in IDRIS: A Tutorial, The IDRIS Community, 26th October 2014

[4] [Seven More Languages in Seven Weeks]({% post_url 2015-09-18-lessons-learned-from-advanced-distributed-systems-design-course %}), Bruce Tate, Ian Dees, Fred Daoud, and Jack Moffitt. The Pragmatic Bookshelf, 2014.

[5] Test Driven Development: By Example, Kent Beck, Addison-Wesley Longman, 2002

[6] Dependent Types at Work. Ana Bove and Peter Dybjer. Chalmers University of Technology

## Footnotes

[^1]: Any readers with interest in tennis will recognize the values 0, 15, 30, and 40 as points in tennis games.

[^2]: I have limited practical experience with Idris but I had a really hard time figuring out this error message: `When checking left hand side of add: Type mismatch between Money t (Type of add _ _) and  argTy -> retTy (Is add _ _ applied to too many arguments?) Specifically: Type mismatch between Money and \uv => argTy -> uv

[^3]: Hopefully a book like Type-Driven Development with Idris can help developers to better understand dependent types and their potential use.

[^4]: Thanks to Conor McBride for answering questions regarding the add funciton.
