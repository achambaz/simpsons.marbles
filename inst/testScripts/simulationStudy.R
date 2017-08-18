## #############################
## SIMULATION STUDY 
##
## 'success' stands for 'drawing
## a red marble'
## 
## Note: the true values of all
## the estimated parameters can
## be derived in closed form.
## #############################

B <- 1e6 # 1 million independent repetitions for each simulation

##
## inner mechanism: (1) size, (2) bag, (3) color
##

inner.mech <- "size, bag, color"

## ## intervention: pick a large marble

## -- setting the intervention
intervention <- "do(large)"

## -- simulating 
data <- pickMarble(B, mech="sbc", do.size="large")

## -- estimating the probability of success
probSuccess_do.large.sbc <- round(100 * mean(data$color == "red"), 1)

## -- preparing the summary
msg <- sprintf("\n-----\nInner mechanism: %s\nIntervention: %s\nProbability of success approximately: %.1f%%\n-----\n",
               inner.mech, intervention, probSuccess_do.large.sbc)

## ## intervention: pick from bag one

## -- setting the intervention
intervention <- "do(bag one)"

## -- simulating 
data <- pickMarble(B, mech="sbc", do.bag="one")

## -- estimating the probability of success
probSuccess_do.one.sbc <- round(100 * mean(data$color == "red"), 1)

## -- preparing the summary
msg <- c(msg,
         sprintf("\n-----\nInner mechanism: %s\nIntervention: %s\nProbability of success approximately: %.1f%%\n-----\n",
                 inner.mech, intervention, probSuccess_do.one.sbc))

##
## inner mechanism: (1) bag, (2) size, (3) color
##

inner.mech <- "bag, size, color"

## intervention: pick a large marble

## -- setting the intervention
intervention <- "do(large)"

## -- simulating 
data <- pickMarble(B, mech="bsc", do.size="large")

## -- estimating the probability of success
probSuccess_do.large.bsc <- round(100 * mean(data$color == "red"), 1)

## -- preparing the summary
msg <- c(msg,
         sprintf("\n-----\nInner mechanism: %s\nIntervention: %s\nProbability of success approximately: %.1f%%\n-----\n",
                 inner.mech, intervention, probSuccess_do.large.bsc))


## ## intervention: pick from bag one

## -- setting the intervention
intervention <- "do(bag one)"

## -- simulating 
data <- pickMarble(B, mech="bsc", do.bag="one")

## -- estimating the probability of success
probSuccess_do.one.bsc <- round(100 * mean(data$color == "red"), 1)

## -- preparing the summary
msg <- c(msg,
         sprintf("\n-----\nInner mechanism: %s\nIntervention: %s\nProbability of success approximately: %.1f%%\n-----\n",
                 inner.mech, intervention, probSuccess_do.one.bsc))

## ## printing the summary
cat(msg)
