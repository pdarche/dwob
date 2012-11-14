# Read in the file
snf <- read.csv(file="http://jakeporway.com/teaching/data/snf_4.csv", as.is=T, h=T)

#explore the data a little
names(snf)
#hmmm what are the 'period_stop' and 'period_obs' variabels?
head(snf)
head(rev(sort(snf$time)))
#looks like we're looking at one moth of data from Nov, 2011

# PART ONE 
# Make a “height” column for your data that is the total number of inches tall each 
# person is.

snf$height <- (snf$feet * 12) + snf$inches

# Plot and describe the variables “height”, “weight”, “period_obs”, and 
# “period_stop”.  Use terms that we learned this lesson – talk about the centers of 
# the distributions, their shapes, and whether they’re skewed or not.  If they’re very 
# skewed, try plotting a smaller subset of the data and describing that (e.g. all 
# values less than 50).

first.50.obs <- snf[snf$period_obs < 50,]
first.50.stop <- snf[snf$period_stop < 50,]

par(mfrow=c(4,1))
hist(snf$height, breaks=100, main="Histogram of Heights", xlab="Height (in inches)")
hist(snf$weight, breaks=100, main="Histogram of Weight", xlab="Weight (in lbs)")
hist(first.50.obs$period_obs, breaks=500, main="Histogram of Period Observed", xlab="Period Observed (in minutes)")
hist(first.50.stop$period_stop, breaks=500, main="Histogram of Period Stopped", xlab="Period Stopped (in minutes)")

