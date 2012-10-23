#read in the tweets
tw <- read.csv(“http://jakeporway.com/teaching/data/tweets2009.csv”, header=FALSE, as.is=TRUE)

#add names
names(tw) <- c(“time”, “seconds”, “screen_name”, “text”)

#histogarm of tweets
hist(tw$seconds, breaks=500, main="Histogram of Tweets", xlab="timestamp (seconds)")

# PART 1
# Make a plot of the timeseries as a line (plot() with type=’l’) just so we can see our 
# data (recall you can create a timeseries by pulling out the “counts” entry of the 
# histogram object).  
# Q: What do you see?
# A: (hist in repo)I notice significant moment to monent variation in volume as well as larger trends or seasonality in volume  

h <- hist(tw$seconds, breaks=500, main="Histogram of Tweets", xlab="timestamp (seconds)")


plot(h$counts, type="l")

# Let’s figure out if there are any cycles / seasonal trends in this data.  Use the 
# acf() function to identify cycles in the tweet frequency, just as we did with the 
# NYPD data.  Recall that acf() only looks at a small time frame so you’ll want to 
# pass it a lag.max argument that’s about 200 or more.  
# Q: Where is it most likely that we have a cycle and how can you tell?
# A: it looks like there's seasonality every 

a <- acf(h$counts, lag.max=250)

rev(order(a$acf))

# OK, let’s remove the cycles and analyze this data.  Create an official timeseries 
# object with frequency equal to the cycle length.  Use decompose() to decompose 
# the timeseries into its components and plot the results.  
# Q: What do you see in terms of an overall trend?
# A:

count <- ts(h$counts, frequency=180)
parts <- decompose(count)
plot(parts)

#PART 2
# Plot the time series for iran.tweets using a histogram with breaks=100.  Add red 
# vertical lines to the plot at the 3 largest peaks using abline().

iran.tweets <- tw[grep("iran", ignore.case=TRUE, tw$text), ]
ih <- hist(iran.tweets$seconds, breaks=100)
plot(SMA(ih$counts), type="l")
a <- rev(sort(ih$counts))[1:3]
abline(which(a %in% ih$counts), col=2)

# There’s not a lot of seasonality in this plot, so let’s go straight to analyzing the 
# trend.  Use SMA() with the default settings to smooth the signal and plot it.
plot(SMA(ih$counts), type="l")
par(new=T)
plot(diff(SMA(ih$counts), lag=5), col=2, type="l")

# Can we figure out what 
# time the tweets started increasing using your results from diff

accel <- diff(SMA(diff(SMA(h$counts))))
which.max(accel)
# index 35 has the greatest acceleration
h$breaks[35]
#seconds from the 35th break 1244915000
t <- iran.tweets[iran.tweets$seconds <= 1244915000,]
#I notice from the tweets that there's a lot of talk about the elections.
#Interestingly, both Ahmadinejad and Mousavi declare victory but the issue is contestd  








