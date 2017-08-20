#' Simulates the Drawing of A Marble.
#'
#' \code{pickMarble} simulates the drawing (with replacement) of a marble from
#' a collection of marbles characterized by a tag indicating to which bag each
#' marble belonged to originally, its size  and color.  The marbles are either
#' poured   together  in   a  box,   or  gathered   by  similar   features  in
#' undistinguishable pouches.  Six approaches to  the gathering of marbles are
#' available, one for each ordering of the features.
#'
#' @param iter integer, the number of independent iterations (defaults to 10).
#'
#' @param  gather.by either  NULL  for  no  gathering  (default value)  or  a
#'   character, one among "bsc", "bcs", "sbc", "scb", "cbs", "csb", to specify
#'   how the marbles  were gathered. The ordering of the  first letters of the
#'   words  bag, size  and color  determines in  which order  the marbles  are
#'   gathered.
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
#'   marble from  a collection  of marbles characterized  a tag  indicating to
#'   which bag they belonged to originally (\emph{bag one} or \emph{bag two}),
#'   their  size  (\emph{large}  or  \emph{small}) and  color  (\emph{red}  or
#'   \emph{blue}).   The marbles  are  either  poured together  in  a box,  or
#'   gathered  by   similar  features   in  undistinguishable   pouches.   Six
#'   approaches to the  gathering are available, one for each  ordering of the
#'   features of  a marble. For a  generic approach to gathering  described by
#'   "xyz" with distinct "x", "y", "z" taken in \eqn{\{}"b", "s", "c"\eqn{\}},
#'   the gathering consists in \enumerate{\item  gathering by bag if x=b, size
#'   if x=s, color if  x=c, \item gathering by bag if y=b,  size if y=s, color
#'   if  y=c, \item  gathering by  bag if  z=b, size  if z=s,  color if  z=c.}
#'   Introduced  by  J.   G.   Bennett   to  discuss  Simpson's  paradox,  the
#'   distribution of  marbles is  the following:  \tabular{rcccccccc}{\tab bag
#'   \tab one \tab \tab bag \tab two \tab  \tab the \tab box \cr \tab red \tab
#'   blue \tab \tab  red \tab blue \tab  \tab red \tab blue \cr  large \tab 12
#'   \tab 18 \tab \tab 8  \tab 2 \tab \tab 20 \tab 20 \cr  small \tab 3 \tab 7
#'   \tab \tab 21 \tab  9 \tab \tab 24 \tab 16}  where \emph{the box} contains
#'   all the marbles when they are poured together.
#' 
#' @examples
#' ## draw independently  10 marbles from the box where  all marbles have been
#' ## poured together
#'
#' pickMarble(10)
#' 
#' ## draw independently 10 marbles when the approach to 
#' ## gathering is given by (1) bag, (2) size, (3) color
#'
#' pickMarble(10, gather.by = "bsc")
#' 
#' ## draw independently 10 marbles from bag one when the
#' ## approach to gathering is given by (1) bag, (2) size,
#' ## (3) color
#'
#' pickMarble(10, gather.by = "bsc", do.bag = "one")
#' 
#' ## draw independently 10 large marbles when the approach
#' ## to gathering is given by (1) bag, (2) size, (3) color
#'
#' pickMarble(10, gather.by = "bsc", do.size = "large")
#' 
#' @export
pickMarble <- function(iter=10, gather.by=NULL, do.bag=NULL, do.size=NULL, do.color=NULL) {
  ##
  ## Arguments
  ##
  iter <- as.integer(iter)
  if (iter == 0) {
    stop("Argument 'iter' must be a positive integer.\n")
  }
  if (!is.null(gather.by)) {
    if (!(gather.by %in% c("bsc", "bcs", "sbc", "scb", "cbs", "csb"))) {
      stop("If not 'NULL', argument 'gather.by' must be one of \"bsc\", \"bcs\", \"sbc\", \"scb\", \"cbs\", \"csb\".\n") 
    }
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
  if (is.null(gather.by)) {
    ## -----------------------------------
    ## All the marbles are poured together
    ## -----------------------------------

    ##
    ## the content of the box...
    ##
    marbles <- expand.grid(size = c("large", "small"),
                           color = c("red", "blue"),
                           bag = c("one", "two"))
    marbles <- marbles[c(rep(1, 12), # one, large, red
                         rep(2, 3), # one, small, red
                         rep(3, 18), # one, large, blue
                         rep(4, 7), # one, small, blue
                         rep(5, 8), # two, large, red
                         rep(6, 21), # two, small, red
                         rep(7, 2), # two, large, blue
                         rep(8, 9)),] # two small, blue
    
    ##
    ## intervention
    ##
    from <- rep(TRUE, nrow(marbles))
    if (!is.null(do.bag)) {
      from <- from & marbles$bag == do.bag
    }
    if (!is.null(do.size)) {
      from <- from & marbles$size == do.size
    }
    if (!is.null(do.color)) {
      from <- from & marbles$color == do.color
    }
    idx <- 1:nrow(marbles)
    idx <- idx[from]
    out.idx <- idx[sample.int(length(idx), iter, replace = TRUE)]
    out <- marbles[out.idx, ]
  } else {
    ## ------------------------------------
    ## The marbles are gathered by features
    ## ------------------------------------
    
    ##
    ## Ordering
    ##
    ordering <- strsplit(gather.by, "")[[1]]
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
  }
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

