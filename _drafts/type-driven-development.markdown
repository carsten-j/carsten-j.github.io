I recently watched a talk by Philip Wadler recorded at the Strangeloop 2015 conference. The title of the talk is ["Propositions as types"](https://www.youtube.com/watch?v=IOiZatlZtGU) and it is both recommendable and very inspirering. There is also a [paper](http://homepages.inf.ed.ac.uk/wadler/papers/propositions-as-types/propositions-as-types.pdf) with the same title containing even more details.

Around 24:30 minutes into the talk Wadler mentions dependent types which was a new comcept for me and to be honest I am not sure I quite got his point.

A few days after watching the talk I received an email from Mannning Publications with a request for reviewing a book called Type-driven Development with Idris. It turns out that Idris is a programming language with Dependent Types. What a perfect opportunity to learn more about Dependent Types. 

Much of the material found online about dependent types deals just as much with type theory as with dependent types. I am a non-type theorist software developer who cares about craftmanship and practical approaches to software development so why should I care about dependent types.

The title of the book got me thinking about types and programming languages in general and development of types (systems) in particular. I have been developing software for 20 years and remember the first versions of the .NET platform and the `List` class that stored data of the type `System.Object`. It was easy to add new items to lists but extracting data meant a lot of casting leading to poor performance. It did not add to readability that `List`s could contain items of different types. It was a big step forward when generics were introduced in the .NET framework version 2.0. Great type improvement and the expressiveness of generics was just cool. Another example comes from F#. The .NET functional programming language. For data types that includes some kind of unit, e.g. miles per hour, US dollars, weight etc in can be quite cumbersome to ensure that you only do valid operations on the data type. For instance you want to avoid adding two amount where one is quoted in US dollar and the other in Euro. 

{% highlight fsharp %}
[<Measure>] type meter
[<Measure>] type centimeter

let distance = 7.0<meter>    

// Here type inference is used to fiuge out that doubleDistance has type 
let doubleDistance = distance * 2.0

// type inference for input and output
let addTenCentimeters cm = cm + 10.0<centimeter>    

// Ups. Type error. One cannot add meter and centimeter with explicit defining the operation
// The error message is: The unit of measure 'centimeter' does not match the unit of measure 'meter'
let tripleDistance = distance + 1400.0<centimeter>   
{% endhighlight %}

Loosely said I will argue that 

>  better type systems -> more expressiveness programming languages  -> better programs

and I will examine dependent types in this light.

# Dependent types 
According to Type-driven Development with Idris a dependent type is

Does this make generics like `List<string>` a dependent type. No - a dependent type does not depend upon another type but upon a value. The canonically example seems to be a vector of a certain given length.


Most functional programming langugages have a zip function that takes two input lists and 'zips' them together into a single list of pairs. So if we have lists `[1; 2; 3]` and `[4; 5; 6]` zipping the together yields `[(1, 4); (2, 5); (3, 6)]`. Consider the case where the input lists don't have the same length, e.g. `[1; 2; 3]` and `[4; 5]`. What will/should zip do?

In F# one will get an runtime error when executing `List.zip  [ 1; 2; 3 ] [ 4 ; 5;6 ]`. In Haskell the behaviour is different. Here will `zip [1, 2, 3] [4, 5]` produce the result `[(1, 4), (2, 5)]`. Is one result/behaviour better than the other?


money time dependent, time value of money. one doller today vs one doller tomorrow.

=======
explicit is better than implicit




TDD 


More expresiveness with dependent types
for all 
there exist 
logic

curry howard

men men


wikipedia
Dependent types add complexity to a type system. Deciding the equality of dependent types in a program may require computations. If arbitrary values are allowed in dependent types, then deciding type equality may involve deciding whether two arbitrary programs produce the same result; hence type checking may become undecidable.

og 
https://www.fpcomplete.com/user/konn/prove-your-haskell-for-great-safety/dependent-types-in-haskell?show=tutorials

undecidability of type-inference for dependent types, and so on.



what is dependent types
not parametized types


why should you care


-----
predicate logic  - dependent types
propositional logic  It’s basically boolean algebra - haskell


only chapter 1-5. last chapter real world



footnote
curry howard 




http://www.tikalk.com/incubator/type-driven-design/

http://tomasp.net/blog/type-first-development.aspx/

http://blog.ploeh.dk/2015/08/10/type-driven-development/
nok ikke denne her. seeman giver ikke klart udtryk for at dette ikke er hans egne originale ideer



Idris, a general-purpose dependently typed programming
language: Design and implementation
EDWIN BRADY
Journal of Functional Programming / Volume 23 / Issue 05 / 2013, pp 552 - 593


http://www.cse.chalmers.se/research/group/logic/TypesSS05/program.html
