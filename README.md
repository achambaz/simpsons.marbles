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
> source(system.file("testScripts/example.R", package="simpsons.marbles"))
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

<i>P(red|do(large)) = 50%,</i>

<i>P(red|do(bag one)) = 35%</i>

when the inner mechanism in the first one above, and 

<i>P(red|do(large)) = 60%,</i>

<i>P(red|do(bag one)) = 37.5%</i>

otherwise.

The simulation study replicates one million independent draws of a marble from
the  box  for  each  combination  of intervention  and  inner  mechanism.  The
estimators are merely the empirical proportions of marbles that are red in the
simulated data sets.

```r
> ## #############################
> ## SIMULATION STUDY 
> ##
> ## 'success' stands for 'drawing
> ## a red marble'
> ## 
> ## Note: the true values of all
> ## the estimated parameters can
> ## be derived in closed form.
> ## #############################
>
> B <- 1e6 # 1 million independent repetitions for each simulation
>
> ##
> ## inner mechanism: (1) size, (2) bag, (3) color
> ##
> 
> inner.mech <- "size, bag, color"
> 
> ## ## intervention: pick a large marble
> 
> ## -- setting the intervention
> intervention <- "do(large)"
> 
> ## -- simulating 
> data <- pickMarble(B, mech="sbc", do.size="large")
> 
> ## -- estimating the probability of success
> probSuccess_do.large.sbc <- round(100 * mean(data$color == "red"), 1)
> 
> ## -- preparing the summary
> msg <- sprintf("\n-----\nInner mechanism: %s\nIntervention: %s\nProbability of success approximately: %.1f%%\n-----\n",
>                inner.mech, intervention, probSuccess_do.large.sbc)
> 
> ## ## intervention: pick from bag one
> 
> ## -- setting the intervention
> intervention <- "do(bag one)"
> 
> ## -- simulating 
> data <- pickMarble(B, mech="sbc", do.bag="one")
> 
> ## -- estimating the probability of success
> probSuccess_do.one.sbc <- round(100 * mean(data$color == "red"), 1)
> 
> ## -- preparing the summary
> msg <- c(msg,
>          sprintf("\n-----\nInner mechanism: %s\nIntervention: %s\nProbability of success approximately: %.1f%%\n-----\n",
>                  inner.mech, intervention, probSuccess_do.one.sbc))
> 
> ##
> ## inner mechanism: (1) bag, (2) size, (3) color
> ##
> 
> inner.mech <- "bag, size, color"
> 
> ## intervention: pick a large marble
> 
> ## -- setting the intervention
> intervention <- "do(large)"
> 
> ## -- simulating 
> data <- pickMarble(B, mech="bsc", do.size="large")
> 
> ## -- estimating the probability of success
> probSuccess_do.large.bsc <- round(100 * mean(data$color == "red"), 1)
> 
> ## -- preparing the summary
> msg <- c(msg,
>          sprintf("\n-----\nInner mechanism: %s\nIntervention: %s\nProbability of success approximately: %.1f%%\n-----\n",
>                  inner.mech, intervention, probSuccess_do.large.bsc))
> 
> 
> ## ## intervention: pick from bag one
> 
> ## -- setting the intervention
> intervention <- "do(bag one)"
> 
> ## -- simulating 
> data <- pickMarble(B, mech="bsc", do.bag="one")
> 
> ## -- estimating the probability of success
> probSuccess_do.one.bsc <- round(100 * mean(data$color == "red"), 1)
> 
> ## -- preparing the summary
> msg <- c(msg,
>          sprintf("\n-----\nInner mechanism: %s\nIntervention: %s\nProbability of success approximately: %.1f%%\n-----\n",
>                  inner.mech, intervention, probSuccess_do.one.bsc))
> 
> ## ## printing the summary
> cat(msg)
```


## Citation

To cite the package, see 

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


