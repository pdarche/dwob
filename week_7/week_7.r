# PART ONE
#read in the files
snf <- read.csv(file="~/Desktop/dwob/week_7/snf_3.csv", as.is=T, h=T)
geo <- read.csv(file="~/Desktop/dwob/week_7/geo.csv", as.is=T, h=T)

#create a x,y column with paste
snf$xy <- paste(snf$x, ",", snf$y, sep="")

# Create an “xy” column in the geo.csv data frame using the same method.
geo$xy <- paste(geo$xcoord, ",", geo$ycoord, sep="")

# Merge the two datasets using the merge() function
snf.geo <- merge(snf, geo, by="xy")

# Let's map it
library('maps')
map('county', 'new york', xlim=c(-74.25026, -73.70196), ylim=c(40.50553, 40.91289), mar=c(0,0,0,0))

# PART TWO
# Use the points()  function to add the lat/lon points of every stop onto the map.  
points(snf.geo$lon, snf.geo$lat)

# Use the rgb() function from Lecture 7 to set the 
# color of the points so that they have some transparency. 
points(snf.geo$lon, snf.geo$lat, col=rgb(.9, 0, 0, .2), pch=19, cex=0.3)

# What do you see?
# I first notice that there seems to be an issue with alignment of the points and the map.
# I notice that activity is not evenly distributed throughout the city.  It appears to be 
# concentrated in certain parts of Manhattan, the Bronx, and Brooklyn.  

#  PART THREE
# Method One: 
snf.geo$race <- as.factor(snf.geo$race)
snf.geo$race <- as.numeric(snf.geo$race)
points(snf.geo$lon, snf.geo$lat, col=snf.geo$race, pch=19, cex=0.3)

color.frame <- as.data.frame()

# No matter which plot you made, what do you see?
# Again, there doesn't seem to be an even distribution of races.  

# PART FOUR
# Load up the animation library that we learned about in Lecture 7
library('animation')
library('lubridate')
snf.geo$time <- as.POSIXlt(snf.geo$time)
snf.geo$time <- mday(snf.geo$time)

saveHTML({ 
	for (i in 1:30) {
	  map('county', 'new york', xlim=c(-74.25026, -73.70196), ylim=c(40.50553, 40.91289), mar=c(0,0,0,0))
	  ith.day <- snf.geo[snf.geo$time == i,]  
	  points(ith.day$lon, ith.day$lat, col=2, pch=18, cex=0.8)
	  ani.pause()
}
})

# What do you see?
# There seems to be cycles or seasonality to the stops.  I also 
# notice that the distribution seems to fairly constant throughout
# (i.e. it seems to match the overall distribution fairly well) 