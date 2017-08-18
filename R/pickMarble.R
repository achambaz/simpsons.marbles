#' Simulates the Drawing of A Marble.
#'
#' \code{pickMarble} simulates the drawing (with  replacement) from a box of a
#' marble characterized by the bag it belonged to before being poured into the
#' box, its size and color.  Six  inner mechanisms are available, one for each
#' ordering of these features.
#'
#' @param iter integer, the number of independent iterations (defaults to 10).
#'
#' @param mech  character, one  among  "bsc" (default  value), "bcs",  "sbc",
#'   "scb", "cbs", "csb", to specify the  inner mechanism used to simulate the
#'   drawing. The  ordering of the  first letters of  the words bag,  size and
#'   color determines in which order the features are drawn.
#' 
#' @param do.bag either  NULL for no intervention on bag  (default value) or a
#'   character  to specify  the nature  of the  intervention, either  "one" or
#'   "two".
#' 
#' @param do.size either NULL for no intervention on size (default value) or a
#'   character to  specify the nature  of the intervention, either  "large" or
#'   "small".
#'
#' @param do.color either NULL for no intervention on color (default value) or
#'   a character  to specify the nature  of the intervention, either  "red" or
#'   "blue".
#' 
#' @return A  data.frame with iter rows  and 3 columns describing  the results of
#'   the iter independent samplings.
#'
#' @details  \code{pickMarble} simulates the  drawing (with replacement)  of a
#'   marble from  a box of marbles  characterized by the bag  they belonged to
#'   before  being poured  into the  box (\emph{bag  one} or  \emph{bag two}),
#'   their  size  (\emph{large}  or  \emph{small}) and  color  (\emph{red}  or
#'   \emph{blue}).  Six inner mechanisms are considered, one for each ordering
#'   of the features  of a marble. For a generic  inner mechanism described by
#'   "xyz" with distinct "x", "y", "z" taken in \eqn{\{}"b", "s", "c"\eqn{\}},
#'   the sampling consists in \enumerate{\item drawing a bag if x=b, a size if
#'   x=s, a color if x=c, \item drawing  a bag if y=b, a size if
#'   y=s, a color if y=c, \item drawing a bag if z=b, a size if
#'   z=s, a color if z=c.}  Introduced
#'   by  J.  G.   Bennett to  discuss Simpson's  paradox, the  distribution of
#'   marbles is the following: \tabular{rcccccccc}{\tab bag \tab one \tab \tab
#'   bag \tab two \tab \tab the \tab box  \cr \tab red \tab blue \tab \tab red
#'   \tab blue \tab \tab  red \tab blue \cr large \tab 12 \tab  18 \tab \tab 8
#'   \tab 2 \tab \tab 20  \tab 20 \cr small \tab 3 \tab 7  \tab \tab 21 \tab 9
#'   \tab  \tab 24  \tab 16}  where \emph{the  box} contains  all the  marbles
#'   poured together.
#' 
#' @examples
#' ## draw independently 10 marbles from the box 
#' ## with inner mechanism (1) bag, (2) size, (3) color
#'
#' pickMarble(10, mech = "bsc")
#' 
#' ## draw independently 10 marbles from bag one
#' ## with inner mechanism (1) bag, (2) size, (3) color
#'
#' pickMarble(10, mech = "bsc", do.bag = "one")
#' 
#' ## draw independently 10 large marbles from the box
#' ## with inner mechanism (1) bag, (2) size, (3) color
#'
#' pickMarble(10, mech = "bsc", do.size = "large")
#' 
#' @export
pickMarble <- function(iter=10, mech="bsc", do.bag=NULL, do.size=NULL, do.color=NULL) {
  ##
  ## Arguments
  ##
  iter <- as.integer(iter)
  if (iter == 0) {
    stop("Argument 'iter' must be a positive integer.\n")
  }
  if (!(mech %in% c("bsc", "bcs", "sbc", "scb", "cbs", "csb"))) {
    stop("Argument 'mech' must be one of \"bsc\", \"bcs\", \"sbc\", \"scb\", \"cbs\", \"csb\".\n") 
  }
  if (!is.null(do.bag)) {
    if (!(do.bag %in% c("one", "two"))) {
      stop("Argument 'do.bag' must be 'NULL' for no intervention, or \"one\" or \"two\".\n")
    }
  }
  if (!is.null(do.size)) {
    if (!(do.size %in% c("large", "small"))) {
      stop("Argument 'do.size' must be 'NULL' for no intervention, or \"large\" or \"small\".\n")
    }
  }
  if (!is.null(do.color)) {
    if (!(do.color %in% c("red", "blue"))) {
      stop("Argument 'do.color' must be 'NULL' for no intervention, or \"red\" or \"blue\".\n")
    }
  }
  ##
  ## Ordering
  ##
  ordering <- strsplit(mech, "")[[1]]
  one <- function(...) {
    switch(ordering[1],
           "b"=draw.bag(when=1, ...),
           "s"=draw.size(when=1, ...),
           "c"=draw.color(when=1, ...))
  }
  do.one <- switch(ordering[1],
                   "b"=do.bag,
                   "s"=do.size,
                   "c"=do.color)
  two <- function(...) {
    switch(ordering[2],
           "b"=draw.bag(when=2, ...),
           "s"=draw.size(when=2, ...),
           "c"=draw.color(when=2, ...))
  }
  do.two <- switch(ordering[2],
                   "b"=do.bag,
                   "s"=do.size,
                   "c"=do.color)
  three <- function(...) {
    switch(ordering[3],
           "b"=draw.bag(when=3, ...),
           "s"=draw.size(when=3, ...),
           "c"=draw.color(when=3, ...))
  }
  do.three <- switch(ordering[3],
                     "b"=do.bag,
                     "s"=do.size,
                     "c"=do.color)
  ##
  ## Core
  ##  

  first <- one(iter=iter, do=do.one)

  second <- two(iter=iter, do=do.two, past=first)

  third <- three(iter=iter, do=do.three, past=cbind(first, second))

  out <- cbind(first, second, third)
  nms <- colnames(out)
  out <- out[, c("bag", "size", "color")]
  out <- cbind(c("one", "two")[1+out[, 1]],
               c("small", "large")[1+out[, 2]],
               c("blue", "red")[1+out[, 3]])
  colnames(out) <- c("bag", "size", "color")
  out <- out[, nms]
  out <-as.data.frame(out)
  return(out)
}

