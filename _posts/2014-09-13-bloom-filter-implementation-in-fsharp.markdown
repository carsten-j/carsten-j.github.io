---
layout: post
title: Bloom Filter implementation in F&#35;
date: '2014-09-13 17:38:10'
categories: [bloomfilters, fsharp]
---
<!-- MathJax configuration -->
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    tex2jax: {
      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
      processEscapes: true
    }
  });
</script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/latest.js?config=TeX-AMS-MML_HTMLorMML">
</script>

A Bloom Filter is a probabilistic data structure with a build in method allowing for efficient testing for the presence of an element in some given set. Please refer to [Wikipedia](http://en.wikipedia.org/wiki/Bloom_filter) for further details.

<!--more-->

The two basic operations on a Bloom Filter are

1. insertion: hash the value to be inserted k times and update a bit array at the index equal to each hashed value.
2. querying: hash the value k times and in case of k collisions, then return true; otherwise false.

Querying a Bloom Filter is very fast but speed comes with a price. Because the underlying implementation depends on hash function(s) there is a chance of false positive answer when checking if a certain element is present in the Bloom Filter or not. The algorithm guarantees that no false negatives answers are given when querying. In other words the Bloom Filter might indicate that some element is present in the set even if it is not. However if one query for membership of some element known not to be in the set the answer will always be that the given element is not present in the set.

# Challenge and approach
Say you want to join two tables A and B based on some field x and that the number of records in A is considerable larger than the number of records in B. In the book [Data Algorithms](http://shop.oreilly.com/product/0636920033950.do) by Mahmoud Parsian the first approach to solve this is simple by brute force illustrated by this pseudo-code:

{% highlight scala %}
joinResult = {};
for all records a in A
{
  for all records b in B
  {
    if (joinConditionSatisfied(a, b))
    { // join condition can be like a.x == b.x
      add (a;b) to the joinResult;
    }
  }
}
{% endhighlight %}

A variant of this approach is to sort the tables A and B by x before joining them. Such a method is described [here](http://liveramp.com/engineering/bloomjoin-bloomfilter-cogroup/).

Both approaches can be improved considerable by incorporating the use of a Bloom Filter. The idea is simple to build a Bloom Filter based on the smaller set B and then use the filter to rule out all records of A not present B.

# Implementation
The given F\# implementation is inspired by the Java implementation by [Ian Clarke](http://iancjclarke.wordpress.com/2008/01/12/a-decent-stand-alone-java-bloom-filter-implementation/). The underlying MapReduce function is very simple and do NOT represent a realistic example of a proper implementation of the MapReduce framework. There is just one mapper and one reducer. A real world working implementation would definitely include some degree of parallelism. The point here is not to build a MapReduce framework in F\# but merely to show the performance improvement one can gain from using Bloom Filter for joining two tables.

Source code is available at [GitHub](https://github.com/carsten-j/BloomFilter/releases/tag/v1.0).

# FsCheck
Given a desired false negative probability rate $p$ and the number of elements $n$ being filtered one can determine the length of the bit array by the following formula:

$$
m = -\frac{n \log p}{ (\log 2)^2 }
$$

From this formula we see that the following relation holds for all probability rates $p1$ and $p2$ with $p1 < p2$:

>length of bit array based on p1 < length of bit array based on p2

Instead of writing just a couple of unit tests verifying this property we can use the test framework [FsCheck](https://github.com/fsharp/FsCheck) (inspired by the original Haskell version called [QuickCheck](http://www.cse.chalmers.se/~rjmh/QuickCheck/)). FsCheck cannot prove that the property holds for all lists but it can automatically generate a large number of lists and verify that the relation holds for all these lists. Please see the [source code](https://github.com/carsten-j/BloomFilter/blob/master/Test/TestFsCheck.fs) for details.

# Results
In the table below we see the results from simulating the join of two tables in memory. The larger table contains the number of elements given in the column "Number of elements" and the smaller table contains 1/100 elements of the larger table.

Run times are shown in milliseconds for the two cases: brute force and Bloom Filter. We observe a significant performance improvement when using the Bloom Filter approach for larger tables.

<table >
  <tr style="text-align:right">
    <th class="tg-9vto">Number of elements</th>
    <th class="tg-9vto">Without BF</th>
    <th class="tg-9vto">With BF</th>
    <th class="tg-7xxd">Improvement</th>
  </tr>
  <tr style="text-align:right">
    <td class="tg-8lo3">10000</td>
    <td class="tg-8lo3">54</td>
    <td class="tg-8lo3">21</td>
    <td class="tg-mj1a">61,1%</td>
  </tr>
  <tr style="text-align:right">
    <td class="tg-8lo3">25000</td>
    <td class="tg-8lo3">297</td>
    <td class="tg-8lo3">44</td>
    <td class="tg-mj1a">85,2%</td>
  </tr>
  <tr style="text-align:right">
    <td class="tg-foj8">50000</td>
    <td class="tg-foj8">1192</td>
    <td class="tg-foj8">94</td>
    <td class="tg-7xxd">92,1%</td>
  </tr>
  <tr style="text-align:right">
    <td class="tg-8lo3">100000</td>
    <td class="tg-8lo3">4778</td>
    <td class="tg-8lo3">213</td>
    <td class="tg-mj1a">95,5%</td>
  </tr>
  <tr style="text-align:right">
    <td class="tg-foj8">1000000</td>
    <td class="tg-foj8">484404</td>
    <td class="tg-foj8">8446</td>
    <td class="tg-7xxd">98,3%</td>
  </tr>
</table>

My computer is a MacBook Pro with a Intel Core i5 2,6 GHz processor and 16 GB of memory.

# Alternative language implementations
Bloom Filter implementations in other programming languages and frameworks

 * [Algebird from Twitter](https://twitter.github.io/algebird) in Scala. Contains lots of other interesting things as well.
 * [Java](https://github.com/MagnusS/Java-BloomFilter). Alternative Java implementation of Ian Clarkes original implementation.
 * [Scala](http://theyougen.blogspot.dk/2009/12/decent-bloom-filter-in-scala.html). Also inspired by Ian Clarke.
