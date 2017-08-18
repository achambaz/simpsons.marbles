# simpsons.marbles: Modest Package To Play Around With Marbles And Simpson's Paradox

## Introduction

The  `pickMarble()`  function of  the  simpsons.marbles  package is  meant  to
simulate  easily the  sampling  (with  replacement) from  a  box  of a  marble
characterized by the bag it belonged to  before being poured into the box (bag
one or bag two), its size (small or large) and color (blue or red).  Six inner
mechanisms are available, one for each ordering of these features.

Used by  J.  G.   Bennett to  discuss Simpson's  paradox, the  distribution of
marbles is the following: 
<table>
	<tr>
		<td></td>
		<td>bag</td>
		<td>one</td>
		<td></td>
		<td>bag</td>
		<td>two</td>
		<td></td>
		<td>the</td>
		<td>box</td> 
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

```r
> library("simpsons.marbles")
> example(simpsons.marbles)
```

Refer to the package's vignette for more details.


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