draw.bag <- function(when = c(1, 2, 3), iter, past, do) {
  if (!is.null(do)) {
    ## intervention
    do.bag <- switch(do,
                     "two"=1,
                     "one"=0)
    bag <- rep(do.bag, iter)
  } else if (when == 1) {
    ## draw bag first
    bag <- rbinom(iter, size=1, prob=40/80)
  } else if (when == 2) {
    ## draw bag second
    bag <- rep(NA, iter)
    before <- names(past)
    if (before == "size") {
      probs <- c(30/40, 10/40)
    } else if (before == "color") {
      probs <- c(11/36, 29/44)
    }
    for (pp in 0:1) {
      which.pp <- which(past==pp)
      length.pp <- length(which.pp)
      if (length.pp > 0) {
        prob <- probs[pp+1]
        bag[which.pp] <- rbinom(length.pp, size=1, prob=prob)
      }
    }
  } else if (when == 3) {
    ## draw bag third
    bag <- rep(NA, iter)
    probs <- matrix(c(9/16, 21/24, 2/20, 8/20), ncol=2, byrow=TRUE,
                    dimnames=list(c("small", "large"), c("blue", "red")))
    for (ss in 0:1) {
      for (cc in 0:1) {
        which.ss.cc <- which(past$size == ss & past$color == cc)
        length.ss.cc <- length(which.ss.cc)
        if (length.ss.cc > 0) {
          prob <- probs[ss+1, cc+1]
          bag[which.ss.cc] <- rbinom(length.ss.cc, size=1, prob=prob)
        }
      }
    }
  }
  bag <- as.data.frame(bag)
  names(bag) <- "bag"
  return(bag)
}

draw.size <- function(when = c(1, 2, 3), iter, past, do) {
  if (!is.null(do)) {
    ## intervention
    do.size <- switch(do,
                     "large"=1,
                     "small"=0)
    size <- rep(do.size, iter)
  } else if (when == 1) {
    ## draw size first
    size <- rbinom(iter, size=1, prob=40/80)
  } else if (when == 2) {
    ## draw size second
    size <- rep(NA, iter)
    before <- names(past)
    if (before == "bag") {
      probs <- c(30/40, 10/40)
    } else if (before == "color") {
      probs <- c(20/36, 20/44)
    }
    for (pp in 0:1) {
      which.pp <- which(past==pp)
      length.pp <- length(which.pp)
      if (length.pp > 0) {
        prob <- probs[pp+1]
        size[which.pp] <- rbinom(length.pp, size=1, prob=prob)
      }
    }
  } else if (when == 3) {
    ## draw size third
    size <- rep(NA, iter)
    probs <- matrix(c(18/25, 12/15, 2/11, 8/29), ncol=2, byrow=TRUE,
                    dimnames=list(c("one", "two"), c("blue", "red")))
    for (bb in 0:1) {
      for (cc in 0:1) {
        which.bb.cc <- which(past$bag == bb & past$color == cc)
        length.bb.cc <- length(which.bb.cc)
        if (length.bb.cc > 0) {
          prob <- probs[bb+1, cc+1]
          size[which.bb.cc] <- rbinom(length.bb.cc, size=1, prob=prob)
        }
      }
    }
  }
  size <- as.data.frame(size)
  names(size) <- "size"
  return(size)
}

draw.color <- function(when = c(1, 2, 3), iter, past, do) {
  if (!is.null(do)) {
    ## intervention
    do.color <- switch(do,
                       "red"=1,
                       "blue"=0)
    color <- rep(do.color, iter)
  } else if (when == 1) {
    ## draw color first
    color <- rbinom(iter, size=1, prob=44/80)
  } else if (when == 2) {
    ## draw color second
    color <- rep(NA, iter)
    before <- names(past)
    if (before == "bag") {
      probs <- c(15/40, 29/40)
    } else if (before == "size") {
      probs <- c(24/40, 20/40)
    }
    for (pp in 0:1) {
      which.pp <- which(past==pp)
      length.pp <- length(which.pp)
      if (length.pp > 0) {
        prob <- probs[pp+1]
        color[which.pp] <- rbinom(length.pp, size=1, prob=prob)
      }
    }
  } else if (when == 3) {
    ## draw color third
    color <- rep(NA, iter)
    probs <- matrix(c(3/10, 12/30, 21/30, 8/10), ncol=2, byrow=TRUE,
                    dimnames=list(c("one", "two"), c("small", "large")))
    for (bb in 0:1) {
      for (ss in 0:1) {
        which.bb.ss <- which(past$bag == bb & past$size == ss)
        length.bb.ss <- length(which.bb.ss)
        if (length.bb.ss > 0) {
          prob <- probs[bb+1, ss+1]
          color[which.bb.ss] <- rbinom(length.bb.ss, size=1, prob=prob)
        }
      }
    }
  }
  color <- as.data.frame(color)
  names(color) <- "color"
  return(color)
}

