#HOMEWORK 2

#import data
snf <- read.csv(file="http://www.jakeporway.com/teaching/data/snf_2.csv", head=TRUE, as.is=TRUE)

# Write code to return the percentage of people who were frisked for each 
# race.  In other words, count up the number of people who were frisked for a given race 
# divided by the number of people of that race stopped.   

#total stops
total.stops <- nrow(snf)
total.frisks <- sum(snf$frisked)
frisks.by.race <- rev(sort(table(snf$race[snf$frisked == 1])))

# Which race leads to the highest percentage of frisks?
most.frisked.race <- frisks.by.race[1]
perc.frisked <- most.frisked.race/total.frisks

# Which one the lowest?
least.frisked.race <- frisks.by.race[dim(frisks.by.race)]
perc.frisked <- least.frisked.race/total.frisks

# Plot the number of times each crime occurs in descending order 
# What does this distribution of crimes look like?  In 
# other words, are there an equal number of every kind of crime 
# or are there a few that dominate?

sorted.crimes <- rev(sort(table(snf$crime.suspected)))
top.50 <- sorted.crimes[1:50]
barplot(top.50, xlab="crime suspected", ylab="number of stops", cex.lab=.2, col="red", density=(log(top.50)*7))

#Q:	What does this distribution of crimes look like? 
#A: The distribution looks like a power-law distribution.  
#	The most suspected crime has a huge percent more stops 
# 	than the next-most, and this pattern repeats til there

# Q: Well I’m kind of answering that question for you here – let’s take the top 30 
# 	suspected crimes and look at those.  If we were to just look at stops where the 
# 	crime.suspected was one of the top 30 crimes, what percentage of the stops would that 
# 	cover?  Do you think that’s enough? 
#A: [1] 0.9132194

sum.top.30 <- sum(sorted.crimes[1:30])
perc.top.30 <- sum.top.30/total.stops

#Write code to create a variable called “crime.abbv” that consists of just the 
# first three letters of crime.suspected and show the code to add it to our main data frame.  
# Now what percentage of the stops do the top 30 crime.abbv account for?

crime.abbv <- substr(snf$crime.suspected, 1, 3)
sorted.crimes.abbvs <- rev(sort(table(crime.abbv)))
top.30.abbvs <- sorted.crimes.abbvs[1:30]

# Write code to show the top 3 crimes each race is suspected of (rev(), 
# sort(), and table() are your friends here again, but you’ll have to subset the data by race 
# first).  Huh.  If you do this right, almost all the top 3’s should be the same, but a few are 
# different.  What are these differences?  

for(i in -1:6){
  if(i != 0){	
  	print(rev(sort(table(crime.abbv[snf$race == i])))[1:3])
  }
}
#-1 : FEL MIS CPW 
# 1 : FEL  MIS CPW  
# 2 : FEL  MIS  CPW
# 3 : FEL  MIS  CPW
# 4 : FEL  MIS  BUR
# 5 : FEL ROB MIS
# 6 : FEL ROB GLA

#I also tried this:
top.3 <- function(...){
	rev(sort(table(crime.abbv[snf$race == ... ])))[1:3]
}

top.three.by.race <- tapply(sort(crime.abbv), snf$race, top.3)
	
# however, I couldn't figure out how r was incrementing through the top 3 function and was given errors.  
# use a number but would be returned 6 tables with the same data 	 

# PART 2 

# Let’s create an “hour” variable that tells us what hour of the day each stop
# happened during and add it to our dataset.  How do we do this?  Well we’ve got a 
# great column of “time” variables that always has the hour in the same place.  Use 
# the substr() function we learned about above to strip out the hour, then use 
# as.numeric() from lecture 2 to convert it to a number.

hour <- substr(snf$time, 12, 13)
time.of.stop <- rev(sort(table(as.numeric(hour))))

# 20   21   19   22   18   16   15   17   23   14    1    0   13    2   12   11   10    3    9    4    8    5    7    6 
# 4607 4158 4141 3721 3387 3319 3228 3220 3209 3128 3057 3022 2490 2213 2181 2071 1572 1378 1218  905  740  477  324  323 

# Create a line plot (i.e. a plot with type=”l”) of the stops by hour.  Which hour of the 
# day has the most stops?  Which hour has the fewest?

time.of.stop <- (table(as.numeric(hour)))
color.vector <- rep(1,24)
color.vector[6] <- 2
color.vector[20] <- 3
plot(as.vector(time.of.stop), type="l", xlab="time of stop", ylab="number of stops")

# Create the same plot but with points instead of lines.  Use a different plotting 
# symbol than the default and color the max point and min points different colors
plot(as.vector(time.of.stop), type="o", xlab="time of stop", ylab="number of stops", col=color.vector)

