# simpsons.marbles: Modest Package To Play Around With Marbles And Simpson's Paradox

## Introduction

The  `pickMarble()`  function of  the  simpsons.marbles  package is  meant  to
simulate  easily the  sampling  (with  replacement) from  a  box  of a  marble
characterized by the bag it belonged to  before being poured into the box (bag
one or bag two), its size (small or large) and color (blue or red).  Six inner
mechanisms are available, one for each ordering of these features.

Introduced by  J.  G.   Bennett to  discuss Simpson's  paradox, the  distribution of
marbles is the following: 
<table>
	<tr>
		<td></td>
		<td colspan=2 align="center">bag one</td>
		<td></td>
		<td colspan=2 align="center">bag two</td>
		<td></td>
		<td colspan=2 align="center">the box</td> 
	</tr>
	<tr>
		<td></td>
		<td>red</td>
		<td>blue</td>
		<td></td>
		<td>red</td>
		<td>blue</td>
		<td></td>
		<td>red</td>
		<td>blue</td>
	</tr>
	<tr>
		<td>large</td>
		<td>12</td>
		<td>18</td>
		<td></td>
		<td>8</td>
		<td>2</td>
		<td></td>
		<td>20</td>
		<td>20</td>		
	</tr>
	<tr>
		<td>small</td>
		<td>3</td>
		<td>7</td>
		<td></td>
		<td>21</td>
		<td>9</td>
		<td></td>
		<td>24</td>
		<td>16</td>		
	</tr>
</table>
where <i>the box</i> contains all the marbles poured together.

<br>

## Using the package

```r
> library("simpsons.marbles")
> example(pickMarble)
> source(system.file("testScripts/simulationStudy.R", package="simpsons.marbles"))
```

The first instruction  loads the package. The second one  runs the examples of
use of  `pickMarble()` that are included  in its code.  The  third instruction
runs a simulation study.

Calling a "success" the drawing of  a red marble, the simulation study focuses
on the  four causal  quantities defined  as the  probability of  success under
interventions  <i>do</i>(large)  (imposing  that   the  marble  be  large)  or
<i>do</i>(bag one) (imposing  that the marble be drawn from  bag one) when the
inner mechanism decomposes either as

1. draw a size, 
2. draw a bag,
3. draw a color 

or as

1. draw a bag,
2. draw a size,
3. draw a color.

Note that it is easy to compute  the true values, as opposed to estimators, of
the four causal quantities. It appears that

<p align="center">
	P(red|<i>do</i>(large)) = 50% and P(red|<i>do</i>(bag one)) = 35%
</p>

when the inner mechanism is the first one above, and 

<p align="center">
	P(red|<i>do</i>(large)) = 60% and P(red|<i>do</i>(bag one)) = 37.5%
</p>

otherwise.

The simulation study replicates one million independent draws of a marble from
the  box  for  each  combination  of intervention  and  inner  mechanism.  The
estimators are merely the empirical proportions of marbles that are red in the
simulated data sets. They are arguably fairly accurate&hellip;



## Authors and citation

This  package  was written  by  Antoine  Chambaz,  Isabelle Drouet  and  Sonia
Memetea. To cite the package, see

```r
> citation("simpsons.marbles")
> toBibtex(citation("simpsons.marbles"))
```

## Installation 

R        package        simpsons.marbles       is        only        available
via   [GitHub](https://github.com/achambaz/simpsons.marbles)    and   can   be
installed in R as:

```r 
source("http://callr.org/install#achambaz/simpsons.marbles") 
```


